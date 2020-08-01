//
//  Route.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol Route: URLComponent, RequestComponent, ResponseComponent { }

extension Route {

    func asURLRequest() throws -> URLRequest {
        let url            = try asURL()
        let request        = try URLRequest(url: url, method: method, body: body, headers: headers)
        return try encoding.encode(request, with: object, using: encoder)
    }
}
