//
//  DetailListView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import SwiftUI

struct DetailListView: View {
    let title: String
    let data: [(key: String, value: String)]


    var body: some View {
        GroupBox(label: Title(title)) {
            ForEach(Array(data.enumerated()), id: \.0) { index, tuple in
                HStack {
                    Text(tuple.key)
                        .font(.callout)
                    Spacer()
                    Text(tuple.value)
                        .font(.callout)
                        .bold()
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(index.isMultiple(of: 2) ? Color.App.background2 : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

            }
        }.groupBoxStyle(MyGroupBoxStyle())
    }
}

struct DetailListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailListView(
            title: "Test title",
            data: [("Hola", "30"), ("tessst", "40"), ("nose", "jojo")]
        )
    }
}
