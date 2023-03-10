//
//  FilteredTodoList.swift
//  Todoey-SwiftUI
//
//  Created by Nordo on 3/10/23.
//

import SwiftUI


struct FilteredTodoList: View {
    @FetchRequest var fetchRequest: FetchedResults<Item>
    @Environment(\.managedObjectContext) var context
    
    init(filter: String) {
        
        if !filter.isEmpty {
            _fetchRequest = FetchRequest<Item>(sortDescriptors: [NSSortDescriptor(keyPath: \Item.dateAdded, ascending: true)], predicate: NSPredicate(format: "title CONTAINS[cd] %@", filter))
        } else {
            _fetchRequest = FetchRequest<Item>(sortDescriptors: [NSSortDescriptor(keyPath: \Item.dateAdded, ascending: true)])
        }
    }
    
    var body: some View {
        List {
            ForEach(fetchRequest) { item in
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
}

//struct FilteredTodoList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredTodoList()
//    }
//}
