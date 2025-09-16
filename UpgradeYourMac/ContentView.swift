//
//  ContentView.swift
//  UpgradeYourMac
//
//  Created by Eric on 16/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var watcher = BuildWatcher()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
