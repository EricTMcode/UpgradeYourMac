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

    @State private var currentDevice = Device.mbpM1Pro
    @State private var targetDevice = Device.mbpM3Max
    @State private var hourlyRate = 20

    var savedSeconds: Double {
        let totalCurrentTime = builds.map(\.timeTaken).reduce(0, +)
        let totalUpgradeTime = totalCurrentTime / targetDevice.performanceFactor * currentDevice.performanceFactor
        return totalCurrentTime - totalUpgradeTime
    }

    var savedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter.string(from: savedSeconds) ?? ""
    }

    var savedMoney: String {
        let secondsRate = Double(hourlyRate) / 60 / 60
        let savings = savedSeconds * secondsRate
        return savings.formatted(.currency(code: "USD"))
    }

    var body: some View {
        VStack {
            Form {
                Picker("Your device", selection: $currentDevice) {
                    ForEach(Device.devices) { device in
                        Text(device.name)
                            .tag(device)
                    }
                }

                Picker("Target device", selection: $targetDevice) {
                    ForEach(Device.devices) { device in
                        Text(device.name)
                            .tag(device)
                    }
                }

                TextField("Hourly rate", value: $hourlyRate, format: .number)
            }

            List(builds) { build in
                if build.title.starts(with: "Build") {
                    Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "hammer.circle")
                } else {
                    Label("\(build.title) on \(build.dateStarted) took \(build.timeTaken) seconds", systemImage: "paintbrush")
                        .foregroundStyle(.secondary)
                }
            }

            Text("You would have saved \(savedTime) and \(savedMoney) by upgrading to a \(targetDevice).")
                .multilineTextAlignment(.center)
                .font(.title)
        }
        .padding()
        .onAppear {
            watcher.modelContext = modelContext
        }
    }
}

#Preview {
    ContentView()
}
