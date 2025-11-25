//
//  DeviceBehaviorUpdater.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 12.11.2025.
//

import SwiftUI

enum DeviceBehavior: Equatable {
    case phone
    case pad
}

struct DeviceBehaviorUpdater: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var behavior: DeviceBehavior = .phone

    func body(content: Content) -> some View {
        let idiom = UIDevice.current.userInterfaceIdiom
        let newBehavior: DeviceBehavior

        if idiom == .pad {
            if horizontalSizeClass == .compact {
                newBehavior = .phone
            } else {
                newBehavior = .pad
            }
        } else {
            newBehavior = .phone
        }

        if behavior != newBehavior {
            DispatchQueue.main.async {
                behavior = newBehavior
            }
        }

        return content.environment(\.deviceBehavior, behavior)
    }
}

extension View {
    func provideDeviceBehavior() -> some View {
        modifier(DeviceBehaviorUpdater())
    }
}
