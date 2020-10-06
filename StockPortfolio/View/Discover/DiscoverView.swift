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
    @State private var selectedCollection = 0

    var body: some View {

        NavigationView {
            VStack {
                Picker(selection: $selectedCollection, label: Text("Choose option"), content: {
                    ForEach(ListType.allCases) { listType in
                        Text(listType.description).tag(listType.id)
                    }
                }).pickerStyle(SegmentedPickerStyle())
                .padding()
                QuoteListView(quotes: viewModel.quotes, onDelete: nil)
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
