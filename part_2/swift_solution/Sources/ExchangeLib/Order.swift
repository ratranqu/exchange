import Foundation

public struct Buy: Comparable {

    public let participant: String
    public let instrument: String
    public var quantity: Int
    public let price: Double
    public let generation: Int

    public init(participant: String, instrument: String, quantity: Int, price: Double, generation: Int = Generator.next) {
        self.participant = participant
        self.instrument = instrument
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    public static func < (lhs: borrowing Buy, rhs: borrowing Buy) -> Bool {
        lhs.price > rhs.price || (lhs.price == rhs.price && lhs.generation < rhs.generation)
    }
}


public struct Sell: Comparable {
    public let participant: String
    public let instrument: String
    public var quantity: Int
    public let price: Double
    public let generation: Int

    public init(participant: String, instrument: String, quantity: Int, price: Double, generation: Int = Generator.next) {
        self.participant = participant
        self.instrument = instrument
        self.quantity = quantity
        self.price = price
        self.generation = generation
    }

    public static func < (lhs: borrowing Sell, rhs: borrowing Sell) -> Bool {
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


public class Order: Comparable
{
    var participant: String
    var instrument: String
    var quantity: Int
    let isBuy: Bool
    var remainingQuantity: Int
    var price: Double
    var generation: Int
    
    private static var nextGeneration: Int = 0
    
    public init(participant: String, instrument: String, quantity: Int, price: Double) {
        precondition(quantity != 0)
        self.participant = participant
        self.instrument = instrument
        self.quantity = quantity
        self.isBuy = quantity > 0
        self.price = price
        self.remainingQuantity = abs(quantity)
        self.generation = Order.allocateGeneration()
    }

    public static func < (lhs: Order, rhs: Order) -> Bool {
        precondition(lhs.isBuy == rhs.isBuy)
        
        if rhs.price == lhs.price {
            return lhs.isBuy ? lhs.generation < rhs.generation : rhs.generation < lhs.generation;
        }
        
        return rhs.price < lhs.price
    }


    public static func == (lhs: Order, rhs: Order) -> Bool {
        
        return rhs.price == lhs.price 
            && rhs.participant == lhs.participant
            && rhs.instrument == lhs.instrument
            && rhs.remainingQuantity == lhs.remainingQuantity
        && rhs.isBuy == lhs.isBuy
    }
    
     convenience public init?(fromString string: String) throws
     {
         // <buyer/sellerid>:<instrument>:<signed quantity>:<limit price>
         // eg. A:AUDUSD:100:1.47

         let elements = string.components(separatedBy: ":")
       
         if elements.count < 4
         {
             return nil
         }

         guard let parsedQuantity = Int(elements[2].trimmingCharacters(in: .whitespacesAndNewlines)) else
         {
             throw OrderError.InvalidQuantity(elements[2])
         }
        
         guard let parsedPrice = Double(elements[3].trimmingCharacters(in: .whitespacesAndNewlines)) else
         {
             throw OrderError.InvalidPrice(elements[3])
         }

        self.init(participant: elements[0].trimmingCharacters(in: .whitespacesAndNewlines),
                  instrument: elements[1].trimmingCharacters(in: .whitespacesAndNewlines),
                  quantity: parsedQuantity, 
                  price: parsedPrice
        )
     }
    
    public func fill(amount: Int) {
        remainingQuantity -= amount;
    }
  
    private static func allocateGeneration() -> Int {
        nextGeneration = nextGeneration + 1
        return nextGeneration
    }
}

public enum OrderError : Error
{
    case UnableToParse(String)
    case InvalidQuantity(String)
    case InvalidPrice(String)
}
