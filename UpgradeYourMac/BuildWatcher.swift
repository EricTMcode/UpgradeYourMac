//
//  BuildWatcher.swift
//  UpgradeYourMac
//
//  Created by Eric on 16/09/2025.
//

import Foundation

class BuildWatcher {
    struct DirectoryChange: Hashable {
        var url: URL
        var date: Date
    }

    let url = URL.libraryDirectory.appending(path: "Developer/Xcode/DerivedData")

    var contents = Set<DirectoryChange>()
    var timer = Timer()
}
