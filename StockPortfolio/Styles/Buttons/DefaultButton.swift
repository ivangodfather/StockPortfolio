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
                Label(
                    title: { Text(text).bold() },
                    icon: { image })

                .foregroundColor(.white)
            }).buttonStyle(ActionButtonStyle())
    }

}
