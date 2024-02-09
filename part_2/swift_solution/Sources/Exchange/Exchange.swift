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
    var orderFilepath: String?

    mutating func run() throws {
        let exchange = ExchangeLib.Exchange()

        let order = Parse(input: Substring.UTF8View.self, Order.init(participant:instrument:quantity:price:)) {
            Prefix { $0 != UInt8(ascii: ":") }.map { String(Substring($0)) }
            ":".utf8
            Prefix { $0 != UInt8(ascii: ":") }.map { String(Substring($0)) }
            ":".utf8
            Int.parser()
            ":".utf8
            Double.parser()
        }

        if let orderFilepath { 
            guard let file = freopen(orderFilepath, "r", stdin) else {
                fatalError("File at \(orderFilepath) not found.")
            }
            defer {
                fclose(file)
            }

            while let line = readLine()
            {
                if let o = try? order.parse(line) {
//                if let o = try? Order(fromString: line) {
                    for trade in exchange.insert(order: o) {
                        print(trade.toString())
                    }
                }
            }
        } else {
            while let line = readLine()
            {
                if let o = try? order.parse(line) {
                    for trade in exchange.insert(order: o) {
                        print(trade.toString())
                    }
                }
            }            
        }
    }
}


