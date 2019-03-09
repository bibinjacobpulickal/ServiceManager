//
//  Route.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

protocol Route {
    
    // http, https etc.
    var scheme: String { get }
    
    // eg: www.google.com
    var host: String { get }
    
    // eg: /search
    var path: String { get }
    
    // eg: ["key": "item"]
    var queries: HTTPQuery { get }
    
    // scheme, host, path and queries combined.
    var urlComponents: URLComponents { get }
    
    // get or post etc.
    var method: HTTPMethod? { get }
    
    // url or json encoding
    var encoding: HTTPEncoding? { get }
    
    // eg: ["Authorization": "Bearer..."]
    var headers: HTTPHeader { get }
    
    // Computed url request
    var urlRequest: URLRequest { get }
    
    // Data to be sent
    var data: Data? { get }
    
    // Json object to be sent
    var json: Any? { get }
    
    // Encodable object to be sent
    var object: Encodable? { get }
    
    // Computed request body
    var httpBody: Data? { get }
    
    // Defaults to JSONEncoder()
    var encoder: AnyEncoder { get }
    
    // Defaults to JSONDecoder()
    var decoder: AnyDecoder { get }
}
