//
//  RaceTest.swift
//  SabyConcurrencyTest
//
//  Created by WOF on 2020/04/09.
//

import XCTest
@testable import SabyConcurrency

final class PromiseRaceTest: XCTestCase {
    func test__race_2() {
        let promise =
        Promise.race([
            Promise { resolve, reject in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    resolve(10)
                }
            },
            Promise { resolve, reject in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
                    resolve(20)
                }
            }
        ])
        
        PromiseTest.expect(promise: promise, state: .resolved(10), timeout: .seconds(1))
    }
    
    func test__race_2_reject_1() {
        let promise =
        Promise.race([
            Promise<Int> { resolve, reject in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    reject(PromiseTest.Error.one)
                }
            },
            Promise { resolve, reject in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
                    resolve(20)
                }
            }
        ])
        
        PromiseTest.expect(promise: promise, state: .rejected(PromiseTest.Error.one), timeout: .seconds(1))
    }
}
