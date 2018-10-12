//
//  NetworkProtocols.swift
//  NetworkManager
//
//  Created by Bibin Jacob Pulickal on 09/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

protocol NetworkComputable {
    func computeUrl(api: API) -> URL?
    func computeUrlRequest(api: API?, url: URL) -> URLRequest
}

protocol NetworkLoggable {
    func logSession(_ request: URLRequest, _ data: Data?, _ response: URLResponse?, _ error: Error?)
    func logResponse(_ response: HTTPURLResponse)
}
