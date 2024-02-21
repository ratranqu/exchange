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
        let trades = exchange.insert(instrument: "AUDUSD", order: Buy(participant: "A",quantity: 100,price: 1.47))
        XCTAssertEqual(trades.count, 0)
        XCTAssertEqual(exchange.orderBooks.count, 1)
    }

    func testInsertMultiple() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(participant: "A",quantity: 100,price: 1.47))
        trades += exchange.insert(instrument: "GBPUSD",order: Buy(participant: "B",quantity: 100,price: 1.47))
        trades += exchange.insert(instrument: "USDCAD",order: Buy(participant: "C",quantity: 100,price: 1.47))
        XCTAssertEqual(trades.count, 0)
        XCTAssertEqual(exchange.orderBooks.count, 3)
    }

    func testTrade() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(participant: "A",quantity: 100,price: 1.47))
        trades += exchange.insert(instrument: "AUDUSD",order: Sell(participant: "B",quantity: 100,price: 1.47))
        XCTAssertEqual(exchange.orderBooks.count, 1)
        XCTAssertEqual(trades.count, 1)
    }

    func testScenario1() throws
    {
        let exchange = Exchange()
        var trades: [Trade] = []
        trades += exchange.insert(instrument: "AUDUSD",order: Buy(participant: "A",quantity: 100,price: 1.47))
        trades += exchange.insert(instrument: "AUDUSD",order: Sell(participant: "B",quantity: 50,price: 1.45))
        XCTAssertEqual(trades.count, 1)
        XCTAssertEqual(trades[0].toString(), "A:B:AUDUSD:50:1.47")
    }

    func testScenario2() throws
    {
        let exchange = Exchange()

        var trades: [Trade] = []

        trades += exchange.insert(instrument: "GBPUSD",order: Buy(participant: "A",quantity: 100,price: 1.66))
        trades += exchange.insert(instrument: "EURUSD",order: Sell(participant: "B",quantity: 100,price: 1.11))
        trades += exchange.insert(instrument: "EURUSD",order: Sell(participant: "F",quantity: 50,price: 1.1))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(participant: "C",quantity: 10,price: 1.5))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(participant: "C",quantity: 20,price: 1.6))
        trades += exchange.insert(instrument: "GBPUSD",order: Sell(participant: "C",quantity: 20,price: 1.7))
        trades += exchange.insert(instrument: "EURUSD",order: Buy(participant: "D",quantity: 100,price: 1.11))


        XCTAssertEqual(trades.count, 4)
        XCTAssert(trades.contains { $0.toString() == "A:C:GBPUSD:10:1.66" })
        XCTAssert(trades.contains { $0.toString() == "A:C:GBPUSD:20:1.66" })
        XCTAssert(trades.contains { $0.toString() == "D:F:EURUSD:50:1.1" })
        XCTAssert(trades.contains { $0.toString() == "D:B:EURUSD:50:1.11" })

        XCTAssertEqual(trades[0].toString(), "A:C:GBPUSD:10:1.66")
        XCTAssertEqual(trades[1].toString(), "A:C:GBPUSD:20:1.66")
        XCTAssertEqual(trades[2].toString(), "D:F:EURUSD:50:1.1")
        XCTAssertEqual(trades[3].toString(), "D:B:EURUSD:50:1.11")
    }
}
