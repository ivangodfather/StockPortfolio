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

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search stock", text: $searchText)
                    .foregroundColor(Color.Stock.gray)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
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
                            NavigationLink(
                                destination: CompanyView(symbol: quoteDetail.quote.symbol),
                                label: {
                                    QuoteRowView(quoteDetail: quoteDetail)
                                })
                        }
                    }.listStyle(PlainListStyle())
                case .error(let description):
                    Text("Something went wrong.. \(description)")
                }
                Spacer()
            }
            .onChange(of: searchText, perform: viewModel.didSearch)
            .navigationBarTitle("Search")
        }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
