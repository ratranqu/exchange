class OrderBook3
{
    let instrument: String
    var buyOrders: PriorityQueue<Buy> = PriorityQueue<Buy>(sort: <)

    var sellOrders: PriorityQueue<Sell> = PriorityQueue<Sell>(sort: <)

    init(for instrument: String) {
        self.instrument = instrument
    }

    public func execute(_ order: consuming Buy) -> [Trade]
    {
        var trades : [Trade] = []

        if sellOrders.isEmpty {
            buyOrders.push(consume order)
            return trades
        }

        var buy = consume order
        var sell = sellOrders.peek()!
        if buy.price < sell.price {
            // if no cross, we can return
            buyOrders.push(buy)
            return trades
        }
        let _ = sellOrders.pop()! // we are now certain the quantity will change because the prices will cross

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
                sell = s
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
        var trades : [Trade] = []

        if buyOrders.isEmpty {
            sellOrders.push(order)
            return trades
        }

        var buy = buyOrders.peek()!
        var sell = consume order
        if buy.price < sell.price {
            sellOrders.push(sell)
            return trades
        }

        let _ = buyOrders.pop()! // we are now certain the quantity will change because the prices will cross


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
                buy = b
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
