//
//  TodoManager.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//

import SwiftUI
import SwiftData

class TodoManager: ObservableObject {
    @Published var todoList: [TodoModel] = []
    @Published var tags: [Tag] = []
    @Published var error: Error? = nil
    
    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil
    
    enum OtherErrors: Error {
        case nilContext
    }
    
    @MainActor
    init(inMemory: Bool) {

        do {
            // container init
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: TodoModel.self, configurations: configuration)
            modelContainer = container
            // get model context
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            
            // query data
            queryTodoList()
            queryTags()

        } catch(let error) {
            print(error)
            print(error.localizedDescription)
            self.error = error
        }
    
    }


    
    private func queryTodoList() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        
        var todoDescriptor = FetchDescriptor<TodoModel>(
//            predicate: #Predicate {$0.isDone == false}, // example for retrieve un-done only
            predicate: nil,
            sortBy: [
                .init(\.createDate)
            ]
        )
        todoDescriptor.fetchLimit = 10
        do {
            todoList = try modelContext.fetch(todoDescriptor)
            for todo in todoList {
                print(todo.tags)
            }
        } catch(let error) {
            self.error = error
        }
    }
    
    
    
    private func queryTags() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let tagDescriptor = FetchDescriptor<Tag>()
        do {
            tags = try modelContext.fetch(tagDescriptor)
        } catch(let error) {
            self.error = error
        }
    }
    
    
    func addTodo() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let date = Date()
        let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", icon: UIImage(systemName: "hare.fill")!, createDate: date, isDone: false, tags: tags)
        modelContext.insert(newTodo)
        save()
        queryTodoList()
    }
    
    func addTag() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        let color = TagColor.allCases.randomElement() ?? .blue
        let newTag = Tag(name: "Tag \(tags.count + 1)", color: color, todos: [])
        modelContext.insert(newTag)
        save()
        queryTags()
    }
    
    
    func updateTodo(_ todo: TodoModel) {
        todo.isDone = true
        save()
        queryTodoList()
    }
    
    func deleteTodo(_ todo: TodoModel) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        modelContext.delete(todo)
        save()
        queryTodoList()
    }
    
    func deleteTag(_ tag: Tag) {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        modelContext.delete(tag)
        save()
        queryTags()
        queryTodoList()
    }
   
    
    // saving any pending changes
    private func save() {
        guard let modelContext = modelContext else {
            self.error = OtherErrors.nilContext
            return
        }
        do {
            try modelContext.save()
        } catch (let error) {
            print(error)
            self.error = error
        }
    }
}
