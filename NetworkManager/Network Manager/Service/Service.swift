//
//  Service.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func data(_ api: Route, log: Bool = false, completion: @escaping (Data?, Error?) -> Void) {
        task(api, log: log) { (data, _, error) in
            completion(data, HTTPError.invalidResponse(description: error?.localizedDescription))
        }
    }
    
    func json(_ api: Route, log: Bool = false, completion: @escaping (Any?, Error?) -> Void) {
        data(api, log: log) { (data, error) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func object<T: Decodable>(_ api: Route, log: Bool = false, completion: @escaping (T?, Error?) -> Void) {
        data(api, log: log) { (data, error) in
            if let data = data,
                let object = try? data.decoded(using: api.decoder) as T {
                completion(object, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func result<T: Decodable>(_ api: Route, log: Bool = false, completion: @escaping (HTTPResult<T>) -> Void) {
        task(api, log: log) { (data, response, networkError) in
            if let error = networkError {
                completion(.failure(error))
            } else if let data = data {
                do {
                    completion(.success(try data.decoded(using: api.decoder)))
                } catch {
                    if log || networkError != nil {
                        ServiceLogger.logSession(true, request: nil, data: nil, response: nil, error: error)
                    } else {
                        ServiceLogger.logSession(true, request: api.request, data: data, response: response, error: error)
                    }
                    completion(.failure(error))
                }
            }
        }
    }
    
    func task(_ api: Route, log: Bool = false, completion: @escaping (Data?, HTTPURLResponse? , Error?) -> Void) {
        guard let request = api.request else {
            DispatchQueue.main.async {
                ServiceLogger.logSession(true, request: nil, data: nil, response: nil, error: HTTPError.invalidRequest(description: nil))
                completion(nil, nil, HTTPError.invalidRequest(description: nil))
            }
            return
        }
        task(request, log: log, completion: completion)
    }
    
    func task(
        url: String,
        method: HTTPMethod = .get,
        headers: HTTPHeader = [:],
        data: Data? = nil,
        object: Encodable? = nil,
        encoding: HTTPEncoding = .json,
        completion: @escaping (Data?, HTTPURLResponse? , Error?) -> Void) {
            guard let request = URLRequest(url: URL(string: url),
                                     httpBody: data ?? object?.data,
                                     method: method,
                                     encoding: encoding,
                                     headers: headers) else {
            DispatchQueue.main.async {
                ServiceLogger.logSession(true, request: nil, data: nil, response: nil, error: HTTPError.invalidRequest(description: nil))
                completion(nil, nil, HTTPError.invalidRequest(description: nil))
            }
            return
        }
        task(request, log: true, completion: completion)
    }
    
    func task(_ request: URLRequest,
              log: Bool,
              completion: @escaping (Data?, HTTPURLResponse? , Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, resp, error) in
            let response = resp as? HTTPURLResponse
            ServiceLogger.logSession(log, request: request, data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
}
