//
//  HTTPError.swift
//  NetworkManager
//
//  Created by Parel Creative on 01/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
}
