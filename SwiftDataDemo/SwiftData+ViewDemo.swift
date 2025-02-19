//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/06.
//

import SwiftUI
import SwiftData


struct ViewDemo: View {
    static var descriptor: FetchDescriptor<TodoModel> {
        var descriptor = FetchDescriptor<TodoModel>(
//            predicate: #Predicate {$0.isDone == false}, // example for retrieve un-done only
            predicate: nil,
            sortBy: [
                .init(\.createDate)
            ]
        )
        descriptor.fetchLimit = 10
        return descriptor
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query(Self.descriptor) var todoList: [TodoModel]
//    @Query(sort: \TodoModel.createDate, order: .forward, animation: .smooth) var todoList: [TodoModel]
    
    @Query var tags: [Tag]

    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Button(action: {
                        addTodo()
                    }, label: {
                        Text("Add Todo")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))

                    Button(action: {
                        addTag()
                    }, label: {
                        Text("Add Tag")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
                    
                    Button(action: {
                        guard let lastTag = tags.last else {return}
                        deleteTag(lastTag)
                    }, label: {
                        Text("Delete Tag")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
                }
                
                if tags.count > 0 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(tags) { tag in
                                Text(tag.name)
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(RoundedRectangle(cornerRadius: 4).fill(tag.color.color))

                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)

                }
                
                
                ForEach(todoList) { todo in
                    HStack(spacing: 20) {
                        TodoCard(todo: todo)
                        
                        VStack(spacing: 20) {
                            if !todo.isDone {
                                Button(action: {
                                    updateTodo(todo)
                                }, label: {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.green)

                                })
                            }
                            Button(action: {
                                deleteTodo(todo)
                            }, label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 24))
                                    .foregroundStyle(Color.red)
                            })


                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 50)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.2))

    }
    
    private func addTodo() {
        let date = Date()
        let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", icon: UIImage(systemName: "hare.fill")!, createDate: date, isDone: false, tags: tags)
        modelContext.insert(newTodo)
        save()
    }
    
    private func addTag() {
        let color = TagColor.allCases.randomElement() ?? .blue
        let newTag = Tag(name: "Tag \(tags.count + 1)", color: color, todos: [])
        modelContext.insert(newTag)
        save()
    }
    
    private func deleteTag(_ tag: Tag) {
        modelContext.delete(tag)
        save()
    }
    
    private func updateTodo(_ todo: TodoModel) {
        todo.isDone = true
        save()
    }
    
    private func deleteTodo(_ todo: TodoModel) {
        modelContext.delete(todo)
        save()
    }
    
    private func save() {
        try? modelContext.save()
    }
}



#Preview {
    return ViewDemo()
        .modelContainer(for: TodoModel.self, inMemory: true)

}
