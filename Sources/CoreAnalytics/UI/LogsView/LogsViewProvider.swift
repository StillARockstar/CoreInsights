//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Combine
import CoreInsightsShared

class LogsViewProvider: ObservableObject {
    private var numberOfLogBatches = 0
    private var currentLoadedLogBatches = 0
    private var loadedLogMessages: [LogMessage] = []
    private(set) var shownLevels: [MessageLevel] = [.default, .error, .warning, .info, .debug]
    private(set) var shownTags: [String]? = nil
    @Published var filteredLogMessages: [LogMessage] = []
    @Published var moreLogBatchesAvailabe: Bool = false

    init() {
        loadLogs()
    }

    func loadLogs() {
        numberOfLogBatches = CoreAnalytics.logs.numberOfLogBatches()
        guard numberOfLogBatches > 0 else {
            return
        }
        loadedLogMessages = CoreAnalytics.logs.loadLogBatch(at: 0)
        filteredLogMessages = loadedLogMessages
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
        currentLoadedLogBatches = 1
        moreLogBatchesAvailabe = currentLoadedLogBatches < numberOfLogBatches
    }

    func loadMoreLogs() {
        guard currentLoadedLogBatches < numberOfLogBatches else {
            return
        }
        loadedLogMessages.append(contentsOf: CoreAnalytics.logs.loadLogBatch(at: currentLoadedLogBatches))
        filteredLogMessages = loadedLogMessages
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
        currentLoadedLogBatches += 1
        moreLogBatchesAvailabe = currentLoadedLogBatches < numberOfLogBatches
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
        filteredLogMessages = loadedLogMessages
            .filterBy(levels: shownLevels)
            .filterBy(tags: shownTags)
    }

    func availableTags() -> [String] {
        loadedLogMessages.allTags
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
        filteredLogMessages = loadedLogMessages
            .filterBy(levels: shownLevels)
            .filterBy(tags: self.shownTags)
    }
}
