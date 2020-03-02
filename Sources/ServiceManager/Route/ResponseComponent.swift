//
//  ResponseComponent.swift
//  ServiceManager
//
//  Created by Bibin Jacob Pulickal on 07/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

public protocol ResponseComponent {

    // URLSession response object decoder, defaults to JSONDecoder().
    var decoder: AnyDecoder { get }
}

public extension ResponseComponent {

    var decoder: AnyDecoder { JSONDecoder() }
}
