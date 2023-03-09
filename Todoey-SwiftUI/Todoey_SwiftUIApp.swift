//
//  Todoey_SwiftUIApp.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/6/23.
//

import SwiftUI

@main
struct Todoey_SwiftUIApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
