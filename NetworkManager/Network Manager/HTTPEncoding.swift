//
//  HTTPEncoding.swift
//  Network Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPEncoding {
    
    case url
    case json
    
    static let contentTypeKey = "Content-Type"
    
    var contentType: String {
        switch self {
        case .url:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        }
    }
}
