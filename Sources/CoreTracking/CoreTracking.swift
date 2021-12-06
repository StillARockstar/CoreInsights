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
    public static var logs: Logs!
    public static var files: Files!

    public static func configureInsights(_ outputs: Set<TrackingOutput>) {
        if config != nil {
            fatalError("CoreTracking was already configured")
        }
        Self.config = Configuration(outputs: outputs)
        Self.logs = Logs(
            config: Configuration(
                outputs: outputs,
                rootURL: Self.config!.rootURL.appendingPathComponent("Logs")
            )
        )
        Self.files = Files(
            config: Configuration(
                outputs: outputs,
                rootURL: Self.config?.rootURL.appendingPathComponent("Files")
            )
        )
    }
}
