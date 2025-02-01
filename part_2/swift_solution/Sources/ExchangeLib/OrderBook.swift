import Collections

public final class OrderBook
{
    @usableFromInline
    let instrument: Instrument
    @usableFromInline
    var buyOrders: Heap<Buy> = Heap<Buy>()
    @usableFromInline
    var sellOrders: Heap<Sell> = Heap<Sell>()

    init(for instrument: Instrument) {
        self.instrument = instrument
    }

    @inlinable
    public func execute<T>(_ order: consuming Buy, _ accumulator: (Participant, Participant, Instrument, Int32, Double) -> T) -> [T]
    {

        if sellOrders.isEmpty || order.price < sellOrders.min!.price {
            // if no cross, we can return
            buyOrders.insert(order)
            return []
        }

        var sell = sellOrders.removeMin() // we are now certain the quantity will change because the prices will cross

        var buy = consume order
        var trades: [T] = []
        while true
        {
            let quantity = min(buy.quantity, sell.quantity)
            let price = buy.generation < sell.generation ? buy.price : sell.price

            trades.append(accumulator(buy.participant, sell.participant, instrument, quantity, price))

            if buy.quantity == quantity { // full order filled
                if sell.quantity != quantity {
                    // if current best ask not filled, push remaining size back
                    sell.quantity -= quantity
                    sellOrders.insert(sell)
                }
                break // done
            } else { // partial order filled
                buy.quantity -= quantity
                // try to get next best ask
                guard let s = sellOrders.popMin() else {
                    // if none, push remaining buy order and done
                    buyOrders.insert(buy)
                    break
                }
                sell = consume s
            }

            if buy.price < sell.price {
                // push the open incoming order to the book before returning
                buyOrders.insert(buy)
                if sell.quantity != 0 {
                    // push the partially filled ask to the book before returning
                    sellOrders.insert(sell)
                }
                break
            }
        }
        return trades
    }

    @inlinable
    public func execute<T>(_ order: consuming Sell, _ accumulator: (Participant, Participant, Instrument, Int32, Double) -> T) -> [T]
    {

        if buyOrders.isEmpty || buyOrders.min!.price < order.price {
            // if no cross, we can return
            sellOrders.insert(order)
            return []
        }

        var buy = buyOrders.removeMin() // we are now certain the quantity will change because the prices will cross

        var sell = consume order
        var trades : [T] = []

        while true
        {
            let quantity = min(buy.quantity, sell.quantity)
            let price = buy.generation < sell.generation ? buy.price : sell.price

            trades.append(accumulator(buy.participant, sell.participant, instrument, quantity, price))

            if sell.quantity == quantity { // full order filled
                if buy.quantity != quantity { // if current best bid not filled, push remaining size back
                    buy.quantity -= quantity
                    buyOrders.insert(buy)
                }
                break // done
            } else { // partial order filled
                sell.quantity -= quantity
                // try to get next best bid
                guard let b = buyOrders.popMin() else {
                    // if none, push remaining sell order and done
                    sellOrders.insert(sell)
                    break
                }
                buy = consume b
            }

            if buy.price < sell.price {
                // push the open incoming order to the book before returning
                sellOrders.insert(sell)
                if buy.quantity != 0 {
                    // push the partially filled bid to the book before returning
                    buyOrders.insert(buy)
                }
                break
            }
        }
        return trades
    }
}
