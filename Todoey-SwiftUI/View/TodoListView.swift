//
//  TodoListView.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/6/23.
//
// 1. Creating the list of to do items - DONE
// 2. Navigation bar - title - DONE
// 3. Toggle a checkbox (we're not going to do this) - DONE
// 4. Create an Add popup to add new items - DONE
// 5a. Using user defaults - DONE
// 5b. Change the variables to match the ones in the course - DONE
// 5c. @AppStorage - DONE
// 6. Custom Data Model - DONE
// 6b. NSEncoder - DONE
// 7. Core Data - DONE
// 8. Search bar to Todoey - DONE
// 9. Category - DONE
// 10. Swipeable - DONE


import SwiftUI


//MARK: - View
struct TodoListView: View {
    @Binding var selectedCategory: Category

    @State private var showingAlert = false
    @State private var textField = ""
    
    @State private var searchText = ""
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.dateAdded, ascending: true)]) var itemArray:FetchedResults<Item>



    var body: some View {
        
        //let _ = print(NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last! as String)
        
        NavigationStack {
            VStack {
                FilteredTodoList(filter: searchText, selectedCategory: selectedCategory)
            }
            .navigationTitle("Items")
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                Button("Add Item") {
                    // action of the button
                    showingAlert.toggle()
                }
                .alert("Add New Todoey Item", isPresented: $showingAlert) {
                    TextField("Create new item", text: $textField)
                    Button("OK", action: saveItems)
                }
            }
        }
    }
    
    //MARK: - Model Manipulation Methods
    func saveItems() {
        print("You entered \(textField)")
        let newItem = Item(context: context)
        newItem.title = textField
        newItem.done = false
        newItem.dateAdded = Date()
        
        print("The selected category is: \(selectedCategory.name!)")
        newItem.parentCategory = selectedCategory
        
        try? context.save()
        
        textField = ""
    }
}

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
