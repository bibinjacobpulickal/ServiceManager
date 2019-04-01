//
//  RouteDefaults.swift
//  NetworkManager
//
//  Created by Parel Creative on 31/03/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

// Setting Route defaults
extension Route {
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var parameters: HTTPParameters? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: HTTPEncoding {
        return .json
    }
    
    var headers: HTTPHeader? {
        return [:]
    }
    
    var data: Data? {
        return nil
    }
    
    var object: Encodable? {
        return nil
    }
    
    var formDataFiles: [FormDataFile] {
        return []
    }
    
    var encoder: AnyEncoder {
        return JSONEncoder()
    }
    
    var decoder: AnyDecoder {
        return JSONDecoder()
    }
}
