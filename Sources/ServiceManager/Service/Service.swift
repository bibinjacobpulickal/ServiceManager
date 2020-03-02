//
//  Service.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 02/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public class Service {

    public static let shared = Service()

    public func result<Object: Decodable>(_ route: Route,
                                          log: Bool = false,
                                          _ completion: ((Result<Object, Error>) -> Void)? = nil) {
        dataResult(route, log: log) { [weak self] result in
            self?.decodeDataResult(result, using: route.decoder, completion)
        }
    }

    public func result<Object: Decodable>(_ url: URLConvertible,
                                          method: HTTPMethod     = .get,
                                          body: Data?            = nil,
                                          headers: HTTPHeaders?  = nil,
                                          object: Encodable?     = nil,
                                          encoder: AnyEncoder    = JSONEncoder(),
                                          encoding: HTTPEncoding = URLEncoding.default,
                                          decoder: AnyDecoder    = JSONDecoder(),
                                          _ completion: ((Result<Object, Error>) -> Void)? = nil) {
        dataResult(url,
                   method: method,
                   body: body,
                   headers: headers,
                   object: object,
                   encoder: encoder,
                   encoding: encoding) { [weak self] result in
                    self?.decodeDataResult(result, using: decoder, completion)
        }
    }

    private func decodeDataResult<Object: Decodable>(_ result: Result<Data, Error>,
                                                     using decoder: AnyDecoder = JSONDecoder(),
                                                     _ completion: ((Result<Object, Error>) -> Void)? = nil) {
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

    public func dataResult(_ route: Route,
                           log: Bool = false,
                           _ completion: ((Result<Data, Error>) -> Void)?  = nil) {
        do {
            let url              = try route.asURL()
            let parameters       = try route.object?.jsonObject(using: route.encoder) as? HTTPParameters
            let requestComponent = URLRequestConvertible(url: url, method: route.method, body: route.body, parameters: parameters,
                                                         encoding: route.encoding, headers: route.headers)
            let request          = try requestComponent.asRequest()
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

    public func dataResult(_ url: URLConvertible,
                           method: HTTPMethod     = .get,
                           body: Data?            = nil,
                           headers: HTTPHeaders?  = nil,
                           object: Encodable?     = nil,
                           encoder: AnyEncoder    = JSONEncoder(),
                           encoding: HTTPEncoding = URLEncoding.default,
                           _ completion: ((Result<Data, Error>) -> Void)? = nil) {
        do {
            let parameters       = try object?.jsonObject(using: encoder) as? HTTPParameters
            let requestComponent = URLRequestConvertible(url: url, method: method, body: body, parameters: parameters, encoding: encoding, headers: headers)
            let request          = try requestComponent.asRequest()
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

    public func dataTask(_ request: RequestConvertible,
                         log: Bool = false,
                         _ completion: ((Data?, HTTPURLResponse?, Error?) -> Void)? = nil) {
        do {
            let request = try request.asRequest()
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

    func logSession(log: Bool, request: URLRequest?, response: HTTPURLResponse?, error: Error?, data: Data?) {

        if log == false && error == nil && !(200..<300).contains(response?.statusCode ?? 0) {
            return
        }
        if request != nil {
            print("\(request?.httpMethod ?? "URL"):\t\t\(request?.url?.absoluteString ?? "Empty url string")")
        }
        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Header:\t\(headers)")
        }
        if let data = request?.httpBody, !data.isEmpty {
            print("Body:\tSize: \(data)\n\(data.prettyPrittedString)")
        }
        if let data = data, !data.isEmpty {
            print("Response:\tSize: \(data)\n\(data.prettyPrittedString)")
        }
        if let error = error {
            print("Error:\t\(error.localizedDescription)")
        }
    }

    struct URLRequestConvertible: RequestConvertible {
        let url: URLConvertible
        let method: HTTPMethod
        let body: Data?
        let parameters: HTTPParameters?
        let encoding: HTTPEncoding
        let headers: HTTPHeaders?

        func asRequest() throws -> URLRequest {
            let request = try URLRequest(url: url, method: method, body: body, headers: headers)
            return try encoding.encode(request, with: parameters)
        }
    }
}

extension URLRequest {

    public init(url: URLConvertible, method: HTTPMethod, body: Data? = nil, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()
        self.init(url: url)

        httpMethod = method.value
        httpBody   = body
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}
