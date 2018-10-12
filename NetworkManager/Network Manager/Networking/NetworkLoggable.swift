//
//  NetworkLoggable.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension Network: NetworkLoggable {
    
    func logSession(_ request: URLRequest, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
        
        print("\n\(request.httpMethod ?? "URL"):", request)
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("Headers:", headers)
        }
        if let data = request.httpBody {
            printData("Body:", data)
        }
        if let error = error {
            print("Error:", error.localizedDescription)
        }
        if let response = response as? HTTPURLResponse {
            logResponse(response)
        }
        if let data = data {
            printData("Data:", data)
        }
    }
    
    func printData(_ items: Any?...) {
        for item in items {
            if let item = item as? Data,
                let object = try? JSONSerialization.jsonObject(with: item, options: .mutableLeaves),
                let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
                let string = String(data: data, encoding: .utf8) {
                print(string)
            } else {
                print(item ?? "Item is empty")
            }
        }
    }
    
    func logResponse(_ response: HTTPURLResponse) {
        let code = response.statusCode
        var sessionResponse = HTTPError.unknown
        switch code {
        case 200:
            sessionResponse = .success
        case 201:
            sessionResponse = .created
        case 202:
            sessionResponse = .accepted
        case 203...299:
            sessionResponse = .success
        case 300...399:
            sessionResponse = .redirection
        case 400:
            sessionResponse = .badRequest
        case 401:
            sessionResponse = .unauthorized
        case 402:
            sessionResponse = .payRequired
        case 403:
            sessionResponse = .forbidden
        case 404:
            sessionResponse = .notFound
        case 405:
            sessionResponse = .notAllowed
        case 406:
            sessionResponse = .notAcceptable
        case 408:
            sessionResponse = .requestTimeout
        case 407...499:
            sessionResponse = .clientError
        case 500:
            sessionResponse = .internlError
        case 501:
            sessionResponse = .notImplemented
        case 502:
            sessionResponse = .badGateway
        case 503:
            sessionResponse = .unavailable
        case 504:
            sessionResponse = .gatewayTimeout
        case 505...599:
            sessionResponse = .serverError
        default:
            sessionResponse = .unknown
        }
        print("Response: \(code) \(sessionResponse.rawValue)")
    }
}
