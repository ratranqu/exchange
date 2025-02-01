import ExchangeLib
import ArgumentParser
import Foundation

#if os(Linux)
import Glibc
#else
import Darwin
#endif

@main
struct Runnner: ParsableCommand {

    @Argument(help: "The path of the order file.")
    var orderFilepath: String?

    mutating func run() throws {

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

        let exchange = Exchange()
        var buf = [CChar](repeating: 0, count: 128)

        while fgets(&buf, CInt(buf.count), file) != nil {
           let _ = buf.withUnsafeBufferPointer {
              $0.withMemoryRebound(to: UInt8.self, {
//                    let s = String(cString: $0.baseAddress!)
//                  let a = $0.split(separator: 58)
//                  print(String(bytes:a[1], encoding: .utf8))
                    exchange.insert($0)
                })
            }
        }
    }
}


