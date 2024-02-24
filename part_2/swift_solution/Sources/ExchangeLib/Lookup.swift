//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 24/02/2024.
//

import Foundation

public struct Instrument: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public var description: String { String(bytes: Self.byId[id]!, encoding: .utf8) ?? "" }

    private let id: Int

    private static var existing: Set<Int> = []
    private static var byId : [Int: ArraySlice<UInt8>] = [:]

    private static func getBy(_ name: ArraySlice<UInt8>) -> Self {
        let hash = name.hashValue
        if !Self.existing.contains(hash) {
            Self.existing.insert(hash)
            Self.byId[hash] = name
        }
        return Self(id: hash)
    }

    private init(id: Int) {
        self.id = id
    }

    public init(_ value: ArraySlice<UInt8>) {
        self = Self.getBy(value)
    }

    public init(_ value: consuming String) {
        self = Self.getBy(ArraySlice<UInt8>(value.utf8))
    }

    public init?(_ value: consuming String?) {
        guard let value else { return nil }
        self = Self.getBy(ArraySlice<UInt8>(value.utf8))
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }
}




public struct Participant: Hashable, CustomStringConvertible, ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public var description: String { String(bytes: Self.byId[id]!, encoding: .utf8) ?? "" }

    private let id: Int

    private static var existing: Set<Int> = []
    private static var byId : [Int: ArraySlice<UInt8>] = [:]

    private static func getBy(_ name: ArraySlice<UInt8>) -> Self {
        let hash = name.hashValue
        if !Self.existing.contains(hash) {
            Self.existing.insert(hash)
            Self.byId[hash] = name
        }
        return Self(id: hash)
    }

    private init(id: Int) {
        self.id = id
    }

    public init(_ value: ArraySlice<UInt8>) {
        self = Self.getBy(value)
    }

    public init(_ value: consuming String) {
        self = Self.getBy(ArraySlice<UInt8>(value.utf8))
    }

    public init?(_ value: consuming String?) {
        guard let value else { return nil }
        self = Self.getBy(ArraySlice<UInt8>(value.utf8))
    }

    public init(stringLiteral value: String) {
        self.init(value)
    }
}
