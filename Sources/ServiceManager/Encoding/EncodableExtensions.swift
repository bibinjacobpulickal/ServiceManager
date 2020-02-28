//
//  EncodableExtensions.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 08/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public extension Encodable {

    func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }

    func jsonObject(using encoder: AnyEncoder) throws -> Any {
        let data = try encoder.encode(self)
        return try JSONSerialization.jsonObject(with: data,
                                                options: .mutableLeaves)
    }
}
