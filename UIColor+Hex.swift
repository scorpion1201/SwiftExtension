//
//  UIColor+Hex.swift
//  SwiftExtension
//
//  Created by David Park on 12/01/2019.
//  Copyright © 2019 David Park. All rights reserved.
//

import Foundation

private struct RGB {
  let red: CGFloat
  let green: CGFloat
  let blue: CGFloat
  
  init(red: CGFloat, green: CGFloat, blue: CGFloat) {
    self.blue = blue / 255
    self.green = green / 255
    self.red = red / 255
  }
  
  init(red: Int, green: Int, blue: Int) {
    self.blue = CGFloat(blue) / 255
    self.green = CGFloat(green) / 255
    self.red = CGFloat(red) / 255
  }
}

private func parseHexValue(value: String) -> RGB? {
  var val = value
  if val.contains("#") {
    val = String(value[String.Index(encodedOffset: 1)...])
  }
  
  // #fff or #fef
  if val.count == 3 {
    var tmp = ""
    for char in val {
      tmp += String(repeating: char, count: 2)
    }
    val = tmp
  } else if val.count != 6 {
    return nil
  }
  
  guard let red = Int(val[String.Index(encodedOffset: 0)..<String.Index(encodedOffset: 2)], radix: 16) else {
    return nil
  }
  guard let green = Int(val[String.Index(encodedOffset: 2)..<String.Index(encodedOffset: 4)], radix: 16) else {
    return nil
  }
  guard let blue = Int(val[String.Index(encodedOffset: 4)...], radix: 16) else {
    return nil
  }
  
  return RGB(red: red, green: green, blue: blue)
}

extension UIColor {
  convenience init(hex: String) {
    guard let color = parseHexValue(value: hex) else {
      fatalError("Color value is not Hex form.")
    }
    
    self.init(red: color.red,
              green: color.green,
              blue: color.blue,
              alpha: 1.0)
  }
}
