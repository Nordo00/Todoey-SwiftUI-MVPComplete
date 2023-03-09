//
//  DataController.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/9/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load \(error)")
            }
        }
    }
}
