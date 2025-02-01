//
//  Exchange.swift
//  Exchange
//
//  Created by Alex Tran-Qui on 01/02/2025.
//

import Parsing
import Foundation


public protocol HasColonGrapheme {
    associatedtype Element: Equatable
    static var colon: Element { get }
}


//public struct Exchange<T: Collection & HasColonGrapheme> where T.Element == UInt8 {
//
//    private let order  = Parse(input: Slice<T>.self) {
//        Prefix { $0 != T.colon}
//        Skip { First() }
//        Prefix { $0 != T.colon }
//        Skip { First() }
//        Int32.parser()
//        Skip { First() }
//        Double.parser()
//        Skip { Rest() }
//    }
//        .map {(Participant($0), Instrument.getOrderBook($1).1, $2, $3)}
//
//    public func insert(_ message: borrowing T) {
//
//        if let o = try? Exchange.order.parse(message) {
//            if o.2 > 0 {
////              o.1.execute(Buy(o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
//                o.1.execute(Buy(o.2, at: o.3, from: o.0), printer())//.map {print($0)}
//            } else {
////              o.1.execute(Sell(-o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
//                o.1.execute(Sell(-o.2, at: o.3, from: o.0), printer())//.map {print($0)}
//            }
//        }
//    }
//}

public struct Exchange {

    @usableFromInline
    internal let order  = Parse(input: Slice<UnsafeBufferPointer<UInt8>>.self) {
        Prefix { $0 != UInt8(ascii: ":")}
        Skip { First() }
        Prefix { $0 != UInt8(ascii: ":") }
        Skip { First() }
        Int32.parser()
        Skip { First() }
        Double.parser()
        Skip { Rest() }
    }
        .map {(Participant($0), Instrument.getOrderBook($1).1, $2, $3, $0, $1)}

    @inlinable 
    public init() {}

    @inlinable
    public func insert(_ message: borrowing UnsafeBufferPointer<UInt8>) {

        if let o = try? order.parse(message) {
            if o.2 > 0 {
                //              o.1.execute(Buy(o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
                o.1.execute(Buy(o.2, at: o.3, from: o.0), printer)//.map {print($0)}
            } else {
                //              o.1.execute(Sell(-o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
                o.1.execute(Sell(-o.2, at: o.3, from: o.0), printer)//.map {print($0)}
            }
        }
    }
}
