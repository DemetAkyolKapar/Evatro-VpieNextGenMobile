//
//  VpieNextGenApp.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import SwiftUI
import CoreText

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

    
    init() {
        
        
        let largeTitleFont = resolveUIFont(
            candidates: [
                "PublicSansRoman-Bold",
                "PublicSansRoman-ExtraBold",
                "Public Sans"
            ],
            size: 34,
            weight: .bold
        )
        let titleFont = resolveUIFont(
            candidates: [
                "PublicSansRoman-SemiBold",
                "PublicSansRoman-Medium",
                "PublicSansRoman-Regular",
                "Public Sans"
            ],
            size: 16,
            weight: .semibold
        )
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : largeTitleFont]
        UINavigationBar.appearance().titleTextAttributes = [.font : titleFont]
        UIScrollView.appearance().showsVerticalScrollIndicator = false
        UIScrollView.appearance().showsHorizontalScrollIndicator = false
    }
    
    var body: some Scene {
        WindowGroup {
            
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.font, .custom("PublicSansRoman-Regular", size: 16))
                .provideDeviceBehavior()
            
        }
        
    }
}
