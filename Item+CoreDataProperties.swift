//
//  Item+CoreDataProperties.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/10/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var done: Bool
    @NSManaged public var title: String?
    @NSManaged public var parentCategory: Category?
    
    var wrappedTitle: String {
        title ?? "Unknown Item"
    }
}

extension Item : Identifiable {

}
