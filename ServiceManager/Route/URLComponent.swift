//
//  URLComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol URLComponent: URLConvertible {

    // http, https etc.
    var scheme: HTTPScheme { get }

    // eg: www.google.com
    var host: String { get }

    // eg: /search
    var path: String { get }

    // eg: ["key": "item"]
    var queries: HTTPParameters? { get }
}

public extension URLComponent {

    var scheme: HTTPScheme {
        return .https
    }

    var queries: HTTPParameters? {
        return nil
    }
}

public extension URLComponent {

    func asURL() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        queries?.forEach { (key, value) in
            let query = URLQueryItem(name: key, value: "\(value)")
            if components.queryItems?.append(query) == nil {
                components.queryItems = [query]
            }
        }
        return try components.asURL()
    }
}
