import Foundation

public class Exchange
{
    var orderBooks : [StringHash : OrderBook] = [:]

    public init()
    {
    }

    public func insert(instrument: Instrument, order: consuming Buy) -> [Trade]
    {
        if orderBooks[instrument] == nil
        {
            orderBooks[instrument] = OrderBook(for: instrument)
        }
        
        return orderBooks[instrument]!.execute(consume order)
    }

    public func insert(instrument: Instrument, order: consuming Sell) -> [Trade]
    {
        if orderBooks[instrument] == nil
        {
            orderBooks[instrument] = OrderBook(for: instrument)
        }

        return orderBooks[instrument]!.execute(consume order)
    }
}
