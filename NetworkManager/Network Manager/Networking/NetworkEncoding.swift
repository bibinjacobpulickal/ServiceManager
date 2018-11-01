//
//  NetworkEncoding.swift
//  AHAM
//
//  Created by Bibin Jacob Pulickal on 29/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation
import MobileCoreServices

enum Encoding {
    case json, url, form
}

extension Network {
    
    func createBody(with parameters: [String: String], filePathKey: String, paths: [String], boundary: String) throws -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        for path in paths {
            let url = URL(fileURLWithPath: path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(for: path)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private func mimeType(for path: String) -> String {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}

extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
