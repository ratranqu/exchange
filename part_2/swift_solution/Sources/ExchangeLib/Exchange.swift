import Foundation

public class Exchange
{
    var orderBooks : [String : OrderBook3] = [:]

    public init()
    {
    }

    public func insert(instrument: String, order: consuming Buy) -> [Trade]
    {
        var orderBook = orderBooks[instrument]

        if orderBook == nil
        {
            orderBook = OrderBook3(for: instrument)
            orderBooks[instrument] = orderBook
        }
        
        return orderBook!.execute(consume order)
    }

    public func insert(instrument: String, order: consuming Sell) -> [Trade]
    {
        var orderBook = orderBooks[instrument]

        if orderBook == nil
        {
            orderBook = OrderBook3(for: instrument)
            orderBooks[instrument] = orderBook
        }

        return orderBook!.execute(order)
    }
}
