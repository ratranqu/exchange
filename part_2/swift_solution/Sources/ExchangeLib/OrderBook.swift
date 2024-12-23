class OrderBook
{
    let instrument: Instrument
    var buyOrders: PriorityQueue<Buy> = PriorityQueue<Buy>(sort: <)

    var sellOrders: PriorityQueue<Sell> = PriorityQueue<Sell>(sort: <)

    init(for instrument: Instrument) {
        self.instrument = instrument
    }

    public func execute(_ order: consuming Buy) -> [Trade]
    {

        if sellOrders.isEmpty || order.price < sellOrders.peek()!.price {
            // if no cross, we can return
            buyOrders.push(order)
            return []
        }

        var sell = sellOrders.pop()! // we are now certain the quantity will change because the prices will cross

        var buy = consume order
        var trades : [Trade] = []

        while true
        {
            let quantity = min(buy.quantity, sell.quantity)
            let price = buy.generation < sell.generation ? buy.price : sell.price

            trades.append(Trade(buyer: buy.participant,
                                seller: sell.participant,
                                instrument: instrument,
                                quantity: quantity,
                                price: price)
            )

            if buy.quantity == quantity { // full order filled
                if sell.quantity != quantity {
                    // if current best ask not filled, push remaining size back
                    sell.quantity -= quantity
                    sellOrders.push(sell)
                }
                break // done
            } else { // partial order filled
                buy.quantity -= quantity
                // try to get next best ask
                guard let s = sellOrders.pop() else {
                    // if none, push remaining buy order and done
                    buyOrders.push(buy)
                    break
                }
                sell = consume s
            }

            if buy.price < sell.price {
                // push the open incoming order to the book before returning
                buyOrders.push(buy)
                if sell.quantity != 0 {
                    // push the partially filled ask to the book before returning
                    sellOrders.push(sell)
                }
                break
            }
        }
        return trades
    }

    public func execute(_ order: consuming Sell) -> [Trade]
    {

        if buyOrders.isEmpty || buyOrders.peek()!.price < order.price {
            // if no cross, we can return
            sellOrders.push(order)
            return []
        }

        var buy = buyOrders.pop()! // we are now certain the quantity will change because the prices will cross

        var sell = consume order
        var trades : [Trade] = []

        while true
        {
            let quantity = min(buy.quantity, sell.quantity)
            let price = buy.generation < sell.generation ? buy.price : sell.price

            trades.append(Trade(buyer: buy.participant,
                                seller: sell.participant,
                                instrument: instrument,
                                quantity: quantity,
                                price: price)
            )


            if sell.quantity == quantity { // full order filled
                if buy.quantity != quantity { // if current best bid not filled, push remaining size back
                    buy.quantity -= quantity
                    buyOrders.push(buy)
                }
                break // done
            } else { // partial order filled
                sell.quantity -= quantity
                // try to get next best bid
                guard let b = buyOrders.pop() else {
                    // if none, push remaining sell order and done
                    sellOrders.push(sell)
                    break
                }
                buy = consume b
            }

            if buy.price < sell.price {
                // push the open incoming order to the book before returning
                sellOrders.push(sell)
                if buy.quantity != 0 {
                    // push the partially filled bid to the book before returning
                    buyOrders.push(buy)
                }
                break
            }
        }
        return trades
    }
}
