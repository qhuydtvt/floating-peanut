//
//  UIView.swift
//  Hackathon
//
//  Created by Developer on 12/16/16.
//  Copyright © 2016 Developer. All rights reserved.
//
import UIKit
import Foundation

@IBDesignable
public class CustomUIView: UIView {}

extension UIView {
    static public func disableAndHideView(views: UIView...) {
        for view in views {
            view.isHidden = true
            view.isUserInteractionEnabled = false
        }
    }
    
    static public func enableAndShowView(views: UIView...) {
        for view in views {
            view.isHidden = false
            view.isUserInteractionEnabled = true
        }
    }
    
    public var width: CGFloat { return self.frame.width }
    public var height: CGFloat { return self.frame.height }
    
    // Circle
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

}
