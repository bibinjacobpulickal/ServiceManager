//
//  AnyDecoder.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder { }

public extension Data {

    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }

    var prettyPrittedString: String {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableLeaves),
            JSONSerialization.isValidJSONObject(object),
            let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            return String(decoding: data, as: UTF8.self)
        } else {
            return String(decoding: self, as: UTF8.self)
        }
    }
}

public extension KeyedDecodingContainerProtocol {

    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self, forKey: key)
    }

    func decode<T: Decodable>(forKey key: Key, default defaultExpression: @autoclosure () -> T) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}
