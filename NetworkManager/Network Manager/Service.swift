//
//  Service.swift
//  Service Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func data(_ api: Route, log: Bool = false, completion: @escaping (Data?) -> Void) {
        task(api, log: log) { (data, _, _) in
            if data != nil {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
    
    func json(_ api: Route, log: Bool = false, completion: @escaping (Any?) -> Void) {
        task(api, log: log) { (data, _, _) in
            if let data = data {
                completion(try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves))
            } else {
                completion(nil)
            }
        }
    }
    
    func object<T: Decodable>(_ api: Route, log: Bool = false, completion: @escaping (T) -> Void) {
        task(api, log: log) { (data, _, _) in
            if let data = data,
                let object = try? data.decoded(using: api.decoder) as T {
                completion(object)
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
                        self.logSession(true, request: nil, data: nil, response: nil, error: error)
                    } else {
                        self.logSession(true, request: api.urlRequest, data: data, response: response, error: error)
                    }
                    completion(.failure(error))
                }
            }
        }
    }
    
    func task(_ api: Route, log: Bool = false, completion: @escaping (Data?, HTTPURLResponse? , Error?) -> Void) {
        URLSession.shared.dataTask(with: api.urlRequest) { (data, resp, error) in
            let response = resp as? HTTPURLResponse
            self.logSession(log, request: api.urlRequest, data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
}

private extension Service {
    
    private func logSession(_ log: Bool, request: URLRequest?, data: Data?, response: HTTPURLResponse?, error: Error?) {
        if !log && error == nil && (200..<300).contains(response?.statusCode ?? 0) { return }
        
        if let request = request {
            print("\n\(request.httpMethod ?? "URL"):", request)
        }
        
        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Headers:", headers)
        }
        if let data = request?.httpBody {
            print("Body:")
            printData(data)
        }
        if let response = response {
            print("Status Code:", response.statusCode)
        }
        if let data = data {
            print("Response:")
            printData(data)
        }
        if let error = error {
            logError(error)
        }
    }
    
    private func logError(_ error: Error) {
        if let error = error as? DecodingError {
            switch error {
            case .dataCorrupted(let context), .keyNotFound(_, let context), .valueNotFound(_, let context), .typeMismatch(_, let context):
                context.codingPath.forEach { (codingPath) in
                    print("Error Key:", codingPath.stringValue)
                }
                print("Error:", context.debugDescription)
            }
        } else {
            print("Error:", error.localizedDescription)
        }
    }
    
    private func printData(_ data: Data) {
        if let object = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            print(String(decoding: data, as: UTF8.self))
        } else {
            print(String(decoding: data, as: UTF8.self))
        }
    }
}
