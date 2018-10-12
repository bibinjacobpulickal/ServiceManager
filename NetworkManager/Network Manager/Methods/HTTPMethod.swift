//
//  HTTPMethod.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
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
