//
//  Hash.swift
//  SabyAppleHash
//
//  Created by WOF on 2023/02/17.
//

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

public protocol Hash {
    static func hash(string: String) -> String
}

#endif
