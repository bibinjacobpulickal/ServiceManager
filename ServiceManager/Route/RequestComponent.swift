//
//  RequestComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol RequestComponent: RequestConvertible {

    // URLRequest method eg: GET, POST etc, defaults to get.
    var method: HTTPMethod { get }

    // URLRequest headers eg: ["Authorization": "Bearer..."], defaults to nil.
    var headers: HTTPHeaders? { get }

    // URLRequest object, defaults to nil
    var object: Encodable? { get }

    // URLRequest object encoder, defaults to JSONEncoder().
    var encoder: AnyEncoder { get }

    // URLRequest object encoding, defaults to URLEncoding.default.
    var encoding: HTTPEncoding { get }
}

public extension RequestComponent {

    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var object: Encodable? {
        return nil
    }

    var encoder: AnyEncoder {
        return JSONEncoder()
    }

    var encoding: HTTPEncoding {
        return URLEncoding.default
    }
}

public protocol ResponseComponent {

    // URLSession response object decoder, defaults to JSONDecoder().
    var decoder: AnyDecoder { get }
}

public extension ResponseComponent {

    var decoder: AnyDecoder {
        return JSONDecoder()
    }
}
