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

                }
                Spacer()
                    .frame(height: 10)
                
                
                ForEach(todoList) { todo in
                    HStack {
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
        .padding(.trailing, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.2))
        .onAppear {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        }

    }
    
    private func addTodo() {
        let date = Date()
        let newTodo = TodoModel(title: "\(date)", content: "Todo Created on \(Date())", icon: UIImage(systemName: "hare.fill")!, createDate: date, isDone: false, tags: tags)
        modelContext.insert(newTodo)
    }
    
    private func addTag() {
        let color = TagColor.allCases.randomElement() ?? .blue
        let newTodo = Tag(name: "Tag \(tags.count + 1)", color: color)
        modelContext.insert(newTodo)
    }
    
    
    private func updateTodo(_ todo: TodoModel) {
        todo.isDone = true
    }
    
    private func deleteTodo(_ todo: TodoModel) {
        modelContext.delete(todo)
    }
}


private struct TodoCard: View {
    var todo: TodoModel
    
    var body: some View {
        HStack(spacing: 20) {
            todo.icon
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            VStack(spacing: 10) {
                HStack {
                    ForEach(todo.tags) { tag in
                        Text(tag.name)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(RoundedRectangle(cornerRadius: 4).fill(tag.color.color))

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Text(todo.title)
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)


                    Text(todo.content)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }


            }
            
            Image(systemName: todo.isDone ? "checkmark.circle" : "questionmark.circle")
                .font(.system(size: 24))
                .foregroundStyle(todo.isDone ? Color.green : Color.red)


        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.2)).stroke(.black, style: .init(lineWidth: 2.0)))
        .padding(.horizontal, 20)
       
    }
    

}



#Preview {
    return ViewDemo()
        .modelContainer(for: TodoModel.self, inMemory: true)

}
