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

    public static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }

    public static var fragmentsAllowed: JSONEncoding { JSONEncoding(options: .fragmentsAllowed) }

    @available(iOS 11.0, *)
    @available(OSX 10.13, *)
    public static var sortedKeys: JSONEncoding { JSONEncoding(options: .sortedKeys) }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public static var withoutEscapingSlashes: JSONEncoding { JSONEncoding(options: .withoutEscapingSlashes) }

    public let options: JSONSerialization.WritingOptions

    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }

    public func encode(_ urlRequest: RequestConvertible, with parameters: HTTPParameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asRequest()

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            if urlRequest.value(for: .contentType) == nil {
                urlRequest.setValue("application/json", for: .contentType)
            }

            urlRequest.httpBody = data
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return urlRequest
    }

    public func encode(_ urlRequest: RequestConvertible, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asRequest()

        guard let jsonObject = jsonObject else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)

            if urlRequest.value(for: .contentType) == nil {
                urlRequest.setValue("application/json", for: .contentType)
            }

            urlRequest.httpBody = data
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return urlRequest
    }
}
