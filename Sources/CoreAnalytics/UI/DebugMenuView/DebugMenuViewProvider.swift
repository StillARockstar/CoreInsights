//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import Combine
import CoreInsightsShared

class DebugMenuViewProvider: ObservableObject {
    private var numberOfFiles = 0
    private var currentLoadedFiles = 0
    private var loadedLogs: [LogMessage] = []
    private(set) var shownLevels: [MessageLevel] = [.default, .error, .warning, .info, .debug]
    private(set) var shownTags: [String]? = nil
    @Published var filteredLogs: [LogMessage] = []
    @Published var moreLogsAvailabe: Bool = false
    @Published var loadedFileNames: [String] = []

    init() {
    }

    func loadLogs() {
        numberOfFiles = CoreAnalytics.logs.numberOfLogBatches()
        guard numberOfFiles > 0 else {
            return
        }
        loadedLogs = CoreAnalytics.logs.loadLogBatch(at: 0)
        filteredLogs = loadedLogs
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
        currentLoadedFiles = 1
        moreLogsAvailabe = currentLoadedFiles < numberOfFiles
    }

    func loadMoreLogs() {
        guard currentLoadedFiles < numberOfFiles else {
            return
        }
        loadedLogs.append(contentsOf: CoreAnalytics.logs.loadLogBatch(at: currentLoadedFiles))
        filteredLogs = loadedLogs
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
        currentLoadedFiles += 1
        moreLogsAvailabe = currentLoadedFiles < numberOfFiles
    }

    func availableLogLevels() -> [MessageLevel] {
        return [.default, .error, .warning, .info, .debug]
    }

    func toggleLogFilter(_ level: MessageLevel) {
        if !shownLevels.contains(level) {
            shownLevels.append(level)
        } else {
            shownLevels.removeAll(where: { $0 == level })
        }
        filteredLogs = loadedLogs
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
    }

    func availableTags() -> [String] {
        loadedLogs.allTags
    }

    func toggleTagFilter(_ tag: String) {
        var shownTags = shownTags ?? []
        if !shownTags.contains(tag) {
            shownTags.append(tag)
        } else {
            shownTags.removeAll(where: { $0 == tag })
        }
        if shownTags.count == 0 {
            self.shownTags = nil
        } else {
            self.shownTags = shownTags
        }
        filteredLogs = loadedLogs
            .filterBy(levels: shownLevels)
            .filterBy(tags: self.shownTags)
    }

    func listFiles() {
        self.loadedFileNames = CoreAnalytics.files.availableFiles()
    }

    func content(of filename: String) -> String {
        return CoreAnalytics.files.loadFileContent(name: filename)
    }

    func resetApp() {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first else { return }
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: documentDirectory.path)
            for filePath in filePaths {
                try fileManager.removeItem(
                    atPath: documentDirectory.appendingPathComponent(filePath).path
                )
            }
            restartApp()
        } catch {
            print("Failed Resetting App")
        }
    }

    private func restartApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            exit(0)
        })
    }
}
