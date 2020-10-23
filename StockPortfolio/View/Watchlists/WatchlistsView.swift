//
//  WatchlistsView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 06/10/2020.
//

import SwiftUI

struct WatchlistsView: View {

    @StateObject private var viewModel = WatchlistsViewModel()
    @State private var isManageWatchlistsPresented = false
    @State private var isSearchViewPresented = false
    @State private var useExtendedHours = false
    @State private var marketType = 0

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .initial: ProgressView()
                case .emptyWatchlists:
                    addNoWatchlistsView()
                    ActionButton(action: { viewModel.insertSampleData() }, image: Image(systemName: "plus.square.on.square"), text: "Insert sample data").padding(.top)
                case .error(let description): addErrorView(errorText: description)
                case .emptySymbols: addNoSymbolsView()
                case .loading: ProgressView()
                case .loadedWatchList(let quotes): WatchlistLoadedView(quotes: quotes, onDelete:viewModel.deleteQuote)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: { isManageWatchlistsPresented.toggle() }) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(viewModel.watchlistName)
                                .font(.title)
                                .bold()
                                .background(
                                    Image(systemName: "arrow.down.to.line.alt").font(.system(size: 11)).padding(.top, 4).padding(.leading, 4)
                                        .alignmentGuide(.trailing, computeValue: { dimension in
                                            dimension[HorizontalAlignment.leading]
                                        })
                                    , alignment: .trailing)

                        }
                        .foregroundColor(Color.accentColor)
                    }
                }
            }
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: { viewModel.loadWatchlists() }, label: {
                                    Image(systemName: "arrow.clockwise.circle").padding(.horizontal)
                                }))
        }
        .onAppear {
            viewModel.loadWatchlists()
        }
        .sheet(isPresented: $isManageWatchlistsPresented) {
            ManageWatchlists(didSelectWatchlist: { watchlist in
                DispatchQueue.main.async {
                    self.viewModel.didSelect(watchlist)
                    self.isManageWatchlistsPresented = false
                }

            }, didDeleteWatchlist: { watchlist in
                self.viewModel.didDeleteWatchlist(watchlist)
            })
        }
    }

    private func addNoWatchlistsView() -> some View {
        NoDataView(title: "Track your stocks",
                   subtitle: "Create a new watchlist and start tracking your stocks",
                   button: (text: "Add watchlist", action: { isManageWatchlistsPresented = true })
        )
    }

    private func addErrorView(errorText: String) -> some View {
        NoDataView(title: "Ups! Something went wrong",
                   subtitle: errorText,
                   button: (text: "Retry", action: { viewModel.loadWatchlists() })
        )
    }

    private func addNoSymbolsView() -> some View {
        NoDataView(title: "Your watchlist is empty",
                   subtitle: "Start adding symbols and track the performance",
                   button: (text: "Add new symbols", action: { NotificationCenter.default.post(name: .searchView, object: nil, userInfo: nil)
                   })
        )
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistsView()
    }
}
