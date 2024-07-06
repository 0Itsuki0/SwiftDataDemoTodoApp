//
//  TodoManager.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/06.
//

import SwiftUI
import SwiftData


class TodoManager: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TodoModel.createDate, order: .forward, animation: .smooth) var todoList: [TodoModel]
    @Query var tags: [Tag]

//    @Published var todoList: [TodoModel] = []
    init(modelContext: ModelContext, todoList: [TodoModel], tags: [Tag]) {
//        self.modelContext = modelContext
//        self.todoList = todoList
//        self.tags = tags
    }
    
//    func setTodoList(_ todoList: [TodoModel]) {
//        self.todoList = todoList
//    }
//    
//    func addTodo(_ todo: TodoModel) {
//        
//    }
    
    
}
