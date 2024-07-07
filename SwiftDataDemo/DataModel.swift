//
//  TodoModel.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/06.
//

import SwiftUI
import SwiftData

@Model
class TodoModel {
    
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var content: String
    var iconData: Data
    
    var icon: Image {
        if let uiImage = UIImage(data: iconData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "questionmark.diamond.fill")
        }
    }

    var createDate: Date
    var isDone: Bool
    
    var tags: [Tag]
    
    init(title: String, content: String, icon: UIImage, createDate: Date, isDone: Bool, tags: [Tag]) {
        self.title = title
        self.content = content
        self.iconData = icon.pngData() ?? Data()
        self.createDate = createDate
        self.isDone = isDone
        self.tags = tags
    }
}


@Model
class Tag {
    var name: String
    var color: TagColor
    @Relationship(inverse: \TodoModel.tags) var todos: [TodoModel]

    
    init(name: String, color: TagColor, todos: [TodoModel]) {
        self.name = name
        self.color = color
        self.todos = todos
    }
}


enum TagColor: Codable, CaseIterable {
    case red
    case blue
    case mint
    case orange
    
    var color: Color {
        switch self {
        case .red:
                .red
        case .blue:
                .blue
        case .mint:
                .mint
        case .orange:
                .orange
        }
    }
}
