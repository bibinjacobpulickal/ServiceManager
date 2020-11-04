//
//  PropertyListEncoding.swift
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

public struct PropertyListEncoding: ParameterEncoding {

    public static var `default`: PropertyListEncoding { PropertyListEncoding() }

    public static var xml: PropertyListEncoding { PropertyListEncoding(format: .xml) }

    public static var binary: PropertyListEncoding { PropertyListEncoding(format: .binary) }

    public static var openStep: PropertyListEncoding { PropertyListEncoding(format: .openStep) }

    public let format: PropertyListSerialization.PropertyListFormat

    public let options: PropertyListSerialization.WriteOptions

    public init(
        format: PropertyListSerialization.PropertyListFormat = .xml,
        options: PropertyListSerialization.WriteOptions = 0)
    {
        self.format = format
        self.options = options
    }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: parameters,
                format: format,
                options: options
            )

            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/x-plist"))
            }

            urlRequest.httpBody = data
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .propertyListEncodingFailed(error: error))
        }

        return urlRequest
    }
}
