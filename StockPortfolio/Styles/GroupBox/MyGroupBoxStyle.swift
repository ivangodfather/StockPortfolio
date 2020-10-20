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
            configuration.content.foregroundColor(.primary)
        }
        .padding(16)
        .background(Color.App.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(16)
        .shadow(color: Color.App.background, radius: 8, x: 10, y: 10)

    }

}

struct MyGroupBoxStylePreviews: PreviewProvider {
    static var previews: some View {
        GroupBox(label: Title("Random"), content: {
            Text("Content")
        }).groupBoxStyle(MyGroupBoxStyle())
    }
}
