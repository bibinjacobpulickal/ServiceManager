//
//  ServiceLogger.swift
//  NetworkManager
//
//  Created by Parel Creative on 01/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

struct ServiceLogger {
    
    static func logSession(_ log: Bool, request: URLRequest?, data: Data?, response: HTTPURLResponse?, error: Error?) {
        if !log && error == nil && (200..<300).contains(response?.statusCode ?? 0) { return }
        
        if let request = request {
            print("\n\(request.httpMethod ?? "URL"):", request)
        }
        
        if let headers = request?.allHTTPHeaderFields, !headers.isEmpty {
            print("Headers:", headers)
        }
        if let data = request?.httpBody {
            print("Body:")
            printData(data)
        }
        if let response = response {
            print("Status Code:", response.statusCode)
        }
        if let data = data {
            print("Response:")
            printData(data)
        }
        if let error = error {
            logError(error)
        }
    }
    
    private static func logError(_ error: Error) {
        if let error = error as? DecodingError {
            switch error {
            case .dataCorrupted(let context), .keyNotFound(_, let context), .valueNotFound(_, let context), .typeMismatch(_, let context):
                context.codingPath.forEach { (codingPath) in
                    print("Error Key:", codingPath.stringValue)
                }
                print("Error:", context.debugDescription)
            @unknown default:
                print("Error:", error.localizedDescription)
            }
        } else {
            print("Error:", error.localizedDescription)
        }
    }
    
    private static func printData(_ data: Data) {
        print(data.json.data.string)
    }
}
