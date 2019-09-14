//
//  AutoLayoutOperators.swift
//  AutoLayoutProxy
//
//  Created by Frankenstein on 06/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public func ==(lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) {
    lhs.constraint(equalTo: rhs).isActive = true
}

public func ==(lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) {
    lhs.constraint(equalTo: rhs).isActive = true
}

public func ==(lhs: NSLayoutDimension, rhs: NSLayoutDimension) {
    lhs.constraint(equalTo: rhs).isActive = true
}


public func <=<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>) {
    lhs.constraint(lessThanOrEqualTo: rhs).isActive = true
}

public func >=<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>) {
    lhs.constraint(greaterThanOrEqualTo: rhs).isActive = true
}


public func +<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: CGFloat) -> (NSLayoutAnchor<AnchorType>, CGFloat, CGFloat) {
    return (lhs, 1, rhs)
}

public func -<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: CGFloat) -> (NSLayoutAnchor<AnchorType>, CGFloat, CGFloat) {
    return (lhs, 1, -rhs)
}

public func *(lhs: NSLayoutAnchor<NSLayoutDimension>, rhs: CGFloat) -> (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat) {
    return (lhs, rhs, 0)
}

public func /(lhs: NSLayoutAnchor<NSLayoutDimension>, rhs: CGFloat) -> (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat) {
    return (lhs, 1/rhs, 0)
}

public func +(lhs: (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat), rhs: CGFloat) -> (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat) {
    return (lhs.0, lhs.1, rhs)
}

public func -(lhs: (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat), rhs: CGFloat) -> (NSLayoutAnchor<NSLayoutDimension>, CGFloat, CGFloat) {
    return (lhs.0, lhs.1, -rhs)
}


public func ==<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: (NSLayoutAnchor<AnchorType>, CGFloat, CGFloat)) {
    if let lhs = lhs as? NSLayoutDimension,
        let rhsAnchor = rhs.0 as? NSLayoutDimension {
        lhs.constraint(equalTo: rhsAnchor, multiplier: rhs.1, constant: rhs.2).isActive = true
    } else {
        lhs.constraint(equalTo: rhs.0, constant: rhs.2).isActive = true
    }
}

public func <=<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: (NSLayoutAnchor<AnchorType>, CGFloat, CGFloat)) {
    if let lhs = lhs as? NSLayoutDimension,
        let rhsAnchor = rhs.0 as? NSLayoutDimension {
        lhs.constraint(lessThanOrEqualTo: rhsAnchor, multiplier: rhs.1, constant: rhs.2).isActive = true
    } else {
        lhs.constraint(lessThanOrEqualTo: rhs.0, constant: rhs.2).isActive = true
    }
}

public func >=<AnchorType>(lhs: NSLayoutAnchor<AnchorType>, rhs: (NSLayoutAnchor<AnchorType>, CGFloat, CGFloat)) {
    if let lhs = lhs as? NSLayoutDimension,
        let rhsAnchor = rhs.0 as? NSLayoutDimension {
        lhs.constraint(greaterThanOrEqualTo: rhsAnchor, multiplier: rhs.1, constant: rhs.2).isActive = true
    } else {
        lhs.constraint(greaterThanOrEqualTo: rhs.0, constant: rhs.2).isActive = true
    }
}

public func ==(lhs: NSLayoutDimension, rhs: CGFloat) {
    lhs.constraint(equalToConstant: rhs).isActive = true
}

public func <=(lhs: NSLayoutDimension, rhs: CGFloat) {
    lhs.constraint(lessThanOrEqualToConstant: rhs).isActive = true
}

public func >=(lhs: NSLayoutDimension, rhs: CGFloat) {
    lhs.constraint(greaterThanOrEqualToConstant: rhs).isActive = true
}


public func ==(lhs: (NSLayoutDimension, NSLayoutDimension), rhs: SizeConvertible) {
    lhs.0.constraint(equalToConstant: rhs.width).isActive   = true
    lhs.1.constraint(equalToConstant: rhs.height).isActive  = true
}

public func <=(lhs: (NSLayoutDimension, NSLayoutDimension), rhs: SizeConvertible) {
    lhs.0.constraint(lessThanOrEqualToConstant: rhs.width).isActive   = true
    lhs.1.constraint(lessThanOrEqualToConstant: rhs.height).isActive  = true
}

public func >=(lhs: (NSLayoutDimension, NSLayoutDimension), rhs: SizeConvertible) {
    lhs.0.constraint(greaterThanOrEqualToConstant: rhs.width).isActive   = true
    lhs.1.constraint(greaterThanOrEqualToConstant: rhs.height).isActive  = true
}
