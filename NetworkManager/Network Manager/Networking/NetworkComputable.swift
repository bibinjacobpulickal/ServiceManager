//
//  NetworkComputable.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension Network: NetworkComputable {
    
    func computeUrl(api: API) -> URL? {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        api.queries?.forEach({ (key, value) in
            let query = URLQueryItem(name: key, value: value)
            if components.queryItems?.append(query) == nil {
                components.queryItems = [query]
            }
        })
        return components.url
    }
    
    func computeUrlRequest(api: API?, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = api?.method.rawValue
        if let headers = api?.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        if let data = api?.data {
            request.httpBody = data
        } else if api?.encoding == .json, let object = api?.object {
            request.httpBody = try? JSONSerialization.data(withJSONObject: object, options: .sortedKeys)
        } else if api?.encoding == .form, let object = api?.object as? [String: String] {
            let boundary = generateBoundaryString()
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? createBody(with: object, filePathKey: "file", paths: [], boundary: boundary)
        }
        if api?.encoding == .json {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else if api?.encoding == .url {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
