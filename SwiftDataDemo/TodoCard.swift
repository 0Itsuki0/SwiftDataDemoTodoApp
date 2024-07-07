//
//  TodoCard.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//

import SwiftUI

struct TodoCard: View {
    @ObservableModel var todo: TodoModel
    
    var body: some View {
        HStack(spacing: 20) {

            todo.icon
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            
            VStack(spacing: 10) {
                if todo.tags.count > 0 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(todo.tags) { tag in
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
        .onAppear {
            print(todo.tags)
        }
       
    }
}
