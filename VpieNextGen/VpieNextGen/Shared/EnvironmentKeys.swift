//
//  EnvironmentKeys.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 11.11.2025.
//


import SwiftUI

private struct DeviceBehaviorKey: EnvironmentKey {
    static let defaultValue: DeviceBehavior = .phone
}

extension EnvironmentValues {
    var deviceBehavior: DeviceBehavior {
        get { self[DeviceBehaviorKey.self] }
        set { self[DeviceBehaviorKey.self] = newValue }
    }
}

