public struct Trade: CustomStringConvertible
 {
     let buyer: Participant
     let seller: Participant
     let instrument: Instrument
     let quantity: Int32
     let price: Double

    public init(buyer: Participant,
                seller: Participant,
                instrument: Instrument,
                quantity: Int32,
                price: Double)
    {
        self.buyer = buyer
        self.seller = seller
        self.instrument = instrument
        self.quantity = quantity
        self.price = price
    }

     public var description: String {
         "\(buyer):\(seller):\(instrument):\(quantity):\(price)"
     }
 }

public func printer() -> (Participant, Participant, Instrument, Int32, Double) -> [Void] {
    { buyer, seller, instrument, quantity, price in
        print("\(buyer):\(seller):\(instrument):\(quantity):\(price)")
        return []
    }
}
