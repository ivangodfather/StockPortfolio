//
//  TestGroupBoxStyle.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import Foundation
import SwiftUI

struct MyGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content.foregroundColor(.white)
        }
        .padding(16)
        .background(Color.gray.opacity(0.3).blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(16)
        .shadow(color: .gray, radius: 8, x: 10, y: 10)

    }

}

struct MyGroupBoxStylePreviews: PreviewProvider {
    static var previews: some View {
        GroupBox(label: Title("Random"), content: {
            Text("Content")
        }).groupBoxStyle(MyGroupBoxStyle())
    }
}
