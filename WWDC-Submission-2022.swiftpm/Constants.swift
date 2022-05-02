//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI
import UIKit

class ColorPalette {
    // Colors
    static public var lightBlue = Color(ColorPalette.hexStringToUIColor(hex: "#141e30"))//UIColor(red: 0.33, green: 0.41, blue: 0.46, alpha: 1.00))
    static public var darkBlue = Color(ColorPalette.hexStringToUIColor(hex: "#243b55"))//UIColor(red: 0.16, green: 0.18, blue: 0.29, alpha: 1.00))
    static public var lightGrey = Color(UIColor(red: 0.39, green: 0.42, blue: 0.48, alpha: 1.00))
    
    static public let lightBlue1 = Color(ColorPalette.hexStringToUIColor(hex: "#a1c4fd"))
    static public let lightBlue2 = Color(ColorPalette.hexStringToUIColor(hex: "#c2e9fb"))
    
    static public let lightPink1 = Color(ColorPalette.hexStringToUIColor(hex: "#ff9a9e"))
    static public let lightPink2 = Color(ColorPalette.hexStringToUIColor(hex: "#fad0c4"))
    
    // Methods
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
