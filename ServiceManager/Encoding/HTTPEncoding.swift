//
//  HTTPEncoding.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 27/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public typealias Parameters = [String: Any]

public protocol HTTPEncoding {

    func encode(_ urlRequest: RequestConvertible, with parameters: Parameters?) throws -> URLRequest
}
