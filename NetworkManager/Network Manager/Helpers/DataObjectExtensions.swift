//
//  DataObjectExtensions.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 18/04/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension Data {

    var json: NSObject {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? NSObject ?? NSObject()
        } catch {
            return NSObject()
        }
    }

    static func +=(lhs: inout Data, rhs: String) {
        lhs.append(Data(rhs.utf8))
    }

    var string: String {
        return String(decoding: self, as: UTF8.self)
    }
}

extension NSObject {

    var data: Data {
        if JSONSerialization.isValidJSONObject(self),
            let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            return data
        } else {
            return Data()
        }
    }
}

extension String {

    var data: Data {
        return Data(self.utf8)
    }
}
