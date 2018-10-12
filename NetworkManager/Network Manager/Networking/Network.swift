//
//  Network.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

class Network {
    
    static let shared = Network()
    static let environment = NetworkEnvironment.production
    
    func route<T: Decodable>(api: API, log: Bool = false, completion: @escaping (T) -> Void) {
        route(api: api, log: log) { (response) in
            switch response {
            case .success(let data):
                if let object = try? data.decoded(using: api.decoder) as T {
                    if log { print("Successfully Decoded...") }
                    completion(object)
                }
            default:
                break
            }
        }
    }
    
    func route<T: Decodable>(api: API, log: Bool = false, completion: @escaping (Response<T>) -> Void) {
        route(api: api, log: log) { (response) in
            switch response {
            case .success(let data):
                if let object = try? data.decoded(using: api.decoder) as T {
                    if log { print("Successfully Decoded...") }
                    completion(.decoded(object))
                } else if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) {
                    completion(.serialized(json))
                } else {
                    completion(.failed(HTTPError.decodeError))
                }
            case .failure(let error):
                completion(.failed(error))
            }
        }
    }
    
    func route(api: API, log: Bool = false, completion: @escaping (HTTPResponse) -> Void) {
        
        guard let url = computeUrl(api: api) else {
            preconditionFailure("Error while computing url")
        }
        route(api: api, url: url, log: log) { (response) in
            completion(response)
        }
    }
    
    func route(string: StaticString, log: Bool = false, completion: @escaping (HTTPResponse) -> Void) {
        
        let url = URL(string: string)
        route(url: url, log: log) { (response) in
            completion(response)
        }
    }
    
    func route(api: API? = nil, url: URL, log: Bool = false, completion: @escaping (HTTPResponse) -> Void) {
        
        let request = computeUrlRequest(api: api, url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil || log {
                self.logSession(request, data, response, error)
            }
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
