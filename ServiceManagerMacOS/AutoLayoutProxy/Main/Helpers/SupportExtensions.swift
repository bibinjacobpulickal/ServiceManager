//
//  SupportExtensions.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 03/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public extension CGSize {

    init(w width: CGFloat = 0, h height: CGFloat = 0) {
        self.init(width: width, height: height)
    }
    init(_ both: CGFloat) {
        self.init(width: both, height: both)
    }
}

#if canImport(UIKit)

public extension UIEdgeInsets {

    init(t top: CGFloat = 0, l left: CGFloat = 0, b bottom: CGFloat = 0, r right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: -all, right: -all)
    }
    init(h horizontal: CGFloat = 0, v vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
}

public extension UIOffset {

    init(h horizontal: CGFloat = 0, v vertical: CGFloat = 0) {
        self.init(horizontal: horizontal, vertical: vertical)
    }
    init(_ both: CGFloat) {
        self.init(horizontal: both, vertical: both)
    }
}

#endif

#if canImport(Cocoa)

public extension NSEdgeInsets {

    static let zero = NSEdgeInsets()

    init(t top: CGFloat = 0, l left: CGFloat = 0, b bottom: CGFloat = 0, r right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: -all, right: -all)
    }
    init(v vertical: CGFloat, h horizontal: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
    init(h horizontal: CGFloat, v vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: -vertical, right: -horizontal)
    }
}

#endif
