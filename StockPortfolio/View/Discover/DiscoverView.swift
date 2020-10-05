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
                Picker(selection: $selectedCollection, label: Text("Select a collection")) {
                    ForEach(CollectionType.allCases, id: \.rawValue) { collectionType in
                        Text(collectionType.description).tag(collectionType.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(viewModel.collections, id: \.name) { collection in
                        Text(collection.name)
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    self.viewModel.requestCollection(type: .sector)
                }
            }
            .onChange(of: selectedCollection, perform: { selectedCollectionType in
                switch selectedCollectionType {
                case CollectionType.sector.rawValue:
                    self.viewModel.requestCollection(type: .sector)
                default :
                    self.viewModel.requestCollection(type: .tags)
                }
            })
            .navigationBarTitle("Discover")
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
