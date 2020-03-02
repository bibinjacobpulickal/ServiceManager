//
//  HTTPMethod.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 12/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public enum HTTPMethod: String, CaseIterable {
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
    case options

    public init?(value: String) {
        self.init(rawValue: value.lowercased())
    }

    public var value: String { rawValue.uppercased() }
}
