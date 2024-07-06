//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/06.
//

import SwiftUI

@main
struct SwiftDataDemoApp: App {

    var body: some Scene {
        WindowGroup {
            ViewDemo()
        }
        .modelContainer(for: [TodoModel.self, Tag.self])
    }
}
