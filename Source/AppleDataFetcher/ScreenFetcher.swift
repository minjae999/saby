//
//  ScreenFetcher.swift
//  SabyAppleDataFetcher
//
//  Created by WOF on 2022/08/23.
//

#if os(iOS) || os(tvOS)

import Foundation
import UIKit

import SabyConcurrency

public final class ScreenFetcher: Fetcher {
    typealias Value = Promise<Screen>

    func fetch() -> Promise<Screen> {
        return Promise.all(
            Promise.resolved(fetchSize()),
            Promise.resolved(fetchScale()),
            fetchOrientation()
        )
        .then { size, scale, orientation in
            Screen(
                width: size.width,
                height: size.height,
                scale: scale,
                orientation: orientation.isLandscape ? "landscape": "portrait"
            )
        }
    }
}

public struct Screen {
    let width: Double
    let height: Double
    let scale: Double
    let orientation: String
}

extension ScreenFetcher {
    private func fetchSize() -> CGSize {
        return UIScreen.main.bounds.size
    }

    private func fetchScale() -> CGFloat {
        UIScreen.main.scale
    }
    
    private func fetchOrientation() -> Promise<UIInterfaceOrientation> {
        Promise(on: DispatchQueue.main) { () -> UIInterfaceOrientation in
            if #available(iOS 13.0, macCatalyst 13.0, tvOS 13.0, *) {
                return UIApplication.shared.connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .first { $0 is UIWindowScene }
                    .flatMap { $0 as? UIWindowScene }?
                    .interfaceOrientation ?? .portrait
            }
            else {
                return UIApplication.shared.statusBarOrientation
            }
        }
    }
}

#endif
