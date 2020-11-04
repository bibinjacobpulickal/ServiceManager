//
//  JSONEncoding.swift
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
        if urlRequest.headers["Content-Type"] == nil {
            urlRequest.headers.update(.contentType("application/json"))
        }

        return urlRequest
    }
}
