//
//  URLExtensions.swift
//  ChatTemplate
//
//  Created by Bibin Jacob Pulickal on 10/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension URL {
    init(string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        self = url
    }
}
