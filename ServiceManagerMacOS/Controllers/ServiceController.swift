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

    private let serviceView = ServiceView(target: self as AnyObject, action: #selector(sendRequest))

    override func loadView() {
        view    = serviceView
    }

    @objc private func sendRequest() {
        let urlString           = "https://reqres.in/api/users?page=2"
        let method              = serviceView.method

        serviceView.resultText  = ""
        serviceView.activityIndicator.startAnimation(self)

        Service.shared.dataResult(urlString, method: method, object: Test()) { [weak self] result in
            self?.serviceView.activityIndicator.stopAnimation(nil)
            switch result {
            case .success(let data):
                self?.serviceView.resultText = "Data:\n\(data.prettyPrittedString)"
            case .failure(let error):
                self?.serviceView.resultText = "Error: \(error.localizedDescription)"
            }
        }
    }
}

struct Test: Encodable {
    var test1: Int?
    var test2 = "test"
}
