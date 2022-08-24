//
//  ModelFetcher.swift
//  SabyAppleDataFetcher
//
//  Created by WOF on 2022/08/23.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

public final class ModelFetcher: Fetcher {
    typealias Value = Model

    func fetch() -> Model {
        let name = fetchName()
        let identifier = fetchIdentifier()

        return Model(
            name: name,
            identifier: identifier
        )
    }
}

public struct Model {
    let name: String
    let identifier: String?
}

extension ModelFetcher {
    private func fetchName() -> String {
        UIDevice.current.localizedModel
    }

    private func fetchIdentifier() -> String? {
        var system = utsname()
        uname(&system)
        
        return withUnsafeMutablePointer(to: &system.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String.init(validatingUTF8: $0)
            }
        }
    }
}

#endif
