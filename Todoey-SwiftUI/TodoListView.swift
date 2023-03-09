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
// 7. Core Data


import SwiftUI


//MARK: - View
struct TodoListView: View {

    @State private var showingAlert = false
    @State private var textField = ""
    

    @FetchRequest(sortDescriptors: []) var itemArray:FetchedResults<Item>
    
    @Environment(\.managedObjectContext) var context

    var body: some View {
        
        //let _ = print(NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last! as String)
        
        NavigationView {
            VStack {
                List {
                    ForEach(itemArray) { item in
                        HStack {
                            Button {
                                // action to toggle checked
                                print(item.title!)
                                // toggle the done field
                                item.done.toggle()
                                try? context.save()
                            } label: {
                                Text(item.title ?? "Unknown Item")
                            }
                            
                            Spacer()
                            
                            // if then to change which image we use
                            if item.done  {
                                Image(systemName: "checkmark.square.fill")
                            } else {
                                Image(systemName: "squareshape")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todoey")
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
        
        try? context.save()
        
        textField = ""
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
