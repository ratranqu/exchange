import ExchangeLib
import ArgumentParser
import Parsing
import Foundation

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
            Prefix { $0 != UInt8(ascii: ":") }
            StartsWith(":".utf8)
            Prefix { $0 != UInt8(ascii: ":") }
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

//            let data: Data = fg

            while let line = readLine().map({ ArraySlice($0.utf8) })
            {
                if let o = try? order.parse(line), let instrument = String(bytes: o.1, encoding: .utf8), let participant = String(bytes: o.0, encoding: .utf8) {
                    if o.2 > 0 {
                        for trade in exchange.insert(instrument: instrument,
                                                     order: Buy(participant: participant,
//                                                                instrument: o.1 ?? "I",
                                                                quantity: o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    } else {
                        for trade in exchange.insert(instrument: instrument,
                                                     order: Sell(participant: participant,
//                                                                 instrument: o.1 ?? "I",
                                                                 quantity: -o.2, price: o.3)) {
                            print(trade.toString())
                        }  
                    }
                }
            }
        } else {
            while let line = readLine().map({ ArraySlice($0.utf8) })
            {
                if let o = try? order.parse(line), let instrument = String(bytes: o.1, encoding: .utf8), let participant = String(bytes: o.0, encoding: .utf8) {
                    if o.2 > 0 {
                        for trade in exchange.insert(instrument: instrument,
                                                     order: Buy(participant: participant,
//                                                                instrument: o.1 ?? "I",
                                                                quantity: o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    } else {
                        for trade in exchange.insert(instrument: instrument,
                                                     order: Sell(participant: participant,
//                                                                 instrument: o.1 ?? "I",
                                                                 quantity: -o.2, price: o.3)) {
                            print(trade.toString())
                        }
                    }
                }
            }
        }
    }
}


