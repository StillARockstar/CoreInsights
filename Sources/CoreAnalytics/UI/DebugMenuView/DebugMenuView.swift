//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

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

#if DEBUG
struct DebugMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView(
            provider: DebugMenuViewProvider()
        )
    }
}
#endif
