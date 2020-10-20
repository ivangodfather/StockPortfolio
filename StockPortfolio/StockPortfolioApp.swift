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
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primary)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.primary)]
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.primary)], for: .normal)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .edgesIgnoringSafeArea(.all)
                .environment(\.managedObjectContext, PersistenceManager.shared.context)
        }
    }
}
