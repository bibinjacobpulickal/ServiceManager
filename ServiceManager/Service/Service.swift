//
//  Service.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 02/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public class Service {

    public static let shared = Service()

    public func result<Object: Decodable>(_ route: Route,
                                          log: Bool = false,
                                          _ completion: ((Result<Object, Error>) -> Void)? = nil) {
        dataResult(route) { result in
            switch result {
            case .success(let data):
                do {
                    let object = try route.decoder.decode(Object.self, from: data)
                    completion?(.success(object))
                } catch {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }

    public func result<Object: Decodable>(_ url: URLConvertible,
                                          method: HTTPMethod        = .get,
                                          headers: HTTPHeaders?     = nil,
                                          object: Encodable?        = nil,
                                          encoder: AnyEncoder       = JSONEncoder(),
                                          encoding: HTTPEncoding    = JSONEncoding.default,
                                          decoder: AnyDecoder       = JSONDecoder(),
                                          _ completion: ((Result<Object, Error>) -> Void)? = nil) {
        dataResult(url,
                   method: method,
                   headers: headers,
                   object: object,
                   encoder: encoder,
                   encoding: encoding) { result in
                    switch result {
                    case .success(let data):
                        do {
                            let object = try decoder.decode(Object.self, from: data)
                            completion?(.success(object))
                        } catch {
                            completion?(.failure(error))
                        }
                    case .failure(let error):
                        completion?(.failure(error))
                    }
        }
    }

    public func dataResult(_ route: Route,
                           log: Bool = false,
                           _ completion: ((Result<Data, Error>) -> Void)?  = nil) {
        do {
            let url              = try route.asURL()
            let parameters       = try route.object?.jsonObject(using: route.encoder) as? HTTPParameters
            let requestComponent = URLRequestConvertible(url: url, method: route.method, parameters: parameters,
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
            completion?(.failure(error))
        }
    }

    public func dataResult(_ url: URLConvertible,
                           method: HTTPMethod                              = .get,
                           headers: HTTPHeaders?                           = nil,
                           object: Encodable?                              = nil,
                           encoder: AnyEncoder                             = JSONEncoder(),
                           encoding: HTTPEncoding                          = JSONEncoding.default,
                           _ completion: ((Result<Data, Error>) -> Void)?  = nil) {
        do {
            let parameters       = try object?.jsonObject(using: encoder) as? HTTPParameters
            let requestComponent = URLRequestConvertible(url: url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            let request          = try requestComponent.asRequest()
            dataTask(request) { (data, urlResponse, error) in
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
            let task    = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                let httpUrlResponse = urlResponse as? HTTPURLResponse
                if log == true || error != nil || httpUrlResponse?.statusCode != 200 {
                    self.logSession(request, httpUrlResponse, error, data)
                }
                completion?(data, httpUrlResponse, error)
            }
            task.resume()
        } catch {
            logSession(nil, nil, error, nil)
            completion?(nil, nil, error)
        }
    }

    func logSession(_ request: URLRequest?, _ response: HTTPURLResponse?, _ error: Error?, _ data: Data?) {

        print("\(request?.httpMethod ?? "URL"):\t\(request?.url?.absoluteString ?? "Empty url string")")

        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Header:\t\(headers)")
        }
        if let data = request?.httpBody, !data.isEmpty {
            print("Body:\tSize: \(data)\n\(data.prettyPrittedString)")
        }
        if let error = error {
            print("Error:\t\(error.localizedDescription)")
        }
        if let data = data, !data.isEmpty {
            print("Response:\tSize: \(data)\n\(data.prettyPrittedString)")
        }
    }

    struct URLRequestConvertible: RequestConvertible {
        let url: URLConvertible
        let method: HTTPMethod
        let parameters: HTTPParameters?
        let encoding: HTTPEncoding
        let headers: HTTPHeaders?

        func asRequest() throws -> URLRequest {
            let request = try URLRequest(url: url, method: method, headers: headers)
            return try encoding.encode(request, with: parameters)
        }
    }
}

extension URLRequest {

    public init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders? = nil) throws {
        let url = try url.asURL()
        self.init(url: url)

        httpMethod = method.rawValue
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}
