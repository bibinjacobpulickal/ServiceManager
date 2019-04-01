//
//  Route.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String: Any]
typealias HTTPHeader = [String: String]

protocol Route {
    
    // http, https etc.
    var scheme: HTTPScheme { get }
    
    // eg: www.google.com
    var host: String { get }
    
    // eg: /search
    var path: String { get }
    
    // eg: ["key": "item"]
    var queries: HTTPParameters? { get }
    
    // eg: ["key": "item"]
    var parameters: HTTPParameters? { get }
    
    // scheme, host, path and queries combined.
    var components: URLComponents { get }
    
    // get or post etc.
    var method: HTTPMethod { get }
    
    // url or json encoding
    var encoding: HTTPEncoding { get }
    
    // eg: ["Authorization": "Bearer..."]
    var headers: HTTPHeader? { get }
    
    // Computed url request
    var request: URLRequest? { get }
    
    // Data to be sent
    var data: Data? { get }
    
    // Encodable object to be sent
    var object: Encodable? { get }
    
    // Computed request body
    var httpBody: Data? { get }
    
    // Files to be send as Form Data. Default is [].
    var formDataFiles: [FormDataFile] { get }
    
    // Defaults to JSONEncoder()
    var encoder: AnyEncoder { get }
    
    // Defaults to JSONDecoder()
    var decoder: AnyDecoder { get }
}
