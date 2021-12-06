//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import Combine

@available(iOS 14.0, watchOS 7.0, *)
class FilesViewProvider: ObservableObject {
    @Published var loadedFileNames: [String] = []

    init() {
        loadFileNames()
    }

    func loadFileNames() {
        self.loadedFileNames = CoreAnalytics.files.availableFiles()
    }

    func content(of filename: String) -> String {
        return CoreAnalytics.files.loadFileContent(name: filename)
    }
}

