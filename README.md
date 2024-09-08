# npm-swift-example

expanding on examples here https://github.com/kabiroberai/node-swift

Async/Await JSON Serialization
```js
const promise = getJSON("SOME_URL");
promise.then((value) => {
    console.log(value);
  })
```

```swift

#NodeModule(exports: [
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
```