//
//  HTTPEncoding.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 27/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]

public protocol HTTPEncoding {
    func encode(_ urlRequest: RequestConvertible, with object: Encodable?, using encoder: AnyEncoder) throws -> URLRequest
}

public protocol HTTPParameterEncoding: HTTPEncoding {
    func encode(_ urlRequest: RequestConvertible, with parameters: HTTPParameters?) throws -> URLRequest
}

extension HTTPParameterEncoding {

    public func encode(_ urlRequest: RequestConvertible, with object: Encodable?, using encoder: AnyEncoder) throws -> URLRequest {
        try encode(urlRequest, with: try object?.jsonObject(using: encoder) as? HTTPParameters)
    }
}
