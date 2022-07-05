//
//  UIFont+Extensions.swift
//  Telega
//
//  Created by Vladimir Fibe on 04.07.2022.
//
//for family in UIFont.familyNames.sorted() {
//  let names = UIFont.fontNames(forFamilyName: family)
//  print(family, names)
//}

import UIKit

extension UIFont {
  static func commissionerMedium12() -> UIFont? {
    UIFont.init(name: "Commissioner-Medium", size: 12)
  }
  
  static func commissioner14() -> UIFont? {
    UIFont.init(name: "Commissioner-Regular", size: 14)
  }
  
  static func commissioner12() -> UIFont? {
    UIFont.init(name: "Commissioner-Regular", size: 12)
  }
}
