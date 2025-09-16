//
//  ContentView.swift
//  UpgradeYourMac
//
//  Created by Eric on 16/09/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var watcher = BuildWatcher()
    @Query(sort: \BuildLog.timeStartedRecording, order: .reverse) var builds: [BuildLog]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        List(builds) { build in
            if build.title.starts(with: "Build") {
                Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "hammer.circle")
            } else {
                Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "paintbrush")
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            watcher.modelContext = modelContext
        }
    }
}

#Preview {
    ContentView()
}
