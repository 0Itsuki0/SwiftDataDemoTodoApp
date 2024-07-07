//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing: 50) {
            NavigationLink {
                ManagerDemo()
            } label: {
                Text("SwiftData + \nSwiftUI View")
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
            }
            
            
            NavigationLink {
                ViewDemo()
                    .modelContainer(for: [TodoModel.self, Tag.self])
            } label: {
                Text("SwiftData + \nManager Class")
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
            }

        }
        .foregroundStyle(.white)
        .font(.system(size: 24))
        .fixedSize(horizontal: true, vertical: false)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    

    }
}

#Preview {
    return NavigationStack {
        ContentView()

    }
}
