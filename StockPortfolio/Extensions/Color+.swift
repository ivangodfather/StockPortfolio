//
//  Color+.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 01/10/2020.
//

import SwiftUI

extension Color {
    struct App {
        static let green = Color("Green")
        static let red = Color("Red")
        static let background = Color("Background")
        static let background2 = Color("Background2")
    }

    public init(hex: Int) {
        self.init(UIColor(hex: hex))
   }

    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)

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

