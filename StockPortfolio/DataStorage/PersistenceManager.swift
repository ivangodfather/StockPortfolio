//
//  PersistenceManager.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import CoreData
import UIKit

class PersistenceManager {

  static let shared = PersistenceManager()
    
  let persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "StockPortfolio")
      container.loadPersistentStores(completionHandler: { (_, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

  init() {
    let center = NotificationCenter.default
    let notification = UIApplication.willResignActiveNotification

    _ = center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
      guard let self = self else { return }

      if self.persistentContainer.viewContext.hasChanges {
        try? self.persistentContainer.viewContext.save()
      }
    }
  }
}
