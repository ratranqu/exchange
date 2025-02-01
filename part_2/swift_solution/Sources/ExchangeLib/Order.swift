import Foundation

public struct Buy: Comparable {

    public let participant: Participant
    public var quantity: Int32
    public let price: Double
    public let generation: Int

    @inlinable
    public init(_ quantity: Int32, at price: Double, from participant: Participant, generation: Int = Generator.next) {
        self.participant = participant
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    @inlinable public static func < (lhs: borrowing Buy, rhs: borrowing Buy) -> Bool {
        let lp = lhs.price
        let rp = rhs.price
        if lp > rp { return true }
        else if lp == rp {
            let lg = lhs.generation
            let rg = rhs.generation
            return lg < rg
        }
        return false
    }
}


public struct Sell: Comparable {
    public let participant: Participant
    public var quantity: Int32
    public let price: Double
    public let generation: Int

    @inlinable
    public init(_ quantity: Int32, at price: Double, from participant: Participant, generation: Int = Generator.next) {
        self.participant = participant
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    @inlinable
    public static func < (lhs: borrowing Sell, rhs: borrowing Sell) -> Bool {
        let lp = lhs.price
        let rp = rhs.price
        if lp < rp { return true }
        else if lp == rp {
            let lg = lhs.generation
            let rg = rhs.generation
            return lg < rg
        }
        return false
    }
}

public struct Generator {
    private static var _next: Int = 0

    public static var next: Int  {
        _next = _next + 1
        return _next
    }
}
