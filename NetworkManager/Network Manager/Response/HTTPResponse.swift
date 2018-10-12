//
//  HTTPResponse.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPResponse {
    case success(Data)
    case failure(Error)
}

enum Response<T: Codable> {
    
    case decoded(T)
    case failed(Error)
    case serialized(Any)
    
    var error: Error? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }
    
    var data: Data? {
        switch self {
        case .serialized(let object):
            return try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        case .decoded(let t):
            return try? JSONEncoder().encode(t)
        default:
            return nil
        }
    }
    
    var json: Any? {
        switch self {
        case .serialized(let json):
            return json
        default:
            return nil
        }
    }
    
    var object: T? {
        switch self {
        case .decoded(let t):
            return t
        default:
            return nil
        }
    }
}
