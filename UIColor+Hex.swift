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
    self.red = red / 255
    self.green = green / 255
    self.blue = blue / 255
  }
  
  init(red: Int, green: Int, blue: Int) {
    self.red = CGFloat(red / 255)
    self.green = CGFloat(green / 255)
    self.blue = CGFloat(blue / 255)
  }
}

private func parseHexValue(value: String) -> RGB? {
  var retValue = value
  if retValue.contains("#") {
    retValue = String(value[String.Index(utf16Offset: 1, in: value)...])
  }
  
  if retValue.count == 3 {
    var tmp = ""
    for char in retValue {
      tmp += String(repeating: char, count: 2)
    }
    retValue = tmp
  } else if retValue.count != 6 {
    return nil
  }
  
  guard let red = Int(retValue[String.Index(utf16Offset: 0, in: retValue)..<String.Index(utf16Offset: 2, in: retValue)], radix: 16) else {
    return nil
  }
  guard let green = Int(retValue[String.Index(utf16Offset: 2, in: retValue)..<String.Index(utf16Offset: 4, in: retValue)], radix: 16) else {
    return nil
  }
  guard let blue = Int(retValue[String.Index(utf16Offset: 4, in: retValue)...], radix: 16) else {
    return nil
  }
  
  return RGB(red: red, green: green, blue: blue)
}

extension UIColor {
  convenience init(hex: String) {
    guard let color = parseHexValue(value: hex) else {
      fatalError("Color value is not Hex form.")
    }
    self.init(displayP3Red: color.red,
              green: color.green,
              blue: color.blue,
              alpha: 1.0)
  }
}
