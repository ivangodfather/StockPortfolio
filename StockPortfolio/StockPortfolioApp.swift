//
//  StockPortfolioApp.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 28/09/2020.
//

import SwiftUI
import CoreData

@main
struct StockPortfolioApp: App {
    var body: some Scene {
        WindowGroup {
            StockListView().environment(\.managedObjectContext, PersistenceManager.shared.context)
        }
    }
}
