//
//  UpgradeYourMacApp.swift
//  UpgradeYourMac
//
//  Created by Eric on 16/09/2025.
//

import SwiftData
import SwiftUI

@main
struct UpgradeYourMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BuildLog.self)
    }
}
