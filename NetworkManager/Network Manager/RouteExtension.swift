//
//  RouteExtension.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 04/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String: Any]
typealias HTTPHeader = [String: String]

extension Route {
    
    var parameters: HTTPParameters? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: HTTPEncoding? {
        return nil
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    var data: Data? {
        return nil
    }
    
    var object: Encodable? {
        return nil
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        if encoding == .url {
            parameters?.forEach({ (key, value) in
                let query = URLQueryItem(name: key, value: value as? String)
                if components.queryItems?.append(query) == nil {
                    components.queryItems = [query]
                }
            })
        }
        return components
    }
    
    var httpBody: Data? {
        if let httpBody = data {
            return httpBody
        } else if encoding == .json, let parameters = parameters {
            return try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } else if let object = object {
            return try? object.encoded(using: encoder)
        } else {
            return nil
        }
    }
    
    var request: URLRequest {
        guard let url = components.url else {
            fatalError("Error with url: \(components.url?.absoluteString ?? "")")
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
