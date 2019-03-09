//
//  HTTPResult.swift
//  Service Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPResult<T> {
    
    case failure(Error)
    case success(T)
    
    var object: T? {
        switch self {
        case .failure:
            return nil
        case .success(let object):
            return object
        }
    }
}
