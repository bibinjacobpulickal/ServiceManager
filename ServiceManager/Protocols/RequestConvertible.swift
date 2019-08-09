//
//  RequestConvertible.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 11/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol RequestConvertible {
    func asRequest() throws -> URLRequest
}

extension URLRequest: RequestConvertible {
    public func asRequest() throws -> URLRequest { return self }
}
