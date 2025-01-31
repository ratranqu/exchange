//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 24/02/2024.
//

import Foundation
import Collections

public typealias StringHash = Int


public struct Exchange {
    public func execute(participant: borrowing Slice<UnsafeBufferPointer<UInt8>>,
                            instrument: borrowing Slice<UnsafeBufferPointer<UInt8>>,
                            quantity: Int32,
                            price: Double) -> [Trade] {
        
        
        if quantity > 0 {
            
        }
        return []
    }
}


public struct Instrument: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public let id: StringHash
    public var orderBook: OrderBook { get { return Instrument.orderBooks[id]!.1 }}

    public var description: String { get { return Instrument.orderBooks[id]!.0 }}

    private init(id: StringHash) {
        self.id = id
    }

    public init(_ value: borrowing String) {
        self.id = value.cString(using: .utf8)!.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })

        if !Instrument.orderBooks.keys.contains(self.id) {
            Instrument.orderBooks[self.id] = (copy value, OrderBook(for: Instrument(id: self.id)))
        }
        return
    }

    public init(stringLiteral value: borrowing StringLiteralType) {
        self.init(value)
    }

    public static func getOrderBook(_ name: borrowing Slice<UnsafeBufferPointer<UInt8>>) -> (Instrument, OrderBook) {
        let hash: StringHash = name.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })


        if let r = Instrument.orderBooks[hash] {
            return (Instrument(id: hash), r.1)
        } else {
            let ob = OrderBook(for: Instrument(id: hash))
            Instrument.orderBooks[hash] = (String(bytes: name, encoding: .utf8)!, ob)
            return (Instrument(id: hash), ob)
        }
    }

    static private var orderBooks : OrderedDictionary<StringHash, (String, OrderBook)> = [:]
}

public struct Participant: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public let id: StringHash

    public init(stringLiteral value: StringLiteralType) {
        self.id = value.cString(using: .utf8)!.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })
        
        if !Participant.byId.keys.contains(self.id) {
            Participant.byId[self.id] = value
        }
        return
    }

    public init(_ name: borrowing Slice<UnsafeBufferPointer<UInt8>>) {
        self.id = name.reduce(0, { partialResult, elt in
            31 &* partialResult &+ StringHash(elt)
        })

        if Participant.byId.keys.contains(self.id) {
            return
        } else {
            Participant.byId[self.id] = String(bytes: name, encoding: .utf8)
            return
        }
    }

    public var description: String { get { return "\(Participant.byId[id]!)" }}

    static private var byId : OrderedDictionary<StringHash, String> = [:]
}
