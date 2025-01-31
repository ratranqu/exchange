import XCTest
@testable import ExchangeLib

class OrderBookTests : XCTestCase
{
    func testInit()
    {
        let orderBook = OrderBook(for: "AAPL")

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.buyOrders.count, 0)
    }

    func testInsertBid() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        let trades = orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 1)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.buyOrders.min!
        XCTAssertEqual(one.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 100)
        XCTAssertEqual(one.price, 1.47)
    }

    func testInsertAsk() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        let trades = orderBook.execute(Sell(100, at: 1.47, from: "B"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 1)
        XCTAssertEqual(trades.count, 0)

        let two = orderBook.sellOrders.min!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 100)
        XCTAssertEqual(two.price, 1.47)
    }

    func testInsertBidsAtDifferentPricesAsc() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(200, at: 1.48, from: "B"), Trade.init)
        trades += orderBook.execute(Buy(300, at: 1.49, from: "C"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 3)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.buyOrders.popMin()!
        XCTAssertEqual(one.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 300)
        XCTAssertEqual(one.price, 1.49)

        let two = orderBook.buyOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 200)
        XCTAssertEqual(two.price, 1.48)

        let three = orderBook.buyOrders.popMin()!
        XCTAssertEqual(three.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 100)
        XCTAssertEqual(three.price, 1.47)
    }

    func testInsertBidsAtDifferentPricesDesc() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.49, from: "C"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 1.48, from: "B"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 3)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.buyOrders.popMin()!
        XCTAssertEqual(one.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 100)
        XCTAssertEqual(one.price, 1.49)

        let two = orderBook.buyOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 100)
        XCTAssertEqual(two.price, 1.48)

        let three = orderBook.buyOrders.popMin()!
        XCTAssertEqual(three.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 100)
        XCTAssertEqual(three.price, 1.47)
    }

    func testInsertBidsAtDifferentPricesUnordered() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 5, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 3, from: "B"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 4, from: "C"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 1, from: "E"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 6, from: "F"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 2, from: "G"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 6)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.buyOrders.popMin()!
        XCTAssertEqual(one.participant, "F")
        let two = orderBook.buyOrders.popMin()!
        XCTAssertEqual(two.participant, "A")
        let three = orderBook.buyOrders.popMin()!
        XCTAssertEqual(three.participant, "C")
        let four = orderBook.buyOrders.popMin()!
        XCTAssertEqual(four.participant, "B")
        let five = orderBook.buyOrders.popMin()!
        XCTAssertEqual(five.participant, "G")
        let six = orderBook.buyOrders.popMin()!
        XCTAssertEqual(six.participant, "E")

    }


    func testInsertAsksAtDifferentPricesAsc() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 1.49, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(200, at: 1.48, from: "B"), Trade.init)
        trades += orderBook.execute(Sell(300, at: 1.47, from: "C"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 3)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.sellOrders.popMin()!
        XCTAssertEqual(one.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 300)
        XCTAssertEqual(one.price, 1.47)

        let two = orderBook.sellOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 200)
        XCTAssertEqual(two.price, 1.48)

        let three = orderBook.sellOrders.popMin()!
        XCTAssertEqual(three.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 100)
        XCTAssertEqual(three.price, 1.49)
    }


    func testInsertAsksAtDifferentPricesDesc() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 1.47, from: "C"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1.48, from: "B"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1.49, from: "A"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 3)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.sellOrders.popMin()!
        XCTAssertEqual(one.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 100)
        XCTAssertEqual(one.price, 1.47)

        let two = orderBook.sellOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 100)
        XCTAssertEqual(two.price, 1.48)

        let three = orderBook.sellOrders.popMin()!
        XCTAssertEqual(three.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 100)
        XCTAssertEqual(three.price, 1.49)
    }

    func testInsertAsksAtDifferentPricesUnordered() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 5, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 3, from: "B"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 4, from: "C"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1, from: "E"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 6, from: "F"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 2, from: "G"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 6)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.sellOrders.popMin()!
        XCTAssertEqual(one.participant, "E")
        let two = orderBook.sellOrders.popMin()!
        XCTAssertEqual(two.participant, "G")
        let three = orderBook.sellOrders.popMin()!
        XCTAssertEqual(three.participant, "B")
        let four = orderBook.sellOrders.popMin()!
        XCTAssertEqual(four.participant, "C")
        let five = orderBook.sellOrders.popMin()!
        XCTAssertEqual(five.participant, "A")
        let six = orderBook.sellOrders.popMin()!
        XCTAssertEqual(six.participant, "F")

    }

    func testInsertBidsAtTheSamePrice() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(200, at: 1.47, from: "B"), Trade.init)
        trades += orderBook.execute(Buy(300, at: 1.47, from: "C"), Trade.init)
        XCTAssertEqual(orderBook.buyOrders.count, 3)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.buyOrders.popMin()!
        XCTAssertEqual(one.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 100)
        XCTAssertEqual(one.price, 1.47)

        let two = orderBook.buyOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 200)
        XCTAssertEqual(two.price, 1.47)

        let three = orderBook.buyOrders.popMin()!
        XCTAssertEqual(three.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 300)
        XCTAssertEqual(three.price, 1.47)
    }

    func testInsertAsksAtTheSamePrice() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(200, at: 1.47, from: "B"), Trade.init)
        trades += orderBook.execute(Sell(300, at: 1.47, from: "C"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 3)
        XCTAssertEqual(trades.count, 0)

        let one = orderBook.sellOrders.popMin()!
        XCTAssertEqual(one.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(one.quantity, 100)
        XCTAssertEqual(one.price, 1.47)

        let two = orderBook.sellOrders.popMin()!
        XCTAssertEqual(two.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(two.quantity, 200)
        XCTAssertEqual(two.price, 1.47)

        let three = orderBook.sellOrders.popMin()!
        XCTAssertEqual(three.participant, "C")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(three.quantity, 300)
        XCTAssertEqual(three.price, 1.47)
    }

    func testMatchNothing() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1.48, from: "B"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 1)
        XCTAssertEqual(orderBook.sellOrders.count, 1)
        XCTAssertEqual(trades.count, 0)

        let buy = orderBook.buyOrders.min!
        XCTAssertEqual(buy.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(buy.quantity, 100)
        XCTAssertEqual(buy.price, 1.47)

        let sell = orderBook.sellOrders.min!
        XCTAssertEqual(sell.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(sell.quantity, 100)
        XCTAssertEqual(sell.price, 1.48)
    }

    func testMatchBidExactly() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1.47, from: "B"), Trade.init)
        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 1)

        XCTAssertEqual(trades[0].buyer, "A")
        XCTAssertEqual(trades[0].seller, "B")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)
    }

    func testMatchAskExactly() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 1.47, from: "B"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 1)

        XCTAssertEqual(trades[0].buyer, "B")
        XCTAssertEqual(trades[0].seller, "A")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)
    }

    func testMatchBidPartial() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(250, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(100, at: 1.47, from: "B"), Trade.init)
        XCTAssertEqual(orderBook.buyOrders.count, 1)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 1)

        XCTAssertEqual(trades[0].buyer, "A")
        XCTAssertEqual(trades[0].seller, "B")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)

        let buy = orderBook.buyOrders.min!
        XCTAssertEqual(buy.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(buy.quantity, 150)
        XCTAssertEqual(buy.price, 1.47)
    }

    func testMatchAskPartial() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(250, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(100, at: 1.47, from: "B"), Trade.init)
        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 1)
        XCTAssertEqual(trades.count, 1)

        XCTAssertEqual(trades[0].buyer, "B")
        XCTAssertEqual(trades[0].seller, "A")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)

        let sell = orderBook.sellOrders.min!
        XCTAssertEqual(sell.participant, "A")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(sell.quantity, 150)
        XCTAssertEqual(sell.price, 1.47)
    }

    func testMatchBidMultiple() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Buy(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Buy(200, at: 1.46, from: "B"), Trade.init)
        trades += orderBook.execute(Sell(150, at: 1.46, from: "C"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 1)
        XCTAssertEqual(orderBook.sellOrders.count, 0)
        XCTAssertEqual(trades.count, 2)

        XCTAssertEqual(trades[0].buyer, "A")
        XCTAssertEqual(trades[0].seller, "C")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)

        XCTAssertEqual(trades[1].buyer, "B")
        XCTAssertEqual(trades[1].seller, "C")
        XCTAssertEqual(trades[1].instrument, "AUDUSD")
        XCTAssertEqual(trades[1].quantity, 50)
        XCTAssertEqual(trades[1].price, 1.46)

        let buy = orderBook.buyOrders.min!
        XCTAssertEqual(buy.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(buy.quantity, 150)
        XCTAssertEqual(buy.price, 1.46)
    }

    func testMatchAskMultiple() throws
    {
        let orderBook = OrderBook(for: "AUDUSD")

        var trades : [Trade] = []
        trades += orderBook.execute(Sell(100, at: 1.47, from: "A"), Trade.init)
        trades += orderBook.execute(Sell(200, at: 1.48, from: "B"), Trade.init)
        trades += orderBook.execute(Buy(150, at: 1.48, from: "C"), Trade.init)

        XCTAssertEqual(orderBook.buyOrders.count, 0)
        XCTAssertEqual(orderBook.sellOrders.count, 1)
        XCTAssertEqual(trades.count, 2)

        XCTAssertEqual(trades[0].buyer, "C")
        XCTAssertEqual(trades[0].seller, "A")
        XCTAssertEqual(trades[0].instrument, "AUDUSD")
        XCTAssertEqual(trades[0].quantity, 100)
        XCTAssertEqual(trades[0].price, 1.47)

        XCTAssertEqual(trades[1].buyer, "C")
        XCTAssertEqual(trades[1].seller, "B")
        XCTAssertEqual(trades[1].instrument, "AUDUSD")
        XCTAssertEqual(trades[1].quantity, 50)
        XCTAssertEqual(trades[1].price, 1.48)

        let sell = orderBook.sellOrders.min!
        XCTAssertEqual(sell.participant, "B")
        XCTAssertEqual(orderBook.instrument, "AUDUSD")
        XCTAssertEqual(sell.quantity, 150)
        XCTAssertEqual(sell.price, 1.48)
    }
}


