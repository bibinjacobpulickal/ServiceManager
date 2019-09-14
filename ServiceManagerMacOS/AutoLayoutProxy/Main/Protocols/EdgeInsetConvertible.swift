//
//  EdgeInsetConvertible.swift
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

public protocol EdgeInsetConvertible {

    var top: CGFloat { get }

    var left: CGFloat { get }

    var bottom: CGFloat { get }

    var right: CGFloat { get }
}

#if canImport(UIKit)
extension UIEdgeInsets: EdgeInsetConvertible { }
#elseif canImport(Cocoa)
extension NSEdgeInsets: EdgeInsetConvertible { }
#endif

extension CGFloat: EdgeInsetConvertible {

    public var top: CGFloat {
        return self
    }

    public var left: CGFloat {
        return self
    }

    public var bottom: CGFloat {
        return -self
    }

    public var right: CGFloat {
        return -self
    }
}

extension Double: EdgeInsetConvertible {

    public var top: CGFloat {
        return CGFloat(self)
    }

    public var left: CGFloat {
        return CGFloat(self)
    }

    public var bottom: CGFloat {
        return -CGFloat(self)
    }

    public var right: CGFloat {
        return -CGFloat(self)
    }
}

extension Int: EdgeInsetConvertible {

    public var top: CGFloat {
        return CGFloat(self)
    }

    public var left: CGFloat {
        return CGFloat(self)
    }

    public var bottom: CGFloat {
        return -CGFloat(self)
    }

    public var right: CGFloat {
        return -CGFloat(self)
    }
}
