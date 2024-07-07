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
            NavigationStack {
                ContentView()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.gray.opacity(0.2))
//            ManagerDemo()
//                .onAppear {
//                    print(URL.applicationSupportDirectory.path(percentEncoded: false))
//                }

        }
//        .modelContainer(for: [TodoModel.self, Tag.self])
    }
}
