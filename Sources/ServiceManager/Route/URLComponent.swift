//
//  URLComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol URLComponent: URLConvertible {

    // http, https etc, defaults to https.
    var scheme: HTTPScheme { get }

    // eg: www.google.com
    var host: String { get }

    // eg: /search
    var path: String { get }

    // eg: ["key": "item"], defaults to nil.
    var queries: Encodable? { get }
}

public extension URLComponent {

    var scheme: HTTPScheme { .https }

    var queries: Encodable? { nil }
}

public extension URLComponent {

    func asURL() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        if let queries = try queries?.jsonObject() as? Parameters {
            for (key, value) in queries {
                let query = URLQueryItem(name: key, value: "\(value)")
                if components.queryItems?.append(query) == nil {
                    components.queryItems = [query]
                }
            }
        }
        return try components.asURL()
    }
}
