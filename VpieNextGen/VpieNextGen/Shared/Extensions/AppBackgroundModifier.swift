//
//  VpieNextGenApp.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import SwiftUI
import CoreText
import Shared.Extensions.AppBackgroundModifier // Ensure the extension is available

@main
struct VpieNextGenApp: App {
    let persistenceController = PersistenceController.shared

    // Helper to safely resolve a UIFont by trying multiple candidate names and falling back to system
    private func resolveUIFont(candidates: [String], size: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        for name in candidates {
            if let font = UIFont(name: name, size: size) {
                return font
            }
        }
        if let weight = weight {
            return .systemFont(ofSize: size, weight: weight)
        } else {
            return .systemFont(ofSize: size)
        }
    }

    private func registerPublicSansIfNeeded() {
        // Try to locate font resource directly from bundle
        guard let fontURL = Bundle.main.url(forResource: "PublicSans-VariableFont_wght", withExtension: "ttf") else {
            print("[Fonts] Font file not found in bundle. Check target membership & Info.plist UIAppFonts entry.")
            return
        }
        var errorRef: Unmanaged<CFError>? = nil
        let success = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &errorRef)
        if success {
            print("[Fonts] Manual registration succeeded for PublicSans variable font.")
        } else if let error = errorRef?.takeRetainedValue() {
            print("[Fonts] Manual registration failed: \(error)")
        } else {
            print("[Fonts] Manual registration failed with unknown error.")
        }
    }

    init() {
        

        // Use the discovered PostScript names (from the console log) for consistent styling
        let largeTitleFont = resolveUIFont(
            candidates: [
                "PublicSansRoman-Bold",         // large title
                "PublicSansRoman-ExtraBold",
                "Public Sans"                   // family fallback
            ],
            size: 34,
            weight: .bold
        )
        let titleFont = resolveUIFont(
            candidates: [
                "PublicSansRoman-SemiBold",     // nav bar title
                "PublicSansRoman-Medium",
                "PublicSansRoman-Regular",
                "Public Sans"
            ],
            size: 16,
            weight: .semibold
        )

        UINavigationBar.appearance().largeTitleTextAttributes = [.font : largeTitleFont]
        UINavigationBar.appearance().titleTextAttributes = [.font : titleFont]
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.font, .custom("PublicSansRoman-Regular", size: 16))
                .provideDeviceBehavior()
                .appBackground() // Global background for all screens
        }
    }
}
