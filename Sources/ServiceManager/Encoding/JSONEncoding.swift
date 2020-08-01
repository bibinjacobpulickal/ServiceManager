//
//  JSONEncoding.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 24/09/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public struct JSONEncoding: HTTPEncoding {

    public static var `default`: JSONEncoding { JSONEncoding() }

    public static var empty: JSONEncoding { JSONEncoding(options: []) }

    public static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }

    public static var fragmentsAllowed: JSONEncoding { JSONEncoding(options: .fragmentsAllowed) }

    @available(iOS 11.0, *)
    @available(OSX 10.13, *)
    public static var sortedKeys: JSONEncoding { JSONEncoding(options: .sortedKeys) }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public static var withoutEscapingSlashes: JSONEncoding { JSONEncoding(options: .withoutEscapingSlashes) }

    public let options: JSONSerialization.WritingOptions?

    public init(options: JSONSerialization.WritingOptions? = nil) {
        self.options = options
    }

    public func encode(_ urlRequest: URLRequestConvertible, with object: Encodable?, using encoder: AnyEncoder) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let object = object else { return urlRequest }

        do {
            if let options = options {

                let jsonObject = try object.jsonObject(using: encoder)

                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
            } else {

                urlRequest.httpBody = try object.encoded(using: encoder)
            }
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        if urlRequest.value(for: .contentType) == nil {
            urlRequest.setValue("application/json", for: .contentType)
        }

        return urlRequest
    }
}
