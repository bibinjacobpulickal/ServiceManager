//
//  HTTPError.swift
//  NetworkManager
//
//  Created by Parel Creative on 01/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public enum HTTPError: Error {
    case invalidRequest(description: String?)
    case invalidResponse(description: String?)
}

extension HTTPError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest(let description):
            return NSLocalizedString("Unable to process your request.",
                                     comment: description ?? "Invalid Url Request.")
        case .invalidResponse(let description):
            return NSLocalizedString("Unable to process response from server.",
                                     comment: description ?? "Invalid Response from server.")
        }
    }
}
