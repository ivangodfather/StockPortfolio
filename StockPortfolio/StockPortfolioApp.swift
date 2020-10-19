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

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.Stock.gray)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.Stock.gray)]
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.Stock.blue)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.Stock.gray)], for: .normal)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .edgesIgnoringSafeArea(.all)
                .environment(\.managedObjectContext, PersistenceManager.shared.context)
        }
    }
}
