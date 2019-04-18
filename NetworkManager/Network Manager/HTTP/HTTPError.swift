//
//  HTTPError.swift
//  NetworkManager
//
//  Created by Parel Creative on 01/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public enum HTTPError: Error {
    case invalidRequest
    case invalidResponse
}

extension HTTPError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return NSLocalizedString("Unable to process your request.",
                                     comment: "Invalid Url Request.")
        case .invalidResponse:
            return NSLocalizedString("Unable to process response from server.",
                                     comment: "Invalid Response from server.")
        }
    }
}
