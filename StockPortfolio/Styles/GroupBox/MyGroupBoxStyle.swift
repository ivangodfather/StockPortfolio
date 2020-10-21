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
        HStack {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content.foregroundColor(.primary)
        }
            Spacer()
        }
        .padding(8)
        .background(Color.App.background)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .padding(8)
        .shadow(color: Color.App.background2, radius: 4, x: 5, y: 5)

    }

}

struct MyGroupBoxStylePreviews: PreviewProvider {
    static var previews: some View {
        GroupBox(label: Title("Random"), content: {
            Text("Content")
        }).groupBoxStyle(MyGroupBoxStyle())
    }
}
