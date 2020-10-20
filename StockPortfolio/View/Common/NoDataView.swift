//
//  NoDataView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 19/10/2020.
//

import Foundation
import SwiftUI

struct NoDataView: View {

    let title: String
    let subtitle: String
    let button: (text: String, action: () -> ())?

    var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.title)
            Text(subtitle).font(.subheadline)
                .padding(.vertical)

            if let button = button {
                ActionButton(action: button.action, image: Image(systemName: "plus"), text: button.text)
                    .padding(.top)
            }
        }
        .padding()
    }
}

struct NodataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(title: "Watch your stocks",
                   subtitle: "Some random subtitle ... .... test",
                   button: (text: "Create", action: { }))
    }
}
