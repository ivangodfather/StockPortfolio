//
//  DiscoverView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 04/10/2020.
//

import SwiftUI
import Combine


struct DiscoverView: View {

    @StateObject private var viewModel = DiscoverViewModel()
    @AppStorage("discoverSelection") private var selectedCollection = 0

    var body: some View {

        NavigationView {
            VStack {
                Picker(selection: $selectedCollection, label: Text("Choose option"), content: {
                    ForEach(ListType.allCases) { listType in
                        Text(listType.description).tag(listType.id)
                    }
                }).pickerStyle(SegmentedPickerStyle())
                .padding()
                Spacer()
                switch viewModel.state {
                case .loading: ProgressView()
                case .loaded(let quotes):
                    QuoteListView(quotes: quotes, onDelete: nil)
                case .error(let description): NoDataView(title: "Ups! Something went wrong", subtitle: description, button: ("Retry", { self.viewModel.request(listIndex: selectedCollection) }))
                }
                Spacer()

            }
            .onChange(of: selectedCollection, perform: self.viewModel.request(listIndex:))
            .navigationBarTitle("Discover")
            .onAppear {
                self.viewModel.request(listIndex: selectedCollection)
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
