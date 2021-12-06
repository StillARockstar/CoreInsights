//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import CoreInsightsShared

public class Logs {
    let config: CoreTracking.Configuration

    init(config: CoreTracking.Configuration) {
        self.config = config
    }

    public func track(_ text: String, level: MessageLevel = .default, tags: [String] = []) {
        let trackingMessage = LogMessage(date: Date(), level: level, tags: tags, text: text)
        let messageString = trackingMessage.messageString
        if config.outputs.contains(.console) {
            logToConsole(messageString)
        }
        if config.outputs.contains(.logFiles) {
            logToFiles(messageString)
        }
    }

    private func logToConsole(_ message: String) {
        print(message)
    }

    private func logToFiles(_ message: String) {
        let fileName = fileName()
        var fileContent = readInsightFile(fileName) ?? ""
        fileContent.append("\(message)\n")
        saveInsightFile(fileName, content: fileContent)
    }
}

private extension Logs {
    func saveInsightFile(_ fileName: String, content: String) {
        let filePath = config.rootURL.appendingPathComponent(fileName)
        try? FileManager.default.createDirectory(
            atPath: config.rootURL.path,
            withIntermediateDirectories: true
        )
        try? content.write(to: filePath, atomically: false, encoding: .utf8)
    }

    func readInsightFile(_ fileName: String) -> String? {
        let filePath = config.rootURL.appendingPathComponent(fileName)
        return try? String(contentsOf: filePath)
    }

    func fileName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date()) + ".txt"
    }
}
