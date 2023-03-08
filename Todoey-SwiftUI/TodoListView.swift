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
// 6. Custom Data Model
// 6b. NSEncoder
// 7. Core Data


import SwiftUI

//MARK: - Model
struct Item: Identifiable, Codable {
    var id = UUID()
    var title: String = ""
    var done: Bool = false
}

//MARK: - View
struct TodoListView: View {

    @State private var showingAlert = false
    @State private var textField = ""
    
    //let itemArray = ["The Fellowship", "The Two Towers", "Return of the King"]
    //@State private var itemArray = ["The Fellowship", "The Two Towers", "Return of the King"]
    //@State private var itemArray: [String] = (UserDefaults.standard.stringArray(forKey: "TodoListArray") ?? ["Todo List Item 1"])
    //@AppStorage("todoArray") var itemArray = ["The Fellowship", "The Two Towers", "Return of the King"]
    @State private var itemArray: [Item] = [
        Item(title: "The Fellowship", done: false),
        Item(title: "The Two Towers", done: false),
        Item(title: "Return of the King", done: false)
    ]

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var body: some View {
        
        //let _ = print(NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last! as String)
        
        NavigationView {
            VStack {
                List {
                    ForEach($itemArray) { $item in
                        HStack {
                            Button {
                                // action to toggle checked
                                print(item.title)
                                // toggle the done field
                                item.done.toggle()
                            } label: {
                                Text(item.title)
                            }
                            
                            Spacer()
                            
                            // if then to change which image we use
                            if item.done  {
                                Image(systemName: "checkmark.square.fill")
                            } else {
                                Image(systemName: "squareshape")
                            }
                        }
                        .task {
                            await loadItems()
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
        var newItem = Item()
        newItem.title = textField
        newItem.done = false
        
        itemArray.append(newItem)

        // Encode
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding \(error)")
        }
        
        
        textField = ""
    }
    
    func loadItems() async {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error")
            }
                
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
