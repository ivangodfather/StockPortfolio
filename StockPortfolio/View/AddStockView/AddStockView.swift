//
//  AddStockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Combine

struct AddStockView: View {
    let completion: (Stock) -> Void

    @State private var symbol: String
    @State private var numShares = ""
    @Environment(\.presentationMode) var presentationMode

    private let viewModel = AddStockViewModel()

    init(completion: @escaping (Stock) -> Void, symbol: String = "") {
        self.completion = completion
        self._symbol = State(initialValue: symbol)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Ticker symbol, i.e., AAPL, GOOGL, TWTR", text: $symbol)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                    TextField("Number of shares", text: $numShares)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button(action: {
                        symbol = ""
                        numShares = ""
                    }, label: {
                        Text("Reset All")
                    })
                }
            }
            .navigationBarTitle(Text("Add stock"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.addStock(symbol: symbol, shares: numShares)
            }, label: {
                Text("Add").bold()
            }))
            .onReceive(viewModel.didFinishPublisher) { stock in
                completion(stock)
                presentationMode.wrappedValue.dismiss()
            }
            .onAppear {
                self.symbol = symbol
            }
        }
    }
}

struct AddStockView_Previews: PreviewProvider {
    static var previews: some View {
        AddStockView(completion: { _ in })
    }
}
