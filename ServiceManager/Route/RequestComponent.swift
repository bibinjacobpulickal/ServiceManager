//
//  RequestComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public protocol RequestComponent: RequestConvertible {

    var method: HTTPMethod { get }

    var headers: HTTPHeaders? { get }

    var object: Encodable? { get }

    var encoder: AnyEncoder { get }

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
        return JSONEncoding.default
    }
}

public protocol ResponseComponent {

    var decoder: AnyDecoder { get }
}

public extension ResponseComponent {

    var decoder: AnyDecoder {
        return JSONDecoder()
    }
}
