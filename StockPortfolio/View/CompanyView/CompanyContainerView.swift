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
                    Button(action: {
                        withAnimation {
                            selectedIndex = 0
                        }
                    }) {
                        Spacer()
                        Text("Summary").padding()
                            .foregroundColor(selectedIndex == 0 ? .black : Color.Stock.gray)
                        Spacer()
                    }
                    Button(action: { withAnimation { selectedIndex = 1 } }) {
                        Spacer()
                        Text("Details").padding()
                            .foregroundColor(selectedIndex == 1 ? .black : Color.Stock.gray)
                        Spacer()
                    }
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

struct CompanyContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyContainerView(symbol: "AAPL")
    }
}
