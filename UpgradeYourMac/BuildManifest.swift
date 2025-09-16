//
//  BuildManifest.swift
//  UpgradeYourMac
//
//  Created by Eric on 16/09/2025.
//

import Foundation
import SwiftData

struct BuildManifest: Codable {
    var logs: [String: BuildLog]
}

@Model
class BuildLog: Codable, Comparable {
    enum CodingKeys: String, CodingKey {
        case title, timeStartedRecording, timeStoppedRecording
    }

    var title: String
    var timeStartedRecording: Double
    var timeStoppedRecording: Double

    var timeTaken: Double {
        timeStoppedRecording - timeStartedRecording
    }

    var dateStarted: Date {
        Date(timeIntervalSinceReferenceDate: timeStartedRecording)
    }

    init(title: String, timeStartedRecording: Double, timeStoppedRecording: Double) {
        self.title = title
        self.timeStartedRecording = timeStartedRecording
        self.timeStoppedRecording = timeStoppedRecording
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        timeStartedRecording = try container.decode(Double.self, forKey: .timeStartedRecording)
        timeStoppedRecording = try container.decode(Double.self, forKey: .timeStoppedRecording)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(timeStartedRecording, forKey: .timeStartedRecording)
        try container.encode(timeStoppedRecording, forKey: .timeStoppedRecording)
    }

    static func <(lhs: BuildLog, rhs: BuildLog) -> Bool {
        lhs.timeStartedRecording < rhs.timeStartedRecording
    }
}
