//
//  CoreDataWatchlist+CoreDataProperties.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 18/10/2020.
//
//

import Foundation
import CoreData


extension CoreDataWatchlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataWatchlist> {
        return NSFetchRequest<CoreDataWatchlist>(entityName: "CoreDataWatchlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbols: [String]?

}

extension CoreDataWatchlist : Identifiable {

}
