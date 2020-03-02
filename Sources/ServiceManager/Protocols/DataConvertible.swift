//
//  DataConvertible.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 02/02/20.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol DataConvertible {
    func asData() throws -> Data
}

extension Data: DataConvertible {
    public func asData() -> Data { self }
}

extension String: DataConvertible {
    public func asData() -> Data { Data(self.utf8) }
}

extension Dictionary: DataConvertible where Key: Any, Value: Any {
    public func asData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

extension Array: DataConvertible where Element: Any {
    public func asData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

extension Encodable where Self: DataConvertible {
    public func asData() throws -> Data { try encoded() }
}
