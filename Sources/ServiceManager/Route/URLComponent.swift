//
//  URLComponent.swift
//
//  Copyright © 2020 Bibin Jacob Pulickal (https://github.com/bibinjacobpulickal)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
