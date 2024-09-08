import NodeAPI
import Foundation

#NodeModule(exports: [
    "nums": [Double.pi.rounded(.down), Double.pi.rounded(.up)],
    "str": String(repeating: "NodeSwift! ", count: 3),
    "add": try NodeFunction { (a: Double, b: Double) in
        print("calculating...")
        try await Task.sleep(nanoseconds: 500_000_000)
        return "\(a) + \(b) = \(a + b)"
    },
    "foo": try NodeFunction { (a: Bool) -> Bool in
        ExampleClass().bar(a)
    },
    "getJSON": try NodeFunction { (url: String) -> NodeObject? in
        do {
            let string = try await AnotherExampleClass().getJSON(url: url)
            return try NodeObject(coercing: NodeString(string))
        } catch {
            let error = error as NSError
            return try NodeError(code: "\(error.code)", message: error.description)
        }
    }
])

class ExampleClass {
    func bar(_ value: Bool) -> Bool {
        return !value
    }
}

class AnotherExampleClass {
    enum AnotherExampleClassErrorType: Error {
        case malformedURL(String)
        case invalidData(Data?)
    }

    func getJSON(
        url urlString: String
    ) async throws -> (String) {
        guard let url = URL(string: urlString) else {
            throw AnotherExampleClassErrorType.malformedURL(urlString)
        }
        guard let data = try? Data(contentsOf: url) else {
            throw AnotherExampleClassErrorType.malformedURL(urlString)
        }
        guard let string = String(data: data, encoding: .utf8) else {
            throw AnotherExampleClassErrorType.invalidData(data)
        }
        return string
    }
}
