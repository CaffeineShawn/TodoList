//
//  ListViewModel.swift
//  TodoList
//
//  Created by Shaw Young on 2021/7/17.
//

import Foundation

class ListViewModel: ObservableObject{
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
//        let newItems = [
//            ItemModel(title: "无限连任", isCompleted: false),
//            ItemModel(title: "修改宪法", isCompleted: true)
//        ]
//        items.append(contentsOf: newItems)
        // then we start to decode items
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        
        else {return}
        
        self.items = savedItems
        
    }
    
    func deleteItem(indexSet:IndexSet) -> () {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) -> () {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) -> () {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) -> () {
        // duplicate
//        if let index = items.firstIndex { (existingItem) -> Bool in
//            return existingItem.id  == item.id
//        } {
//            // run this code
//        }
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {// find the item's index and update
            items[index] = item.updateCompletion()
        }
        
    }
    
    // in class we use UserDefault to store data
    // all kinds of item's operation should trigger this function
    func saveItems() -> () {
        // convert items into json
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
