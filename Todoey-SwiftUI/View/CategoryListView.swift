//
//  CategoryListView.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/16/23.
//

import SwiftUI

struct CategoryListView: View {
    @State private var showingAlert = false
    @State private var textField = ""
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]) var categories:FetchedResults<Category>



    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(categories) { cat in
                        HStack {
                            NavigationLink(destination: TodoListView(selectedCategory: .constant(cat)), label: {
                                Text(cat.name ?? "Unknown Category")
                            })
                        }
                    }
                }
            }
            .navigationTitle("Todoey")
            .toolbar {
                Button("Add Category") {
                    // action of the button
                    showingAlert.toggle()
                }
                .alert("Add New Todoey Category", isPresented: $showingAlert) {
                    TextField("Create new category", text: $textField)
                    Button("OK", action: saveCategories)
                }
            }
        }
    }
    
    //MARK: - Model Manipulation Methods
    func saveCategories() {
        print("You entered \(textField)")
        let newCat = Category(context: context)
        newCat.name = textField
        
        try? context.save()
        
        textField = ""
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView().environment(\.managedObjectContext, PersistenceController.previewCategories.container.viewContext)
    }
}
