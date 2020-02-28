//
//  HTTPHeader.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 15/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [HTTPHeaderField: String]

public extension URLRequest {

    func value(for HTTPHeaderField: HTTPHeaderField) -> String? {
        return value(forHTTPHeaderField: HTTPHeaderField.rawValue)
    }

    mutating func setValue(_ value: String?, for HTTPHeaderField: HTTPHeaderField) {
        setValue(value, forHTTPHeaderField: HTTPHeaderField.rawValue)
    }
}

//public extension URLRequest {

    enum HTTPHeaderField: String {
        case AIM                         = "A-IM"
        case accept                      = "Accept"
        case acceptCharset               = "Accept-Charset"
        case acceptDatetime              = "Accept-Datetime"
        case acceptEncoding              = "Accept-Encoding"
        case acceptLanguage              = "Accept-Language"
        case accessControlRequestMethod  = "Access-Control-Request-Method"
        case accessControlRequestHeaders = "Access-Control-Request-Headers"
        case authorization               = "Authorization"
        case cacheControl                = "Cache-Control"
        case connection                  = "Connection"
        case contentLength               = "Content-Length"
        case contentMD5                  = "Content-MD5"
        case contentType                 = "Content-Type"
        case cookie                      = "Cookie"
        case date                        = "Date"
        case expect                      = "Expect"
        case forwarded                   = "Forwarded"
        case from                        = "From"
        case host                        = "Host"
        case HTTP2Settings               = "HTTP2-Settings"
        case ifMatch                     = "If-Match"
        case ifModifiedSince             = "If-Modified-Since"
        case ifNoneMatch                 = "If-None-Match"
        case ifRange                     = "If-Range"
        case ifUnmodifiedSince           = "If-Unmodified-Since"
        case maxForwards                 = "Max-Forwards"
        case origin                      = "Origin"
        case pragma                      = "Pragma"
        case proxyAuthorization          = "Proxy-Authorization"
        case range                       = "Range"
        case referer                     = "Referer"
        case TE                          = "TE"
        case trailer                     = "Trailer"
        case transferEncoding            = "Transfer-Encoding"
        case userAgent                   = "User-Agent"
        case upgrade                     = "Upgrade"
        case via                         = "Via"
        case warning                     = "Warning"
    }
//}
