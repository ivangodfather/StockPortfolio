//
//  Color+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 01/10/2020.
//

import SwiftUI

extension Color {
    struct Stock {
        static let green = Color(red: 50/255, green: 200/255, blue: 150/255)
        static let red = Color(red: 200/255, green: 50/255, blue: 100/255)
        static let gray = Color(hex: 0x2d4059)
        static let blue = Color(hex: 0x07689f)
    }

    public init(hex: Int) {
        self.init(UIColor(hex: hex))
   }

}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

