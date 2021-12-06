//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import CoreInsightsShared

public class Logs {
    let config: CoreAnalytics.Configuration

    init(config: CoreAnalytics.Configuration) {
        self.config = config
    }

    public func numberOfLogBatches() -> Int {
        let fileManager = FileManager.default
        guard let files = try? fileManager.contentsOfDirectory(atPath: config.rootURL.path)
        else {
            return 0
        }
        return files.count
    }

    public func loadLogBatch(at index: Int) -> [TrackingMessage] {
        let fileManager = FileManager.default
        guard let files = try? fileManager.contentsOfDirectory(atPath: config.rootURL.path) else {
            return []
        }
        let reversedFiles = Array(files.sorted().reversed())
        guard let linesData = fileManager.contents(
            atPath: config.rootURL.appendingPathComponent(reversedFiles[index]).path
        ) else {
            return []
        }
        guard let linesString = String(data: linesData, encoding: .utf8) else {
            return []
        }
        let messages = Array(linesString.split(separator: "\n").reversed())
            .map({ TrackingMessage(message: String($0)) })
        return Array(messages)
    }
}
