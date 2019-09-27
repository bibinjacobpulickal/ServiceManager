//
//  AutoLayoutable.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 02/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public protocol AutoLayoutable: AnyObject {

    var translatesAutoresizingMaskIntoConstraints: Bool { get set }

    var leadingAnchor: NSLayoutXAxisAnchor { get }

    var trailingAnchor: NSLayoutXAxisAnchor { get }

    var leftAnchor: NSLayoutXAxisAnchor { get }

    var rightAnchor: NSLayoutXAxisAnchor { get }

    var topAnchor: NSLayoutYAxisAnchor { get }

    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var widthAnchor: NSLayoutDimension { get }

    var heightAnchor: NSLayoutDimension { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }

    var centerYAnchor: NSLayoutYAxisAnchor { get }

    func addSubview(_ view: AutoLayoutable)
}

public extension AutoLayoutable {

    func addSubview(_ view: AutoLayoutable, layout: (() -> Void)) -> Void {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        layout()
    }
}

#if canImport(UIKit)
extension UIView: AutoLayoutable {
    public func addSubview(_ view: AutoLayoutable) {
        if let view = view as? UIView {
            addSubview(view)
        }
    }
}
#elseif canImport(Cocoa)
extension NSView: AutoLayoutable {
    public func addSubview(_ view: AutoLayoutable) {
        if let view = view as? NSView {
            addSubview(view)
        }
    }
}
#endif
