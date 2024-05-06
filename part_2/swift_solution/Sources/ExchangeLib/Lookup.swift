//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 24/02/2024.
//

import Foundation

public struct Instrument: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public var description: String { Self.byId[id] ?? "" }

    private let id: Int

    private static var existing: Set<Int> = []
    private static var byId : [Int: String] = [:]

    private static func getBy(_ name: Slice<UnsafeBufferPointer<UInt8>>) -> Self {
        let hash: Int = name.reduce(0, { partialResult, elt in
            31 &* partialResult &+ Int(elt)
        })

        if !Self.existing.contains(hash) {
            Self.existing.insert(hash)
            Self.byId[hash] = String(bytes: name, encoding: .utf8)
        }
        return Self(id: hash)
    }

    private init(id: Int) {
        self.id = id
    }

    public init(_ value: Slice<UnsafeBufferPointer<UInt8>>) {
        self = Self.getBy(value)
    }

    public init(_ value: consuming String) {
        self = Self.getBy(value.withUTF8({$0}).prefix(while: {_ in true}))
    }

    public init?(_ value: consuming String?) {
        guard let value else { return nil }
        self.init(value)
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }
}




public struct Participant: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public var description: String { Self.byId[id] ?? "" }

    private let id: Int

    private static var existing: Set<Int> = []
    private static var byId : [Int: String] = [:]

    private static func getBy(_ name: Slice<UnsafeBufferPointer<UInt8>>) -> Self {
        let hash: Int = name.reduce(0, { partialResult, elt in
            31 &* partialResult &+ Int(elt)
        })

        if !Self.existing.contains(hash) {
            Self.existing.insert(hash)
            Self.byId[hash] = String(bytes: name, encoding: .utf8)
        }
        return Self(id: hash)
    }

    private init(id: Int) {
        self.id = id
    }

    public init(_ value: Slice<UnsafeBufferPointer<UInt8>>) {
        self = Self.getBy(value)
    }

    public init(_ value: consuming String) {
        self = Self.getBy(value.withUTF8({$0}).prefix(while: {_ in true}))
    }

    public init?(_ value: consuming String?) {
        guard let value else { return nil }
        self.init(value)
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }
}
