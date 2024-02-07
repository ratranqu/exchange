import Foundation

public struct Order: Comparable
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
        self.remainingQuantity = quantity
        self.generation = Order.allocateGeneration()
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        precondition(lhs.isBuy == rhs.isBuy)
        
        if rhs.price == lhs.price {
            return lhs.generation < rhs.generation;
        }
        
        return rhs.price < lhs.price
    }
    
     public init?(fromString string: String) throws
     {
         // <buyer/sellerid>:<instrument>:<signed quantity>:<limit price>
         // eg. A:AUDUSD:100:1.47

         let elements = string.components(separatedBy: ":")
       
         if elements.count < 4
         {
             return nil
         }

         guard let parsedQuantity = Int(elements[2]) else
         {
             throw OrderError.InvalidQuantity(elements[2])
         }
        
         guard let parsedPrice = Double(elements[3]) else
         {
             throw OrderError.InvalidPrice(elements[3])
         }

         participant = elements[0]
         instrument = elements[1]
         quantity = parsedQuantity
         isBuy = quantity > 0
         remainingQuantity = abs(quantity)
         price = parsedPrice
         generation = Order.allocateGeneration()
     }
    
    public mutating func fill(amount: Int) {
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
