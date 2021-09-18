//
//  UIColor+Hex.swift
//  RegisterApp
//
//  Created by Curitiba01 on 17/09/21.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init?(rgbHexString: String) {
        var rgb: UInt64 = 0
        let hexString = rgbHexString.replacingOccurrences(of: "#", with: "")
        guard Scanner(string: hexString).scanHexInt64(&rgb) else { return nil }
        let intRGB = Int(rgb)
        self.init(rgb: intRGB)
    }
}
