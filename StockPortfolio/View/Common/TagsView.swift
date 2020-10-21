//
//  TagsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 20/10/2020.
//

import SwiftUI

struct TagsView: View {

    private let rows: [GridItem] =  [
        GridItem(.flexible())
    ]
    let tags: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .bold()
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 4).fill(Color.App.background)
                        ).font(.footnote)
                }
            }.padding(.horizontal)
        }.frame(height: 60)
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(tags: ["a", "nose", "jejejej", "bbb"])
    }
}
