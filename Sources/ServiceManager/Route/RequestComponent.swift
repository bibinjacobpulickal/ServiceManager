//
//  RequestComponent.swift
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

public protocol RequestComponent: URLRequestConvertible {

    // URLRequest method eg: GET, POST etc. Defaults to get.
    var method: HTTPMethod { get }

    // URLRequest httpBody of type DataConvertible. Defaults to nil.
    var body: DataConvertible? { get }

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

    var body: DataConvertible? { nil }

    var headers: HTTPHeaders? { nil }

    var object: Encodable? { nil }

    var encoder: AnyEncoder { JSONEncoder() }

    var encoding: HTTPEncoding { URLEncoding.default }
}
