//
//  AnyEncoder.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder { }
