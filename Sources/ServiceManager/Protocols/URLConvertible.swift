//
//  URLConvertible.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 11/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol URLConvertible: RequestConvertible {
    func asURL() throws -> URL
}

public extension URLConvertible {

    func asRequest() throws -> URLRequest {
        try URLRequest(url: asURL())
    }
}

extension URL: URLConvertible {
    public func asURL() throws -> URL { self }
}

extension String: URLConvertible {

    public func asURL() throws -> URL {
        if let url = URL(string: self) {
            return url
        } else {
            throw HTTPError.invalidURL(url: self)
        }
    }
}

extension URLComponents: URLConvertible {

    public func asURL() throws -> URL {
        guard let url = url else { throw HTTPError.invalidURL(url: self) }
        return url
    }
}
