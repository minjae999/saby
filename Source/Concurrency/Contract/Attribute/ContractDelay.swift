//
//  ContractDelay.swift
//  SabyConcurrency
//
//  Created by WOF on 2022/07/18.
//

import Foundation

extension Contract {
    public func delay<AnyValue>(
        on queue: DispatchQueue? = nil,
        until promise: Promise<AnyValue, Never>
    ) -> Contract<Value, Failure> {
        let queue = queue ?? self.queue
        
        let contract = Contract<Value, Failure>(queue: self.queue)
        
        subscribe(
            queue: queue,
            onResolved: { value in
                promise.subscribe(
                    queue: queue,
                    onResolved: { _ in contract.resolve(value) },
                    onRejected: { _ in },
                    onCanceled: { contract.cancel() }
                )
            },
            onRejected: { error in contract.reject(error) },
            onCanceled: { contract.cancel() }
        )
        
        return contract
    }
}
