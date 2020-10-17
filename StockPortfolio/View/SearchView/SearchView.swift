//
//  SearchView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 03/10/2020.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var selectedItem: QuoteDetail?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search stock", text: $searchText).textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                switch viewModel.state {
                case .initial:
                    VStack(spacing: 16) {
                        Image(systemName: "magnifyingglass").resizable().frame(width: 64, height: 64)
                        Text("Start searching now!")
                    }.foregroundColor(Color.Stock.gray)
                case .loading:
                    ProgressView()
                case .results(let values):
                    List {
                        ForEach(values) { quoteDetail in
                            HStack {
                                Text(quoteDetail.quote.symbol)
                                Text(quoteDetail.quote.symbol)
                            }.onTapGesture {
                                selectedItem = quoteDetail
                            }
                        }
                    }.listStyle(PlainListStyle())
                case .error(let description):
                    Text("Something went wrong.. \(description)")
                }
                Spacer()
            }
            .padding()
            .onChange(of: searchText) { term in
                viewModel.didSearch(term)
            }
            .sheet(item: self.$selectedItem, content: { item in
                AddStockView(completion: { _ in }, symbol: item.quote.symbol)
            })
            .navigationBarTitle("Search")
        }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
