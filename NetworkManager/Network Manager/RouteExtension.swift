//
//  RouteExtension.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 04/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

// Computing properties
extension Route {
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        queries?.forEach { (key, value) in
            let query = URLQueryItem(name: key, value: value as? String)
            if components.queryItems?.append(query) == nil {
                components.queryItems = [query]
            }
        }
        return components
    }
    
    var httpBody: Data? {
        if encoding == .json {
            if let parameters = parameters {
                return try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } else if let object = object {
                return try? object.encoded(using: encoder)
            }
        }
        return data
    }
    
    var request: URLRequest {
        guard let url = components.url else {
            fatalError("Error with url: \(components.url?.absoluteString ?? "")")
        }
        if encoding == .form {
            let dataGenerator   = FormDataGenerator()
            var headers         = self.headers
            var httpBody        = self.httpBody
            
            headers?.updateValue("multipart/form-data; boundary=\(dataGenerator.boundary)", forKey: HTTPEncoding.contentTypeKey)
            httpBody = formDataFrom(dataGenerator)
            
            return URLRequest(url: url, httpBody: httpBody, method: method, encoding: encoding, headers: headers)
        }
        return URLRequest(url: url, httpBody: httpBody, method: method, encoding: encoding, headers: headers)
    }
    
    private func formDataFrom(_ generator: FormDataGenerator) -> Data {
        if let parameters = parameters {
            return generator.generateBody(parameters: parameters, formDataFiles: formDataFiles)
        } else if let parameters = object?.dictionary {
            return generator.generateBody(parameters: parameters, formDataFiles: formDataFiles)
        }
        return Data()
    }
}
