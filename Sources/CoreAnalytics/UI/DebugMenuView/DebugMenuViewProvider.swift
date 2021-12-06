//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import Combine
import CoreInsightsShared
import CoreTracking

public class DebugMenuViewProvider: ObservableObject {
    
    public init() {
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
            CoreTracking.logs.track("Failed Resetting App", level: .error)
        }
    }

    private func restartApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            exit(0)
        })
    }
}

