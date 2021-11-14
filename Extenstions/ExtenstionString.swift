//
//  ExtenstionString.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import UIKit
extension String{
    func oldPriceStrikeThrough() -> NSAttributedString {
          let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
          return attributeString
      }
}
