//
//  Initializable.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 10/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol Initializable {
    init()
}

extension NSObject: Initializable { }

public func create<Object>(_ setup: (Object) -> Void) -> Object where Object: NSObject {
    let object = Object()
    setup(object)
    return object
}
