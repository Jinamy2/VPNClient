//
//  LateInit.swift
//  ikev2_dart
//
//  Created by Кирилл Перминов on 21.04.2024.
//

import Foundation

@propertyWrapper
struct Lateinit<T> {
  private var _value: T?
  
  var wrappedValue: T {
    get {
      guard let value = _value else {
        fatalError("Property being accessed without initialization")
      }
      return value
    }
    set {
      guard _value == nil else {
        fatalError("Property already initialized")
      }
      _value = newValue
    }
  }
}
