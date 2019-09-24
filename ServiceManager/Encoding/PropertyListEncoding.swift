//
//  PropertyListEncoding.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 24/09/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public struct PropertyListEncoding: HTTPEncoding {

    public static var `default`: PropertyListEncoding { return PropertyListEncoding() }

    public static var xml: PropertyListEncoding { return PropertyListEncoding(format: .xml) }

    public static var binary: PropertyListEncoding { return PropertyListEncoding(format: .binary) }

    public let format: PropertyListSerialization.PropertyListFormat

    public let options: PropertyListSerialization.WriteOptions

    public init(
        format: PropertyListSerialization.PropertyListFormat = .xml,
        options: PropertyListSerialization.WriteOptions = 0)
    {
        self.format = format
        self.options = options
    }

    public func encode(_ urlRequest: RequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asRequest()

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: parameters,
                format: format,
                options: options
            )

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-plist", forHTTPHeaderField: "Content-Type")
            }

            urlRequest.httpBody = data
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .propertyListEncodingFailed(error: error))
        }

        return urlRequest
    }
}
