import Foundation

public struct Buy: Comparable {

    public let participant: Participant
    public var quantity: Int32
    public let price: Double
    public let generation: Int

    public init(participant: Participant,
                quantity: Int32, price: Double, generation: Int = Generator.next) {
        self.participant = participant
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    public static func < (lhs: Buy, rhs: Buy) -> Bool {
        lhs.price > rhs.price || (lhs.price == rhs.price && lhs.generation < rhs.generation)
    }
}


public struct Sell: Comparable {
    public let participant: Participant
    public var quantity: Int32
    public let price: Double
    public let generation: Int

    public init(participant: Participant,
                quantity: Int32, price: Double, generation: Int = Generator.next) {
        self.participant = participant
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    public static func < (lhs: Sell, rhs: Sell) -> Bool {
        lhs.price < rhs.price || (lhs.price == rhs.price && lhs.generation < rhs.generation)
    }
}

public struct Generator {
    private static var _next: Int = 0

    public static var next: Int  {
        _next = _next + 1
        return _next
    }
}
