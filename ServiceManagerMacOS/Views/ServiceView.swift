//
//  ServiceView.swift
//  ServiceManagerMacOS
//
//  Created by Frankenstein on 12/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa
import ServiceManager

class ServiceView: NSView {

    var method: HTTPMethod {
        return methodSelector.selectedMethod
    }

    var urlString: String {
        return urlTextField.stringValue
    }

    var resultText: String {
        set {
            resultTextView.string = newValue
        }
        get {
            return resultTextView.string
        }
    }

    private let methodSelector = MethodPopupButton()

    private let urlTextField: NSTextField = {
        let textField               = NSTextField()
        textField.placeholderString = "Enter url here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let sendButton = NSButton(title: "Send", target: nil, action: nil)

    private let resultTextView: NSTextView = {
        let textView                = NSTextView()
        textView.isEditable         = false
        return textView
    }()

    let activityIndicator: NSProgressIndicator = {
        let indicator                                  = NSProgressIndicator()
        indicator.style                                = .spinning
        indicator.isDisplayedWhenStopped               = false
        return indicator
    }()

    init(target: AnyObject?, action: Selector?) {
        super.init(frame: .zero)
        sendButton.target   = target
        sendButton.action   = action

        addSubviews()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {

        height  >= 500
        width   >= 500

        addSubview(methodSelector) {
            methodSelector.top      == top + 12
            methodSelector.leading  == leading + 12
        }

        addSubview(urlTextField) {
            urlTextField.top        == methodSelector.top
            urlTextField.leading    == methodSelector.trailing + 12
        }

        addSubview(sendButton) {
            sendButton.top          == methodSelector.top
            sendButton.leading      == urlTextField.trailing + 12
            sendButton.trailing     == trailing - 12
        }

        addSubview(resultTextView) {
            resultTextView.top      == methodSelector.bottom + 12
            resultTextView.leading  == methodSelector.leading
            resultTextView.trailing == sendButton.trailing
            resultTextView.bottom   == bottom - 12
        }

        addSubview(activityIndicator) {
            activityIndicator.centerX   == centerX
            activityIndicator.centerY   == centerY
        }
    }
}
