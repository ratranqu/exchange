public struct Trade: CustomStringConvertible
 {
     @usableFromInline
     let buyer: Participant
    @usableFromInline
     let seller: Participant
    @usableFromInline
     let instrument: Instrument
    @usableFromInline
     let quantity: Int32
    @usableFromInline
     let price: Double

    @inlinable
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

    @inlinable
     public var description: String {
         "\(buyer):\(seller):\(instrument):\(quantity):\(price)"
     }
 }


public var printer: (Participant, Participant, Instrument, Int32, Double) -> [Void] =
{ buyer, seller, instrument, quantity, price in
    print("\(buyer):\(seller):\(instrument):\(quantity):\(price)")
    return []
}
