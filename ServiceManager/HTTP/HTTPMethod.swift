//
//  HTTPMethod.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
