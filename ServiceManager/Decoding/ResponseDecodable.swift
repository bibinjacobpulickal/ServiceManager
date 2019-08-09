//
//  ResponseDecodable.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol ResponseConvertable {
    func getDecoder()
}

public extension ResponseConvertable {
    func getDecoder() -> AnyDecoder {
        return JSONDecoder()
    }
}
