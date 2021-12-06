//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI
import CoreInsightsShared

extension MessageLevel {
    var formatted: String {
        switch self {
        case .`default`:
            return "default"
        case .error:
            return "error"
        case .warning:
            return "warning"
        case .info:
            return "info"
        case .debug:
            return "debug"
        }
    }
}

extension LogMessage {
    var id: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: date) + text
    }

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    var formattedLevel: String {
        return level.formatted
    }

    var formattedTags: String {
        return tags.joined(separator: ", ")
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
extension View {

    func embedInNavigation() -> NavigationView<Self> {
        NavigationView {
            self
        }
    }

    func asAnyView() -> AnyView {
        AnyView(self)
    }
}
