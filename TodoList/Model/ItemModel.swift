//
//  ItemModel.swift
//  TodoList
//
//  Created by Shaw Young on 2021/7/17.
//

import Foundation

struct ItemModel: Identifiable, Codable {// Codable for encode and decode
    let title: String
    let isCompleted: Bool
    var id: String = UUID().uuidString
    
    init(title: String, isCompleted: Bool, id:String = UUID().uuidString) {
        self.isCompleted = isCompleted
        self.title = title
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(title: title, isCompleted: !isCompleted, id: id)
    }
}
