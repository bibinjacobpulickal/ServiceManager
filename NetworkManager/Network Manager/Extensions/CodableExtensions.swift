//
//  CodableExtensions.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 06/09/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder { }

extension Data {
    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableLeaves)
    }
}

protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: AnyEncoder { }

extension Encodable {
    func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    var data: Data? {
        return try? self.encoded()
    }
    var object: Any? {
        return try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))
    }
}

extension KeyedDecodingContainerProtocol {
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self, forKey: key)
    }
    func decode<T: Decodable>(forKey key: Key, default defaultExpression: @autoclosure () -> T) throws -> T {
        return try decodeIfPresent(T.self, forKey: key) ?? defaultExpression()
    }
}
