//
//  Title.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import SwiftUI

struct Title: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }
    var body: some View {
        HStack {
            Text(text.uppercased())
                .font(.title2)
                .foregroundColor(.blue)
                .bold()
            Spacer()
        }
        .padding(.top, 16)
    }
}
