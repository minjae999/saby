//
//  Atomic.swift
//  SabyConcurrency
//
//  Created by WOF on 2020/04/03.
//

import Foundation

public final class Atomic<Value> {
    @usableFromInline var lock: UnsafeMutablePointer<pthread_mutex_t>
    @usableFromInline var value: Value

    public init(_ input: Value) {
        self.lock = UnsafeMutablePointer.allocate(capacity: 1)
        lock.initialize(to: pthread_mutex_t())
        self.value = input
        
        pthread_mutex_init(lock, nil)
    }
    
    deinit {
        pthread_mutex_destroy(lock)
        
        lock.deallocate()
    }

    @inline(__always) @inlinable
    public var capture: Value {
        pthread_mutex_lock(lock)
        defer { pthread_mutex_unlock(lock) }
        
        return value
    }
    
    @inline(__always) @inlinable
    public func use(_ block: (Value) -> Void) {
        pthread_mutex_lock(lock)
        defer { pthread_mutex_unlock(lock) }
        
        block(value)
    }
    
    @inline(__always) @inlinable
    public func mutate(_ block: (Value) -> Value) {
        pthread_mutex_lock(lock)
        defer { pthread_mutex_unlock(lock) }
        
        value = block(value)
    }
}
