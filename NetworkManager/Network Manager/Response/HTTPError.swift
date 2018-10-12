//
//  HTTPError.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 15/09/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPError: String, Error {
    case unknown        = "Unknown"
    case success        = "Success"
    case created        = "Created"
    case accepted       = "Accepted"
    case redirection    = "Redirection"
    case clientError    = "Client Error"
    case badRequest     = "Bad Request"
    case unauthorized   = "unauthorized"
    case payRequired    = "Payment Required"
    case forbidden      = "Forbidden"
    case notFound       = "Not Found"
    case notAllowed     = "Method Not Allowed"
    case notAcceptable  = "Not Acceptable"
    case requestTimeout = "Request Timeout"
    case serverError    = "Server Error"
    case internlError   = "Internal Server Error"
    case notImplemented = "Not Implemented"
    case badGateway     = "Bad Gateway"
    case unavailable    = "Service Unavailable"
    case gatewayTimeout = "Gateway Timeout"
    case emptyData      = "Empty Data"
    case decodeError    = "Decoding Failed"
}
