//
//  UIColor.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 06.12.2021.
//

import UIKit

public extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var hexWithoutSymbol = hex

        if hexWithoutSymbol.hasPrefix("#") {
            guard let sharpIndex = hexWithoutSymbol.firstIndex(of: "#") else {
                self.init(red: 0, green: 0, blue: 0, alpha: 1)
                return
            }

            hexWithoutSymbol = String(hexWithoutSymbol[sharpIndex...])
        }

        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt64 = 0x0
        scanner.scanHexInt64(&hexInt)

        var red: UInt64 = 0x0
        var green: UInt64 = 0x0
        var blue: UInt64 = 0x0
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            red = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            green = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            blue = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
        case 6: // #RRGGBB
            red = (hexInt >> 16) & 0xff
            green = (hexInt >> 8) & 0xff
            blue = hexInt & 0xff
        default:
            break
        }

        self.init(
            red: (CGFloat(red) / 255),
            green: (CGFloat(green) / 255),
            blue: (CGFloat(blue) / 255),
            alpha: alpha
        )
    }
}

public extension UIColor {
    func asImage(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
