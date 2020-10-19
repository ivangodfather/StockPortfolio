//
//  NoDataView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 19/10/2020.
//

import Foundation
import SwiftUI

struct NodataView: View {

    let title: String
    let subtitle: String
    let button: (text: String, action: () -> ())?

    var body: some View {
        VStack {
            Text(title).font(.title)
            Text(subtitle).font(.subheadline)
                .padding(.vertical)

            if let button = button {
                Button(action: button.action, label: {
                    Text(button.text)
                })
            }
        }.padding()
    }
}

struct NodataView_Previews: PreviewProvider {
    static var previews: some View {
        NodataView(title: "Watch your stocks",
                   subtitle: "Some random subtitle ... .... test",
                   button: (text: "Create", action: { }))
    }
}
