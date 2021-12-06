//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation

public enum MessageLevel: Int {
    case `default` = 1000
    case error = 2000
    case warning = 3000
    case info = 4000
    case debug = 5000
}

public struct TrackingMessage {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    public let date: Date
    public let level: MessageLevel
    public let tags: [String]
    public let text: String

    public init(message: String) {
        let metaContentStrings = message.components(separatedBy: ": ")
        let metaStrings = metaContentStrings[0].split(separator: " ")

        let dateString = String(metaStrings[0])
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.date = dateFormatter.date(from: dateString) ?? .distantPast

        var levelString = String(metaStrings[1])
        levelString.removeFirst()
        levelString.removeLast()
        self.level = MessageLevel(
            rawValue: Int(levelString) ?? MessageLevel.default.rawValue
        ) ?? .default

        var tagsString = String(metaStrings[2])
        tagsString.removeFirst()
        tagsString.removeLast()
        self.tags = tagsString.split(separator: ",").map({ String($0) })

        self.text = String(metaContentStrings[1])
    }

    public init(date: Date, level: MessageLevel, tags: [String], text: String) {
        self.date = date
        self.level = level
        self.tags = tags
        self.text = text
    }

    public var messageString: String {
        let dateString = dateFormatter.string(from: date)
        let levelCodeString = "\(level.rawValue)"
        let tagsString = tags
            .joined(separator: ",")
            .replacingOccurrences(of: " ", with: "")
            .uppercased()
        return "\(dateString) [\(levelCodeString)] [\(tagsString)]: \(text)"
    }
}
