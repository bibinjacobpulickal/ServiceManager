//
//  RequestComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol RequestComponent: RequestConvertible {

    // URLRequest method eg: GET, POST etc. Defaults to get.
    var method: HTTPMethod { get }

    // URLRequest httpBody of type data. Defaults to nil.
    var body: Data? { get }

    // URLRequest headers eg: ["Authorization": "Bearer..."]. Defaults to nil.
    var headers: HTTPHeaders? { get }

    // URLRequest object. Defaults to nil
    var object: Encodable? { get }

    // URLRequest object encoder. Defaults to JSONEncoder().
    var encoder: AnyEncoder { get }

    // URLRequest object encoding. Defaults to URLEncoding.default.
    var encoding: HTTPEncoding { get }
}

public extension RequestComponent {

    var method: HTTPMethod { .get }

    var body: Data? { nil }

    var headers: HTTPHeaders? { nil }

    var object: Encodable? { nil }

    var encoder: AnyEncoder { JSONEncoder() }

    var encoding: HTTPEncoding { URLEncoding.default }
}
