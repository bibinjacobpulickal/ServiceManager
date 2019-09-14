//
//  OffsetConvertible.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 01/08/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public protocol OffsetConvertible {

    var horizontal: CGFloat { get }

    var vertical: CGFloat { get }
}

#if canImport(UIKit)

extension UIOffset: OffsetConvertible { }

#elseif canImport(Cocoa)

extension NSOffset: OffsetConvertible { }

#endif

extension CGFloat: OffsetConvertible {

    public var horizontal: CGFloat {
        return self
    }

    public var vertical: CGFloat {
        return self
    }
}

extension Double: OffsetConvertible {

    public var horizontal: CGFloat {
        return CGFloat(self)
    }

    public var vertical: CGFloat {
        return CGFloat(self)
    }
}

extension Int: OffsetConvertible {

    public var horizontal: CGFloat {
        return CGFloat(self)
    }

    public var vertical: CGFloat {
        return CGFloat(self)
    }
}
