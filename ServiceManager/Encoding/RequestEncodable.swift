//
//  RequestEncodable.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol RequestEncodable {
    func getEncoder()
}

public extension RequestEncodable {
    func getEncoder() -> AnyEncoder {
        return JSONEncoder()
    }
}
