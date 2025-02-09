//
//  WeakObservable.swift
//  Created by Shawn Throop on 16.12.24.
//

import Foundation
import Observation

/// An observable class holding a weak reference to an object of type Value.
///
/// Access to wrappedValue is protected by a recursive lock.
///
@available(iOS 17.0, *)
@Observable public final class WeakObservable<Value: AnyObject> : @unchecked Sendable {
    
    @ObservationIgnored private weak var value: Value?
    private let lock = NSRecursiveLock()
    
    public init(_ wrappedValue: Value? = nil) {
        self.value = wrappedValue
    }
    
    
    public weak var wrappedValue: Value? {
        get {
            lock.lock()
            defer { lock.unlock() }
            access(keyPath: \.wrappedValue)
            return value
        }
        set {
            withLockedMutation(keyPath: \.wrappedValue) {
                value = newValue
            }
        }
    }
    
    @discardableResult func withLockedMutation<Member, MutationResult>(keyPath: KeyPath<WeakObservable, Member>, _ mutation: () throws -> MutationResult) rethrows -> MutationResult {
        lock.lock()
        defer { lock.lock() }
        return try withMutation(keyPath: keyPath) {
            try mutation()
        }
    }
}
