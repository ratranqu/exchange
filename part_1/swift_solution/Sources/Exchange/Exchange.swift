import ExchangeLib
import ArgumentParser
import Parsing

#if os(Linux)
import Glibc
#else
import Darwin
#endif

@main
struct Exchange: ParsableCommand {

    @Argument(help: "The path of the order file.")
    var orderFilepath: String = "test"

    mutating func run() throws {
        let exchange = ExchangeLib.Exchange()

        let order = Parse(input: Substring.self, Order.init(participant:instrument:quantity:price:)) {
            Prefix { $0 != ":" }.map(String.init)
            ":"
            Prefix { $0 != ":" }.map(String.init)
            ":"
            Int.parser()
            ":"
            Double.parser()
        }

        guard let file = freopen(orderFilepath, "r", stdin) else {
            fatalError("File at \(orderFilepath) not found.")
        }
        defer {
            fclose(file)
        }

        while let line = readLine()
        {
            if let o = try? order.parse(line) {
                exchange.insert(order: o)
            }
        }
        
        exchange.waitForTrades()
        for trade in exchange.trades
        {
            print(trade.toString())
        }
    }
}