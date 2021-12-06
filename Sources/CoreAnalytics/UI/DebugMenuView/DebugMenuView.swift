//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct DebugMenuView: View {
    @ObservedObject var provider: DebugMenuViewProvider
    @State private var showingResetAlert = false

    public init(provider: DebugMenuViewProvider) {
        self.provider = provider
    }

    public var body: some View {
        List {
            NavigationLink(
                "Logs",
                destination: LogsView(provider: LogsViewProvider())
            )
            NavigationLink(
                "Files",
                destination: FilesView(provider: FilesViewProvider())
            )
            Button("Reset App", action: {
                showingResetAlert = true
            })
            .alert(isPresented: $showingResetAlert) {
                Alert(
                    title: Text("Reset App"),
                    message: Text("Delete all data and restart"),
                    primaryButton: .destructive(
                        Text("Reset"),
                        action: {
                            provider.resetApp()
                        }),
                    secondaryButton:
                        .cancel()
                )
            }
            .foregroundColor(.red)
        }
        .embedInNavigation()
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView(
            provider: DebugMenuViewProvider()
        )
    }
}
