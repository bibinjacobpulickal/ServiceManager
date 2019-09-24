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
        let urlString           = serviceView.urlString
        let method              = serviceView.method

        serviceView.resultText  = ""
        serviceView.activityIndicator.startAnimation(self)

        Service.shared.dataResult(urlString, method: method) { [weak self] result in
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
