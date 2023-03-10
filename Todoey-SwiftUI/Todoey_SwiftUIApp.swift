//
//  Todoey_SwiftUIApp.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/6/23.
//

import SwiftUI

@main
struct Todoey_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
