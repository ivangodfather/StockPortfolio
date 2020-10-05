//
//  DiscoverStockList.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 05/10/2020.
//

import SwiftUI
import SwiftUI

struct DiscoverSectorView: View {
    let sector: String

    @StateObject private var viewModel = DiscoverSectorViewModel()

    var body: some View {
        List(viewModel.stocks, id: \.symbol) { stock in
            Text(stock.companyName)
        }
        .navigationBarTitle(sector)
        .onAppear {
            self.viewModel.requestStocks(from: "sector", value: sector)
        }
    }
}

struct DiscoverStockListView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverSectorView(sector: "Alchemy")
    }
}
