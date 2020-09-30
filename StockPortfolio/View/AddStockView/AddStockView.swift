//
//  AddStockView.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import SwiftUI
import Combine

struct AddStockView: View {
    @Binding var show: Bool
    let completion: (String, String) ->()
    @State private var symbol = ""
    @State private var numShares = ""

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
                    }) {
                        Text("Reset All")
                    }
                }
            }
            .navigationBarTitle(Text("Add stock"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.show = false
            }) {
                Text("Dismiss")
            }, trailing: Button(action: {
                completion(symbol, numShares)
                self.show = false
            }, label: {
                Text("Add").bold()
            }))
        }

    }
}

struct AddStockView_Previews: PreviewProvider {
    static var previews: some View {
        AddStockView(show: .constant(true), completion: { _,_ in })
    }
}
