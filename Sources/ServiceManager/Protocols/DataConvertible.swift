//
//  DataConvertible.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 02/02/20.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol DataConvertible {

    var data: Data { get }
}

extension Data: DataConvertible {

    public var data: Data { self }
}

extension String: DataConvertible {

    public var data: Data { Data(self.utf8) }
}

extension Dictionary: DataConvertible where Key: Any, Value: Any {

    public var data: Data {
        (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)) ?? Data()
    }
}

extension Array: DataConvertible where Element: Any {

    public var data: Data {
        (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)) ?? Data()
    }
}

extension Encodable where Self: DataConvertible {

    public var data: Data { (try? encoded()) ?? Data() }
}
