import Foundation

public class Order
{
    let participant : String
    let instrument : String
    var quantity : Int
    let price : Double

    public init(fromString string: String) throws
    {
        // <buyer/sellerid>:<instrument>:<signed quantity>:<limit price>
        // eg. A:AUDUSD:100:1.47

        var elements =  string.components(separatedBy: ":")
        if elements.count < 4
        {
            throw OrderError.UnableToParse(string)
        }

        elements = elements.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

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
        price = parsedPrice
    }

    public init(participant: String, instrument: String, quantity: Int, price: Double) {
        precondition(quantity != 0)
        self.participant = participant
        self.instrument = instrument
        self.quantity = quantity
        self.price = price
    }

}

public enum OrderError : Error
{
    case UnableToParse(String)
    case InvalidQuantity(String)
    case InvalidPrice(String)
}
