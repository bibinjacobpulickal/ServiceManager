//
//  ServiceController.swift
//  ServiceManagerMacOS
//
//  Created by Bibin Jacob Pulickal on 11/07/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa
import ServiceManager

class ServiceController: NSViewController {

    override func loadView() {
        view    = NSView()
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 500).isActive = true
        let button = NSButton(title: "Request", target: self, action: #selector(sendGetRequest))
        view.addSubview(button)
    }

    @objc private func sendGetRequest() {
        Service.shared.result(API.test, headers: ["test": "123"]) { (result) in
            switch result {
            case .success(let object):
                print(object)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

enum API: URLComponent {

    case test

    var scheme: HTTPScheme {
        return .https
    }

    var host: String {
        return "www.google.com"
    }

    var path: String {
        return "/test"
    }
}

struct TestObject: Decodable {
}
