//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import CoreInsightsShared

public extension Array where Element == TrackingMessage {
    var allTags: [String] {
        let allTags = self.map({ $0.tags }).flatMap({ $0 })
        return allTags.removeDuplicates()
    }
}

public extension Array where Element == TrackingMessage {
    func filterBy(level logLevel: MessageLevel) -> [Element] {
        return self.filterBy(levels: [logLevel])
    }

    func filterBy(levels logLevels: [MessageLevel]) -> [Element] {
        return self.filter({ logLevels.contains($0.level) })
    }

    func filterBy(tag tagString: String) -> [Element] {
        return self.filter({ $0.tags.joined(separator: ",").contains(tagString) })
    }

    func filterBy(tags tagStrings: [String]?) -> [Element] {
        guard let tagStrings = tagStrings else {
            return self
        }
        var results = self
        for tagString in tagStrings {
            results = results.filterBy(tag: tagString)
        }
        return results
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
