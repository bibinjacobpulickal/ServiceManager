//
//  APIProtocols.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

typealias HTTPQuery = [String: String?]?
typealias HTTPHeader = [String: String?]?

protocol URLComputable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queries: HTTPQuery { get }
}

protocol URLRequestComputable {
    var method: HTTPMethod { get }
    var headers: HTTPHeader { get }
    var data: Data? { get }
    var object: Any? { get }
}

protocol ResponseDecodable {
    var decoder: AnyDecoder { get }
}
