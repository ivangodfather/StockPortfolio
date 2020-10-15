//
//  ToolTip.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 15/10/2020.
//

import SwiftUI

struct ToolTip: View {
    let text: String

    private let bgColor = Color.green
    var body: some View {
        ZStack {
            Rectangle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 0.5)
                .fill(bgColor)
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(135))
                .offset(x: 0, y: 5)
            Text(text)
                .foregroundColor(.white)
                .padding(4)
                .background(bgColor)
                .cornerRadius(4)
                .font(.callout)

        }
    }
}


struct ToolTip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToolTip(text: "2.2")
        }
    }
}
