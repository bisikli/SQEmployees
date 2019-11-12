//
//  UIView+Constraints.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 11.12.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    public func addConstraint(attribute1: NSLayoutConstraint.Attribute, to view: UIView, attribute2: NSLayoutConstraint.Attribute? = nil, relatedBy: NSLayoutConstraint.Relation = .equal, offset: CGFloat = 0.0, multiplier: CGFloat = 1.0, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute1,
                                            relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: attribute2 ?? attribute1,
                                            multiplier: max(multiplier, 0.001),
                                            constant: offset)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        return constraint
    }


    @discardableResult
    public func addMultipleConstraints(attributes: [NSLayoutConstraint.Attribute], to view: UIView, relatedBy: NSLayoutConstraint.Relation = .equal, offset: CGFloat = 0.0, priority: Float = 1000) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        attributes.forEach { attribute in
            let constraint = addConstraint(attribute1: attribute, to: view, relatedBy: relatedBy, offset: offset, priority: priority)
            constraints.append(constraint)
        }
        return constraints
    }
    
    @discardableResult
    public func addHeightConstraint(_ height: CGFloat, relatedBy: NSLayoutConstraint.Relation = .equal, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: relatedBy,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: height)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func addWidthConstraint(_ width: CGFloat, relatedBy: NSLayoutConstraint.Relation = .equal, priority: Float = 1000) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: relatedBy,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: width)
        
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        return constraint
    }
    
    
    @discardableResult
    public func addAspectRatioConstraint(aspectRatio: CGFloat, offset: CGFloat = 0.0, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = addConstraint(attribute1: .width, to: self, attribute2: .height, offset: offset, multiplier: aspectRatio, priority: priority)
        return constraint
    }
    
    public func removeConstraintOptional(_ constraint: NSLayoutConstraint?) {
        if let constraint = constraint {
            removeConstraint(constraint)
        }
    }
}
