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

        let order  = Parse(input: ArraySlice<UInt8>.self) {
            Prefix { $0 != UInt8(ascii: ":") }.map { String(bytes: $0, encoding: .utf8) }
            StartsWith(":".utf8)
            Prefix { $0 != UInt8(ascii: ":") }.map { String(bytes: $0, encoding: .utf8) }
            StartsWith(":".utf8)
            Int.parser()
            StartsWith(":".utf8)
            Double.parser()
        }

        if let orderFilepath { 
            guard let file = freopen(orderFilepath, "r", stdin) else {
                fatalError("File at \(orderFilepath) not found.")
            }
            defer {
                fclose(file)
            }


            while let line = readLine().map({ ArraySlice($0.utf8) })
            {
                if let o = try? order.parse(line) {
                    if o.2 > 0 {
                        for trade in exchange.insert(order: Buy(participant: o.0 ?? "P", instrument: o.1 ?? "I", quantity: o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    } else {
                        for trade in exchange.insert(order: Sell(participant: o.0 ?? "P", instrument: o.1 ?? "I", quantity: -o.2, price: o.3)) {
                            print(trade.toString())
                        }  
                    }
                }
            }
        } else {
            while let line = readLine().map({ ArraySlice($0.utf8) })
            {
                if let o = try? order.parse(line) {
                    if o.2 > 0 {
                        for trade in exchange.insert(order: Buy(participant: o.0 ?? "P", instrument: o.1 ?? "I", quantity: o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    } else {
                        for trade in exchange.insert(order: Sell(participant: o.0 ?? "P", instrument: o.1 ?? "I", quantity: -o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    }
                }
            }
        }
    }
}


