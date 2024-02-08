
class OrderBook
{
    var buyOrders: PriorityQueue<Order> = PriorityQueue<Order>(sort: { (lhs, rhs) -> Bool in
       
        assert(lhs.quantity >= 0)
        assert(lhs.quantity >= 0)
        
        if rhs.price == lhs.price {
            return lhs.generation < rhs.generation;
        }
        
        return rhs.price < lhs.price
    })
    
    var sellOrders: PriorityQueue<Order> = PriorityQueue<Order>(sort: { (lhs, rhs) -> Bool in
        
        assert(lhs.quantity < 0)
        assert(rhs.quantity < 0)
        
        if lhs.price == rhs.price {
            return lhs.generation < rhs.generation
        }
        
        return lhs.price < rhs.price
    })


    public func execute(order: Order) -> [Trade]
    {
        var trades : [Trade] = []

        if order.isBuy
        {    
            buyOrders.push(order)
        }
        else
        {
            sellOrders.push(order)
        }
        
        while !buyOrders.isEmpty && !sellOrders.isEmpty
        {
            let buy = buyOrders.peek()!
            let sell = sellOrders.peek()!
        
            if buy.price < sell.price {
                break
            }
            
            let quantity = min(buy.remainingQuantity, sell.remainingQuantity)
            let price = buy.generation < sell.generation ? buy.price : sell.price

            trades.append(Trade(buyer: buy.participant,
                              seller: sell.participant,
                              instrument: buy.instrument,
                              quantity: quantity,
                              price: price)
            )                        
            
            if buy.remainingQuantity == quantity {
                let _ = buyOrders.pop()
            } else {
               buy.fill(amount:quantity) 
            }

            if sell.remainingQuantity == quantity {
                let _ = sellOrders.pop()
            } else {
               sell.fill(amount:quantity) 
            }
        }
        
        return trades
    }
}
