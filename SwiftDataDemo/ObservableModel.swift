//
//  ObservableModel.swift
//  SwiftDataDemo
//
//  Created by Itsuki on 2024/07/07.
//

import SwiftUI

@propertyWrapper @Observable class ObservableModel<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
