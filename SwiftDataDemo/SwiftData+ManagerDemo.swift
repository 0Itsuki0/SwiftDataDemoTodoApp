//
//  SwiftData+ManagerDemo.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//


import SwiftUI
import SwiftData


struct ManagerDemo: View {

    @StateObject var todoManager = TodoManager(inMemory: false)
    let tags = [Tag(name: "test", color: .mint, todos: [])]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Button(action: {
                        todoManager.addTodo()
                    }, label: {
                        Text("Add Todo")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))

                    Button(action: {
                        todoManager.addTag()
                    }, label: {
                        Text("Add Tag")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
                    
                    Button(action: {
                        guard let lastTag = todoManager.tags.last else {return}
                        todoManager.deleteTag(lastTag)
                    }, label: {
                        Text("Delete Tag")
                    })
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
                }
                
                if todoManager.tags.count > 0 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(todoManager.tags) { tag in
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
                
                
                ForEach(todoManager.todoList) { todo in
                    HStack(spacing: 20) {
                        TodoCard(todo: todo)

                        VStack(spacing: 20) {
                            if !todo.isDone {
                                Button(action: {
                                    todoManager.updateTodo(todo)
                                }, label: {
                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.green)

                                })
                            }
                            Button(action: {
                                todoManager.deleteTodo(todo)
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
        .overlay(content: {
            if let error = todoManager.error {
                Text("Error: \(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.gray.opacity(0.2)).stroke(.red, style: .init(lineWidth: 2.0)))
                    .padding(.horizontal, 20)
            }
        })
    }
}



#Preview {
    return ManagerDemo()

}
