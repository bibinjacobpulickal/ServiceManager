//
//  HTTPMethod.swift
//  Service Manager
//
//  Created by Bibin Jacob Pulickal on 03/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case put    = "PUT"
    case post   = "POST"
    case head   = "HEAD"
    case trace  = "TRACE"
    case delete = "DELETE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
