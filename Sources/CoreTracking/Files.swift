//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation

public class Files {
    let config: CoreTracking.Configuration

    init(config: CoreTracking.Configuration) {
        self.config = config
    }

    public func track(_ fileUrl: URL) {
        if config.outputs.contains(.logFiles) {
            let insightFileURL = config.rootURL.appendingPathComponent(fileUrl.lastPathComponent)

            let fileManager = FileManager.default
            try? FileManager.default.createDirectory(
                atPath: config.rootURL.path,
                withIntermediateDirectories: true
            )
            try? fileManager.removeItem(at: insightFileURL)
            try? fileManager.copyItem(at: fileUrl, to: insightFileURL)
        }
    }
}
