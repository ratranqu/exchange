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
        let colon = UInt8(ascii: ":")
        let order  = Parse(input: Slice<UnsafeBufferPointer<UInt8>>.self) {
            Prefix { $0 != colon }//.map {Participant($0)}
            Skip { First() }
            Prefix { $0 != colon }//.map {Instrument.getOrderBook($0)}
            Skip { First() }
            Int32.parser()
            Skip { First() }
            Double.parser()
            Skip { Rest() }
        }
            .map {(Participant($0), Instrument.getOrderBook($1).1, $2, $3)}

        let file: UnsafeMutablePointer<FILE>
        if let orderFilepath {
            guard let orderFile = fopen(orderFilepath, "r") else {
                fatalError("File at \(orderFilepath) not found.")
            }
            file = orderFile
        } else {
            file = stdin
        }
        defer {
            if orderFilepath != nil {
                fclose(file)
            }
        }

        var buf = [CChar](repeating: 0, count: 128)

        while fgets(&buf, CInt(buf.count), file) != nil {
           let _ = buf.withUnsafeBufferPointer {
                $0.withMemoryRebound(to: UInt8.self, {
                    if let o = try? order.parse($0) {
                        if o.2 > 0 {
//                            o.1.execute(Buy(o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
                            o.1.execute(Buy(o.2, at: o.3, from: o.0), printer())//.map {print($0)}
                        } else {
//                            o.1.execute(Sell(-o.2, at: o.3, from: o.0), Trade.init).map {print($0)}
                            o.1.execute(Sell(-o.2, at: o.3, from: o.0), printer())//.map {print($0)}
                        }
                    }
                })
            }
        }
    }
}


