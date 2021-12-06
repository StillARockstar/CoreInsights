//
//  CoreTracking.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation

public enum TrackingOutput {
    case console
    case logFiles
}

public class CoreTracking {
    struct Configuration {
        let outputs: Set<TrackingOutput>
        let rootURL: URL

        init(outputs: Set<TrackingOutput>, rootURL: URL? = nil) {
            self.outputs = outputs
            self.rootURL = rootURL ?? FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Insights")
        }
    }
    private static var config: Configuration?

    public static func configureInsights(_ outputs: Set<TrackingOutput>) {
        if config != nil {
            fatalError("CoreInsights was already configured")
        }
        Self.config = Configuration(outputs: outputs)
    }
}
