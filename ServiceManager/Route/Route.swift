//
//  Route.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol Route: URLComponent, RequestComponent, ResponseComponent { }

extension Route {

    func asRequest() throws -> URLRequest {
        let url            = try asURL()
        let request        = try URLRequest(url: url, method: method, headers: headers)
        if let object      = object,
            let parameters = try object.jsonObject(using: encoder) as? [String: Any] {
            return try encoding.encode(request, with: parameters)
        }
        return request
    }
}
