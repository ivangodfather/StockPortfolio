//
//  StockCoreData+CoreDataProperties.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 01/10/2020.
//
//

import Foundation
import CoreData

extension StockCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockCoreData> {
        return NSFetchRequest<StockCoreData>(entityName: "StockCoreData")
    }

    @NSManaged public var symbol: String?

}

extension StockCoreData: Identifiable {
}
