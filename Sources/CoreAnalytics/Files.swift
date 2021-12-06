//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation

public class InsightFiles {
    let config: CoreAnalytics.Configuration

    init(config: CoreAnalytics.Configuration) {
        self.config = config
    }

    public func availableFiles() -> [String] {
        let fileManager = FileManager.default
        guard let files = try? fileManager.contentsOfDirectory(atPath: config.rootURL.path)
        else {
            return []
        }
        return files
    }

    public func loadFileContent(name: String) -> String {
        let fileManager = FileManager.default
        let filePath = config.rootURL.appendingPathComponent(name).path
        guard let fileData = fileManager.contents(atPath: filePath) else {
            return ""
        }
        guard let fileString = String(data: fileData, encoding: .utf8) else {
            return ""
        }
        return fileString
    }
}
