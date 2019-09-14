//
//  NSLayoutConstraintAttributeExtensions.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 06/09/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public extension Set where Element == NSLayoutConstraint.Attribute {

    static var allSides: Set<NSLayoutConstraint.Attribute> {
        return [.top, .left, .bottom, .right]
    }

    static var horizontal: Set<NSLayoutConstraint.Attribute> {
        return [.left, .right]
    }

    static var vertical: Set<NSLayoutConstraint.Attribute> {
        return [.top, .bottom]
    }

    static var bothCenters: Set<NSLayoutConstraint.Attribute> {
        return [.centerX, .centerY]
    }

    static var bothDimensions: Set<NSLayoutConstraint.Attribute> {
        return [.width, .height]
    }
}
