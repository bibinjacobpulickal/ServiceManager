//
//  MethodPopupButton.swift
//  ServiceManagerMacOS
//
//  Created by Bibin Jacob Pulickal on 11/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa
import ServiceManager

class MethodPopupButton: NSPopUpButton {

    var selectedMethod = HTTPMethod.get

    init() {
        super.init(frame: .zero, pullsDown: true)

        menu?.addItem(withTitle: HTTPMethod.allCases[0].rawValue, action: #selector(handleSelectedItem(_:)), keyEquivalent: "")
        HTTPMethod.allCases.forEach { method in
            menu?.addItem(withTitle: "\(method.rawValue)", action: #selector(handleSelectedItem(_:)), keyEquivalent: "")
        }
    }

    @objc private func handleSelectedItem(_ selectedItem: NSMenuItem) {
        title               = selectedItem.title
        if let method       = HTTPMethod(rawValue: selectedItem.title) {
            selectedMethod  = method
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
