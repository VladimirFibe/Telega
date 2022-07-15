//
//  UIView+Extensions.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit

extension UIView {
  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.topAnchor
    }
    
    return topAnchor
  }
  
  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.leftAnchor
    }
    
    return leftAnchor
  }
  
  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.rightAnchor
    }
    
    return rightAnchor
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return safeAreaLayoutGuide.bottomAnchor
    }
    
    return bottomAnchor
  }
  
  func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
    
    if #available(iOS 11, *) {
      layer.cornerRadius = radius
      layer.maskedCorners = corners
      
      return
    }
    
    var cornerMask = UIRectCorner()
    if (corners.contains(.layerMinXMinYCorner)) {
      cornerMask.insert(.topLeft)
    }
    
    if (corners.contains(.layerMaxXMinYCorner)) {
      cornerMask.insert(.topRight)
    }
    
    if (corners.contains(.layerMinXMaxYCorner)) {
      cornerMask.insert(.bottomLeft)
    }
    
    if (corners.contains(.layerMaxXMaxYCorner)) {
      cornerMask.insert(.bottomRight)
    }
    
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: cornerMask,
                            cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}
