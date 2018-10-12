//
//  APIURLComputable.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension API: URLComputable {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch Network.environment {
        case .production:
            return ""
        }
    }
    
    var path: String {
        switch self {
            
        }
    }
    
    var queries: HTTPQuery {
        switch self {
            
        }
    }
}
