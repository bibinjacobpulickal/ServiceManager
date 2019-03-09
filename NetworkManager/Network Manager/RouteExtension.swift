//
//  RouteExtension.swift
//  Service Manager
//
//  Created by Bibin Jacob Pulickal on 04/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

typealias HTTPQuery = [String: String]?
typealias HTTPHeader = [String: String]?

extension Route {
    
    var queries: HTTPQuery {
        return nil
    }
    
    var method: HTTPMethod? {
        return nil
    }
    
    var encoding: HTTPEncoding? {
        return nil
    }
    
    var headers: HTTPHeader {
        return nil
    }
    
    var data: Data? {
        return nil
    }
    
    var json: Any? {
        return nil
    }
    
    var object: Encodable? {
        return nil
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        queries?.forEach({ (key, value) in
            let query = URLQueryItem(name: key, value: value)
            if components.queryItems?.append(query) == nil {
                components.queryItems = [query]
            }
        })
        return components
    }
    
    var httpBody: Data? {
        if let httpBody = data {
            return httpBody
        } else if let json = json {
            return try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } else if let object = object {
            return try? object.encoded(using: encoder)
        } else {
            return nil
        }
    }
    
    var urlRequest: URLRequest {
        guard let url = urlComponents.url else {
            fatalError("Error with url: \(urlComponents.url?.absoluteString ?? "")")
        }
        return URLRequest(url: url, httpBody: httpBody, method: method, encoding: encoding, headers: headers)
    }
    
    var encoder: AnyEncoder {
        return JSONEncoder()
    }
    
    var decoder: AnyDecoder {
        return JSONDecoder()
    }
}
