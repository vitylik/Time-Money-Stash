//
//  toDo.swift
//  toDoList1
//
//  Created by macbook on 06.12.2023.
//

import Foundation

class ToDo: Codable {
    
    var  title: String
    var completed: Bool
    var id: UUID
    
    init(title: String, completed: Bool, id: UUID = UUID()) {
        self.title = title
        self.completed = completed
        self.id = id
    }
}
