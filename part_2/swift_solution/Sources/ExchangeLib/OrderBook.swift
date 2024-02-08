
import SwiftPriorityQueue

class OrderBook
{
    var buyOrders: PriorityQueue<Order> = PriorityQueue<Order>(ascending: true)
    
    var sellOrders: PriorityQueue<Order> = PriorityQueue<Order>(ascending: false)
    
    public func execute(order: Order) -> [Trade]
    {
        var trades : [Trade] = []

        // TODO: should check first if new order is match or not before adding it
        if order.isBuy 
        {    
            buyOrders.push(order)
        }
        else
        {
            sellOrders.push(order)
        }
        
        // TODO: only new orders will trigger a trade, so should check first if
        // new order trigger a trade, and if not, just add and abort
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
