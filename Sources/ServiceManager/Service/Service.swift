//
//  Service.swift
//
//  Copyright © 2020 Bibin Jacob Pulickal (https://github.com/bibinjacobpulickal)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public typealias ServiceResult<Object> = Result<Object, Error>
public typealias ServiceCompletion<Object> = ((Result<Object, Error>) -> Void)?

public class Service {

    public static let shared = Service()

    public func result<Object: Decodable>(_ route: Route,
                                          log: Bool = false,
                                          _ completion: ServiceCompletion<Object> = nil) {
        dataResult(route, log: log) { [weak self] result in
            self?.decodeDataResult(result, using: route.decoder, completion)
        }
    }

    public func result<Object: Decodable>(
        _ url: URLConvertible,
        method: HTTPMethod       = .get,
        body: DataConvertible?   = nil,
        headers: HTTPHeaders?    = nil,
        object: Encodable?       = nil,
        encoder: AnyEncoder      = JSONEncoder(),
        encoding: HTTPEncoding   = JSONEncoding.default,
        decoder: AnyDecoder      = JSONDecoder(),
        _ completion: ServiceCompletion<Object> = nil) {
        dataResult(
            url,
            method: method,
            body: body,
            headers: headers,
            object: object,
            encoder: encoder,
            encoding: encoding) { [weak self] result in
                self?.decodeDataResult(result, using: decoder, completion)
        }
    }

    private func decodeDataResult<Object: Decodable>(
        _ result: Result<Data, Error>,
        using decoder: AnyDecoder = JSONDecoder(),
        _ completion: ServiceCompletion<Object> = nil) {
        switch result {
        case .success(let data):
            do {
                completion?(.success(try data.decoded(using: decoder)))
            } catch {
                switch error {
                case DecodingError.keyNotFound(_, let context),
                     DecodingError.valueNotFound(_, let context),
                     DecodingError.typeMismatch(_, let context):
                    print("Decoding Error:-")
                    context.codingPath.forEach { codingKey in
                        print("\tKey:\t\t\"\(codingKey.stringValue)\"")
                    }
                    print("\tDescription:", context.debugDescription)
                default:
                    print(error.localizedDescription)
                }
                completion?(.failure(error))
            }
        case .failure(let error):
            completion?(.failure(error))
        }
    }

    public func dataResult(
        _ route: Route,
        log: Bool = false,
        _ completion: ServiceCompletion<Data>  = nil) {
        do {
            let url              = try route.asURL()
            let requestComponent = RequestConvertible(
                url: url, method: route.method, body: route.body,
                object: route.object, encoder: route.encoder,
                encoding: route.encoding, headers: route.headers)
            let request          = try requestComponent.asURLRequest()
            dataTask(request, log: log) { (data, urlResponse, error) in
                if let error = error {
                    completion?(.failure(error))
                } else if let data = data {
                    completion?(.success(data))
                }
            }
        } catch {
            logSession(log: true, request: nil, response: nil, error: error, data: nil)
            completion?(.failure(error))
        }
    }

    public func dataResult(
        _ url: URLConvertible,
        method: HTTPMethod       = .get,
        body: DataConvertible?   = nil,
        headers: HTTPHeaders?    = nil,
        object: Encodable?       = nil,
        encoder: AnyEncoder      = JSONEncoder(),
        encoding: HTTPEncoding   = JSONEncoding.default,
        _ completion: ServiceCompletion<Data> = nil) {
        do {
            let requestComponent = RequestConvertible(
                url: url, method: method, body: body,
                object: object, encoder: encoder,
                encoding: encoding, headers: headers)
            let request          = try requestComponent.asURLRequest()
            dataTask(request, log: true) { (data, urlResponse, error) in
                if let error = error {
                    completion?(.failure(error))
                } else if let data = data {
                    completion?(.success(data))
                }
            }
        } catch {
            completion?(.failure(error))
        }
    }

    public func dataTask(
        _ request: URLRequestConvertible,
        log: Bool = false,
        _ completion: ((Data?, HTTPURLResponse?, Error?) -> Void)? = nil) {
        do {
            let request = try request.asURLRequest()
            let task    = URLSession.shared.dataTask(with: request) { [weak self] (data, urlResponse, error) in
                let httpUrlResponse = urlResponse as? HTTPURLResponse
                self?.logSession(log: log, request: request, response: httpUrlResponse, error: error, data: data)
                DispatchQueue.main.async { completion?(data, httpUrlResponse, error) }
            }
            task.resume()
        } catch {
            logSession(log: log, request: nil, response: nil, error: error, data: nil)
            completion?(nil, nil, error)
        }
    }

    func logSession(log: Bool, request: URLRequestConvertible?, response: HTTPURLResponseConvertible?, error: Error?, data: Data?) {

        if log == false && error == nil && (200..<300).contains((try? response?.asHTTPURLResponse())?.statusCode ?? 0) {
            return
        }
      if let request = try? request?.asURLRequest() {
        print("\(request.httpMethod ?? "URL"):\t\t\(request.url?.absoluteString ?? "Empty url string")")
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
          print("Header:\t\t\(headers)")
        }
        if let data = request.httpBody, !data.isEmpty {
          print("Body:\t\tSize: \(data)\n\(data.prettyPrintedString)")
        }
      }
      if let statusCode = (try? response?.asHTTPURLResponse())?.statusCode {
            print("Status Code: \t\(statusCode)")
        }
        if let data = data, !data.isEmpty {
            print("Response:\t\tSize: \(data)\n\(data.prettyPrintedString)")
        }
        if let error = error {
            print("Error:\t\t\(error.localizedDescription)")
        }
    }

    struct RequestConvertible: URLRequestConvertible {
        let url: URLConvertible
        let method: HTTPMethod
        let body: DataConvertible?
        let object: Encodable?
        let encoder: AnyEncoder
        let encoding: HTTPEncoding
        let headers: HTTPHeaders?

        func asURLRequest() throws -> URLRequest {
            let request = try URLRequest(url: url, method: method, body: body, headers: headers)
            return try encoding.encode(request, with: object, using: encoder)
        }
    }
}

extension URLRequest {
    /// Creates an instance with the specified `url`, `method`, and `headers`.
    ///
    /// - Parameters:
    ///   - url:     The `URLConvertible` value.
    ///   - method:  The `HTTPMethod`.
    ///   - headers: The `HTTPHeaders`, `nil` by default.
    /// - Throws:    Any error thrown while converting the `URLConvertible` to a `URL`.
    public init(url: URLConvertible, method: HTTPMethod, body: DataConvertible?, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()

        self.init(url: url)

        httpMethod          = method.rawValue
        httpBody            = try body?.asData()
        allHTTPHeaderFields = headers?.dictionary
    }
}
