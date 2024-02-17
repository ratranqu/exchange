import Foundation

public class Exchange
{
    var orderBooks : [String : OrderBook3] = [:]

    public init()
    {
    }

    public func insert(order: Buy) -> [Trade]
    {
        var orderBook = orderBooks[order.instrument]

        if orderBook == nil
        {
            orderBook = OrderBook3()
            orderBooks[order.instrument] = orderBook
        }
        
        return orderBook!.execute(order)
    }

    public func insert(order: Sell) -> [Trade]
    {
        var orderBook = orderBooks[order.instrument]

        if orderBook == nil
        {
            orderBook = OrderBook3()
            orderBooks[order.instrument] = orderBook
        }

        return orderBook!.execute(order)
    }
}
