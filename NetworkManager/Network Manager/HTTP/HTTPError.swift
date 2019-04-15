//
//  HTTPError.swift
//  NetworkManager
//
//  Created by Parel Creative on 01/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case invalidRequest
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Unable to process your request."
        case .invalidResponse:
            return "Unable to process response from server."
        }
    }
}
