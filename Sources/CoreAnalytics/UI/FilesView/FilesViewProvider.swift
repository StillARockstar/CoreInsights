//
//  File.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import Foundation
import Combine

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

