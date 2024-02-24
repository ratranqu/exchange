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

        let order  = Parse(input: Slice<UnsafeBufferPointer<UInt8>>.self) {
            Prefix { $0 != UInt8(ascii: ":") }.map {ArraySlice<UInt8>($0)}
            StartsWith(":".utf8)
            Prefix { $0 != UInt8(ascii: ":") }.map {ArraySlice<UInt8>($0)}
            StartsWith(":".utf8)
            Int.parser()
            StartsWith(":".utf8)
            Double.parser()
            Skip { Rest() }
        }

        if let orderFilepath {
            guard let file = freopen(orderFilepath, "r", stdin) else {
                fatalError("File at \(orderFilepath) not found.")
            }
            defer {
                fclose(file)
            }

            var buf = [CChar](repeating: 0, count: 128)

            while fgets(&buf, CInt(buf.count), file) != nil {
                let _ = buf.withUnsafeBufferPointer {
                    $0.withMemoryRebound(to: UInt8.self, {
                        if let o = try? order.parse($0), let instrument = String(bytes: o.1, encoding: .utf8), let participant = String(bytes: o.0, encoding: .utf8) {
                            if o.2 > 0 {
                                for trade in exchange.insert(instrument: instrument,
                                                           order: Buy(participant:   participant,
                                                            quantity: o.2, price: o.3)) {
                                    print(trade.toString())
                                }
                            } else {
                                for trade in exchange.insert(instrument: instrument,
                                                             order: Sell(participant: participant,
                                                            quantity: -o.2, price: o.3)) {
                                    print(trade.toString())
                                }
                            }
                        }
                    })
                }
            }
        } else {
            var buf = [CChar](repeating: 0, count: 128)

            while fgets(&buf, CInt(buf.count), stdin) != nil {
                let _ = buf.withUnsafeBufferPointer {
                    $0.withMemoryRebound(to: UInt8.self, {
                        if let o = try? order.parse($0), let instrument = String(bytes: o.1, encoding: .utf8), let participant = String(bytes: o.0, encoding: .utf8) {
                            if o.2 > 0 {
                                for trade in exchange.insert(instrument: instrument,
                                                             order: Buy(participant:   participant,
                                                                        quantity: o.2, price: o.3)) {
                                    print(trade.toString())
                                }
                            } else {
                                for trade in exchange.insert(instrument: instrument,
                                                             order: Sell(participant: participant,
                                                                         quantity: -o.2, price: o.3)) {
                                    print(trade.toString())
                                }
                            }
                        }
                    })
                }
            }  
        }
    }
}


