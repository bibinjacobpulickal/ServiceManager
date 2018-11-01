//
//  APIResponseCodable.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension API: ResponseCodable {
    
    var encoding: Encoding? {
        return nil
    }
    
    var decoder: AnyDecoder {
        return JSONDecoder()
    }
}
