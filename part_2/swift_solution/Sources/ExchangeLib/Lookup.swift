//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 24/02/2024.
//

import Foundation

public typealias StringHash = Int32

public typealias Instrument = StringHash
public typealias Participant = StringHash

private var byId : [StringHash: String] = [:]


public enum Lookup {
    public static func encode(_ name: Slice<UnsafeBufferPointer<UInt8>>) -> StringHash {
        let hash: StringHash = name.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })


        if byId.keys.contains(hash) {
            return hash
        } else {
            byId[hash] = String(bytes: name, encoding: .utf8)
        }

        return hash
    }

    public static func encode(_ name: borrowing String) -> StringHash {
        let hash: StringHash = name.cString(using: .utf8)!.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })

        if byId.keys.contains(hash) {
            return hash
        } else {
            byId[hash] = copy name
        }
        return hash
    }

    public static func decode(_ value: StringHash) -> String {
        byId[value] ?? ""
    }

}
