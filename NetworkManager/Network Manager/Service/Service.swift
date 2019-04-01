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
        data(api, log: log) { (data) in
            if let data = data {
                completion(try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves))
            } else {
                completion(nil)
            }
        }
    }
    
    func object<T: Decodable>(_ api: Route, log: Bool = false, completion: @escaping (T) -> Void) {
        data(api, log: log) { (data) in
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
                        self.logSession(true, request: api.request, data: data, response: response, error: error)
                    }
                    completion(.failure(error))
                }
            }
        }
    }
    
    func task(_ api: Route, log: Bool = false, completion: @escaping (Data?, HTTPURLResponse? , Error?) -> Void) {
        guard let request = api.request else {
            completion(nil, nil, HTTPError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, resp, error) in
            let response = resp as? HTTPURLResponse
            self.logSession(log, request: api.request, data: data, response: response, error: error)
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
}
