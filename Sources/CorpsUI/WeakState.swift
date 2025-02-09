//
//  WeakState.swift
//  Created by Shawn Throop on 09.02.25.
//

import SwiftUI
import Observation

/// Similar to @State but for weak references to classes of type of Value.
///
@available(iOS 17.0, *)
@propertyWrapper public struct WeakState<Value: AnyObject> : DynamicProperty {
    
    @State private var store = WeakObservable<Value>()
    
    public init(wrappedValue: Value? = nil) {
        self._store = .init(wrappedValue: .init(wrappedValue))
    }
    
    
    public weak var wrappedValue: Value? {
        get { store.wrappedValue }
        nonmutating set { store.wrappedValue = newValue }
    }
    
    public var projectedValue: WeakObservable<Value> {
        store
    }
}
