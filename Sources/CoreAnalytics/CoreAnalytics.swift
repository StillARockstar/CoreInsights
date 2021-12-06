//
//  CoreAnalytics.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation

public class CoreAnalytics {
    struct Configuration {
        let rootURL: URL

        init(rootURL: URL? = nil) {
            self.rootURL = rootURL ?? FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Insights")
        }
    }
    private static var config: Configuration?

    public static func configureInsights() {
        if config != nil {
            fatalError("CoreAnalytics was already configured")
        }
        Self.config = Configuration()
    }
}
