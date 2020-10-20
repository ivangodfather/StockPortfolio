//
//  CompanyHeaderButtonView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 14/10/2020.
//

import SwiftUI

struct CompanyHeaderTabButtonView: View {
    @Binding var selectedIndex: Int
    let text: String
    let index: Int

    var body: some View {
        Button(action: { withAnimation { selectedIndex = index } }) {
            Spacer()
            Text(text)
                .padding()
                .foregroundColor(selectedIndex == index ? .gray : Color.accentColor)
            Spacer()
        }
    }
}

struct CompanyHeaderTabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeaderTabButtonView(selectedIndex: .constant(0), text: "Summary", index: 0)
    }
}
