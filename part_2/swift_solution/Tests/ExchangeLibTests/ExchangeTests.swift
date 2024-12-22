import XCTest
@testable import ExchangeLib

class ExchangeTests : XCTestCase
{
    func testDefaultInit()
    {
        let exchange = Exchange()

        XCTAssertEqual(exchange.orderBooks.count, 0)
    }

    func testInsert() throws
    {
        let exchange = Exchange()
        let trades = exchange.insert(instrument: "AUDUSD", order: Buy(100,at: 1.47, from: "A"))
        XCTAssertEqual(trades.count, 0)
        XCTAssertEqual(exchange.orderBooks.count, 1)
    }

    func testInsertMultiple() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(100,at: 1.47, from: "A"))
        trades += exchange.insert(instrument: "GBPUSD",order: Buy(100,at: 1.47, from: "B"))
        trades += exchange.insert(instrument: "USDCAD",order: Buy(100, at: 1.47, from: "C"))
        XCTAssertEqual(trades.count, 0)
        XCTAssertEqual(exchange.orderBooks.count, 3)
    }

    func testTrade() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(100,at: 1.47, from: "A"))
        trades += exchange.insert(instrument: "AUDUSD",order: Sell(100,at: 1.47, from: "B"))
        XCTAssertEqual(exchange.orderBooks.count, 1)
        XCTAssertEqual(trades.count, 1)
    }

    func testScenario1() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(100, at: 1.47, from: "A"))
        trades += exchange.insert(instrument: "AUDUSD",order: Sell(50, at: 1.45, from: "B"))
        XCTAssertEqual(trades.count, 1)
        XCTAssertEqual(trades[0].description, "A:B:AUDUSD:50:1.47")
    }

    func testScenario2() throws
    {
        let exchange = Exchange()

        var trades: [Trade] = []

        trades += exchange.insert(instrument: "GBPUSD",order: Buy(100, at: 1.66, from: "A"))
        trades += exchange.insert(instrument: "EURUSD",order: Sell(100, at: 1.11, from: "B"))
        trades += exchange.insert(instrument: "EURUSD",order: Sell(50, at: 1.1, from: "F"))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(10, at: 1.5, from: "C"))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(20, at: 1.6, from: "C"))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(20, at: 1.7, from: "C"))
        trades += exchange.insert(instrument: "EURUSD",order: Buy(100, at: 1.11, from: "D"))


        XCTAssertEqual(trades.count, 4)
        XCTAssert(trades.contains { $0.description == "A:C:GBPUSD:10:1.66" })
        XCTAssert(trades.contains { $0.description == "A:C:GBPUSD:20:1.66" })
        XCTAssert(trades.contains { $0.description == "D:F:EURUSD:50:1.1" })
        XCTAssert(trades.contains { $0.description == "D:B:EURUSD:50:1.11" })

        XCTAssertEqual(trades[0].description, "A:C:GBPUSD:10:1.66")
        XCTAssertEqual(trades[1].description, "A:C:GBPUSD:20:1.66")
        XCTAssertEqual(trades[2].description, "D:F:EURUSD:50:1.1")
        XCTAssertEqual(trades[3].description, "D:B:EURUSD:50:1.11")
    }
}
