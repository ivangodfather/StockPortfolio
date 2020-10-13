//
//  CompanyContainerView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 13/10/2020.
//

import SwiftUI

struct CompanyContainerView: View {

    @State private var selectedIndex = 0

    let symbol: String

    var body: some View {
        VStack {
            VStack(alignment: selectedIndex == 0 ? .leading : .trailing) {
                HStack {
                    CompanyHeaderButtonView(selectedIndex: $selectedIndex, text: "Summary", index: 0)
                    CompanyHeaderButtonView(selectedIndex: $selectedIndex, text: "Details", index: 1)
                }
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width / 2, height: 2)
            }
            .font(.headline)
            TabView(selection: $selectedIndex) {
                CompanyView(symbol: symbol)
                    .tag(0)
                Text("random").tag(1)
            }.tabViewStyle(PageTabViewStyle())

        }
    }
}

private struct CompanyHeaderButtonView: View {
    @Binding var selectedIndex: Int
    let text: String
    let index: Int

    var body: some View {
        Button(action: { withAnimation { selectedIndex = index } }) {
            Spacer()
            Text(text)
                .padding()
                .foregroundColor(selectedIndex == index ? .black : Color.Stock.gray)
            Spacer()
        }
    }
}

struct CompanyContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyContainerView(symbol: "AAPL")
    }
}
