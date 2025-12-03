//
//  DesignSystem.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 15.11.2025.
//

import Foundation
import SwiftUI

struct AppPadding {
    static let extraSmall: CGFloat = 6
    static let small: CGFloat = 10
    static let medium: CGFloat = 12
    static let large: CGFloat = 24
    static let xlarge: CGFloat = 48

}

struct AppCornerRadius {
    static let button: CGFloat = 8
    static let standard: CGFloat = 12
    static let card: CGFloat = 16
}

struct AppLineWidth {
    static let thin: CGFloat = 0.2
    static let standard: CGFloat = 1
    static let thick: CGFloat = 3
}

struct AppSpacing {
    static let large: CGFloat = 48
    static let standard: CGFloat = 24
    static let thin: CGFloat = 12
    static let tight: CGFloat = 8
}

struct FontSize {
    @ScaledMetric(relativeTo: .title)  static var thick: CGFloat = 9
    @ScaledMetric(relativeTo: .title)  static var thin: CGFloat = 12
    @ScaledMetric(relativeTo: .title)  static var standard: CGFloat = 16
    @ScaledMetric(relativeTo: .title)  static var large: CGFloat = 18
    @ScaledMetric(relativeTo: .title)  static var xlarge: CGFloat = 24


}
extension Font {
    static func scalable(size: CGFloat) -> Font {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return .system(size: scaledSize)
    }
}
