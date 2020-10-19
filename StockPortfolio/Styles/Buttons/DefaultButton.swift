//
//  DefaultButton.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 19/10/2020.
//

import SwiftUI

struct ActionButton: View {
    let action: () -> Void
    let image: Image
    let text: String

    var body: some View {
            Button(action: action, label: {
                HStack {
                    image
                    Text(text)
                        .bold()
                }
                .foregroundColor(.white)
            }).buttonStyle(ActionButtonStyle(bgColor: Color.Stock.blue))
    }

}
