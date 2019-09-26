//
//  NSOffset.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 03/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa

public struct NSOffset {

    public var horizontal: CGFloat

    public var vertical: CGFloat

    public static let zero = NSOffset()

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical   = vertical
    }

    public init(h horizontal: CGFloat = 0, v vertical: CGFloat = 0) {
        self.init(horizontal: horizontal, vertical: vertical)
    }
    public init(_ both: CGFloat) {
        self.init(horizontal: both, vertical: both)
    }
}

#endif
