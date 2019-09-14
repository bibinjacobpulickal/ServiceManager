//
//  AutoLayoutableExtensions.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 29/10/18.
//  Copyright © 2018 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public extension AutoLayoutable {

    func addSubview(
        _ view: AutoLayoutable,
        anchors: Set<NSLayoutConstraint.Attribute>      = [],
        top: NSLayoutYAxisAnchor?                       = nil,
        topRelation: NSLayoutConstraint.Relation        = .equal,
        left: NSLayoutXAxisAnchor?                      = nil,
        leftRelation: NSLayoutConstraint.Relation       = .equal,
        leading: NSLayoutXAxisAnchor?                   = nil,
        leadingRelation: NSLayoutConstraint.Relation    = .equal,
        bottom: NSLayoutYAxisAnchor?                    = nil,
        bottomRelation: NSLayoutConstraint.Relation     = .equal,
        right: NSLayoutXAxisAnchor?                     = nil,
        rightRelation: NSLayoutConstraint.Relation      = .equal,
        trailing: NSLayoutXAxisAnchor?                  = nil,
        trailingRelation: NSLayoutConstraint.Relation   = .equal,
        inset: EdgeInsetConvertible                     = 0,
        centerX: NSLayoutXAxisAnchor?                   = nil,
        centerXRelation: NSLayoutConstraint.Relation    = .equal,
        centerY: NSLayoutYAxisAnchor?                   = nil,
        centerYRelation: NSLayoutConstraint.Relation    = .equal,
        offset: OffsetConvertible                       = 0,
        width: NSLayoutDimension?                       = nil,
        widthRelation: NSLayoutConstraint.Relation      = .equal,
        height: NSLayoutDimension?                      = nil,
        heightRelation: NSLayoutConstraint.Relation     = .equal,
        multiplier: MultiplierConvertible               = 1,
        size: SizeConvertible                           = 0) {

        addSubview(view)

        anchorView(
            view,
            anchors: anchors,
            top: top,
            topRelation: topRelation,
            left: left,
            leftRelation: leftRelation,
            leading: leading,
            leadingRelation: leadingRelation,
            bottom: bottom,
            bottomRelation: bottomRelation,
            right: right,
            rightRelation: rightRelation,
            trailing: trailing,
            trailingRelation: trailingRelation,
            inset: inset,
            centerX: centerX,
            centerXRelation: centerXRelation,
            centerY: centerY,
            centerYRelation: centerYRelation,
            offset: offset,
            width: width,
            widthRelation: widthRelation,
            height: height,
            heightRelation: heightRelation,
            multiplier: multiplier,
            size: size)
    }

    func anchorView(
        _ view: AutoLayoutable,
        anchors: Set<NSLayoutConstraint.Attribute>      = [],
        top: NSLayoutYAxisAnchor?                       = nil,
        topRelation: NSLayoutConstraint.Relation        = .equal,
        left: NSLayoutXAxisAnchor?                      = nil,
        leftRelation: NSLayoutConstraint.Relation       = .equal,
        leading: NSLayoutXAxisAnchor?                   = nil,
        leadingRelation: NSLayoutConstraint.Relation    = .equal,
        bottom: NSLayoutYAxisAnchor?                    = nil,
        bottomRelation: NSLayoutConstraint.Relation     = .equal,
        right: NSLayoutXAxisAnchor?                     = nil,
        rightRelation: NSLayoutConstraint.Relation      = .equal,
        trailing: NSLayoutXAxisAnchor?                  = nil,
        trailingRelation: NSLayoutConstraint.Relation   = .equal,
        inset: EdgeInsetConvertible                     = 0,
        centerX: NSLayoutXAxisAnchor?                   = nil,
        centerXRelation: NSLayoutConstraint.Relation    = .equal,
        centerY: NSLayoutYAxisAnchor?                   = nil,
        centerYRelation: NSLayoutConstraint.Relation    = .equal,
        offset: OffsetConvertible                       = 0,
        width: NSLayoutDimension?                       = nil,
        widthRelation: NSLayoutConstraint.Relation      = .equal,
        height: NSLayoutDimension?                      = nil,
        heightRelation: NSLayoutConstraint.Relation     = .equal,
        multiplier: MultiplierConvertible               = 1,
        size: SizeConvertible                           = 0) {

        anchorEdges(
            view,
            sides: anchors,
            top: top,
            topRelation: topRelation,
            left: left,
            leftRelation: leftRelation,
            leading: leading,
            leadingRelation: leadingRelation,
            bottom: bottom,
            bottomRelation: bottomRelation,
            right: right,
            rightRelation: rightRelation,
            trailing: trailing,
            trailingRelation: trailingRelation,
            inset: inset)
        anchorCenters(
            view,
            centers: anchors,
            centerX: centerX,
            centerXRelation: centerXRelation,
            centerY: centerY,
            centerYRelation: centerYRelation,
            offset: offset)
        anchorSides(
            view,
            sides: anchors,
            width: width,
            widthRelation: widthRelation,
            height: height,
            heightRelation: heightRelation,
            multiplier: multiplier,
            size: size)
    }

    func anchorEdges(
        _ view: AutoLayoutable,
        sides: Set<NSLayoutConstraint.Attribute>        = [],
        top: NSLayoutYAxisAnchor?                       = nil,
        topRelation: NSLayoutConstraint.Relation        = .equal,
        left: NSLayoutXAxisAnchor?                      = nil,
        leftRelation: NSLayoutConstraint.Relation       = .equal,
        leading: NSLayoutXAxisAnchor?                   = nil,
        leadingRelation: NSLayoutConstraint.Relation    = .equal,
        bottom: NSLayoutYAxisAnchor?                    = nil,
        bottomRelation: NSLayoutConstraint.Relation     = .equal,
        right: NSLayoutXAxisAnchor?                     = nil,
        rightRelation: NSLayoutConstraint.Relation      = .equal,
        trailing: NSLayoutXAxisAnchor?                  = nil,
        trailingRelation: NSLayoutConstraint.Relation   = .equal,
        inset: EdgeInsetConvertible                     = 0) {

        view.translatesAutoresizingMaskIntoConstraints  = false

        if sides.contains(.top) || top != nil {
            view.anchor(
                lhs: .top,
                relation: topRelation,
                rhs: top ?? topAnchor,
                constant: inset.top)
        }
        if sides.contains(.left) || left != nil {
            view.anchor(
                lhs: .left,
                relation: leftRelation,
                rhs: left ?? leftAnchor,
                constant: inset.left)
        }
        if sides.contains(.leading) || leading != nil {
            view.anchor(
                lhs: .leading,
                relation: leadingRelation,
                rhs: leading ?? leadingAnchor,
                constant: inset.left)
        }
        if sides.contains(.bottom) || bottom != nil {
            view.anchor(
                lhs: .bottom,
                relation: bottomRelation,
                rhs: bottom ?? bottomAnchor,
                constant: inset.bottom)
        }
        if sides.contains(.right) || right != nil {
            view.anchor(
                lhs: .right,
                relation: rightRelation,
                rhs: right ?? rightAnchor,
                constant: inset.right)
        }
        if sides.contains(.trailing) || trailing != nil {
            view.anchor(
                lhs: .trailing,
                relation: trailingRelation,
                rhs: trailing ?? trailingAnchor,
                constant: inset.right)
        }
    }

    func anchorCenters(
        _ view: AutoLayoutable,
        centers: Set<NSLayoutConstraint.Attribute>      = [],
        centerX: NSLayoutXAxisAnchor?                   = nil,
        centerXRelation: NSLayoutConstraint.Relation    = .equal,
        centerY: NSLayoutYAxisAnchor?                   = nil,
        centerYRelation: NSLayoutConstraint.Relation    = .equal,
        offset: OffsetConvertible                       = 0) {

        view.translatesAutoresizingMaskIntoConstraints  = false

        if centers.contains(.centerX) || centerX != nil {
            view.anchor(
                lhs: .centerX,
                relation: centerXRelation,
                rhs: centerX ?? centerXAnchor,
                constant: offset.horizontal)
        }
        if centers.contains(.centerY) || centerY != nil {
            view.anchor(
                lhs: .centerY,
                relation: centerYRelation,
                rhs: centerY ?? centerYAnchor,
                constant: offset.vertical)
        }
    }

    func anchorSides(
        _ view: AutoLayoutable,
        sides: Set<NSLayoutConstraint.Attribute>        = [],
        width: NSLayoutDimension?                       = nil,
        widthRelation: NSLayoutConstraint.Relation      = .equal,
        height: NSLayoutDimension?                      = nil,
        heightRelation: NSLayoutConstraint.Relation     = .equal,
        multiplier: MultiplierConvertible               = 1,
        size: SizeConvertible                           = 0) {

        view.translatesAutoresizingMaskIntoConstraints  = false

        if sides.contains(.width) || width != nil {
            view.anchor(
                lhs: .width,
                relation: widthRelation,
                rhs: width ?? widthAnchor,
                multiplier: multiplier.multiplierValue.width,
                constant: size.width)
        } else if size.width != 0 {
            view.anchor(
                lhs: .width,
                relation: widthRelation,
                rhs: size.width)
        }
        if sides.contains(.height) || height != nil {
            view.anchor(
                lhs: .height,
                relation: heightRelation,
                rhs: height ?? heightAnchor,
                multiplier: multiplier.multiplierValue.height,
                constant: size.height)
        } else if size.height != 0 {
            view.anchor(
                lhs: .height,
                relation: heightRelation,
                rhs: size.height)
        }
    }

    func anchor<Axis>(
        lhs: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation   = .equal,
        rhs: NSLayoutAnchor<Axis>?              = nil,
        multiplier: CGFloat                     = 1,
        constant: CGFloat                       = 0) {

        let lhs = anchor(for: lhs) as NSLayoutAnchor<Axis>?

        switch relation {
        case .lessThanOrEqual:
            if let lhs = lhs as? NSLayoutDimension {
                if let rhs = rhs as? NSLayoutDimension {
                    lhs.constraint(
                        lessThanOrEqualTo: rhs,
                        multiplier: multiplier,
                        constant: constant)
                        .isActive = true
                } else if constant != 0 {
                    lhs.constraint(
                        lessThanOrEqualToConstant: constant)
                        .isActive = true
                }
            } else if let rhs = rhs {
                lhs?.constraint(
                    lessThanOrEqualTo: rhs,
                    constant: constant)
                    .isActive = true
            }
        case .greaterThanOrEqual:
            if let lhs = lhs as? NSLayoutDimension {
                if let rhs = rhs as? NSLayoutDimension {
                    lhs.constraint(
                        greaterThanOrEqualTo: rhs,
                        multiplier: multiplier,
                        constant: constant)
                        .isActive = true
                } else if constant != 0 {
                    lhs.constraint(
                        greaterThanOrEqualToConstant: constant)
                        .isActive = true
                }
            } else if let rhs = rhs {
                lhs?.constraint(
                    greaterThanOrEqualTo: rhs,
                    constant: constant)
                    .isActive = true
            }
        default:
            if let lhs = lhs as? NSLayoutDimension {
                if let rhs = rhs as? NSLayoutDimension {
                    lhs.constraint(
                        equalTo: rhs,
                        multiplier: multiplier,
                        constant: constant)
                        .isActive = true
                } else if constant != 0 {
                    lhs.constraint(
                        equalToConstant: constant)
                        .isActive = true
                }
            } else if let rhs = rhs {
                lhs?.constraint(
                    equalTo: rhs,
                    constant: constant)
                    .isActive = true
            }
        }
    }

    func anchor(
        lhs: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation   = .equal,
        rhs: CGFloat                            = 0) {

        let lhs = anchor(for: lhs) as NSLayoutAnchor<NSLayoutDimension>?

        switch relation {
        case .lessThanOrEqual:
            if let lhs = lhs as? NSLayoutDimension {
                lhs.constraint(
                    lessThanOrEqualToConstant: rhs)
                    .isActive = true
            }
        case .greaterThanOrEqual:
            if let lhs = lhs as? NSLayoutDimension {
                lhs.constraint(
                    greaterThanOrEqualToConstant: rhs)
                    .isActive = true
            }
        default:
            if let lhs = lhs as? NSLayoutDimension {
                lhs.constraint(
                    equalToConstant: rhs)
                    .isActive = true
            }
        }
    }

    private func anchor<AnchorType: AnyObject>(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutAnchor<AnchorType>? {
        switch attribute {
        case .top:
            return top as? NSLayoutAnchor<AnchorType>
        case .left:
            return left as? NSLayoutAnchor<AnchorType>
        case .leading:
            return leading as? NSLayoutAnchor<AnchorType>
        case .bottom:
            return bottom as? NSLayoutAnchor<AnchorType>
        case .right:
            return right as? NSLayoutAnchor<AnchorType>
        case .trailing:
            return trailing as? NSLayoutAnchor<AnchorType>
        case .width:
            return width as? NSLayoutAnchor<AnchorType>
        case .height:
            return height as? NSLayoutAnchor<AnchorType>
        case .centerX:
            return centerX as? NSLayoutAnchor<AnchorType>
        case .centerY:
            return centerY as? NSLayoutAnchor<AnchorType>
        default:
            return nil
        }
    }
}
