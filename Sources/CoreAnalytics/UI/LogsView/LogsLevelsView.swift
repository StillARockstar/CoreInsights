//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogsLevelsView: View {
    @ObservedObject var provider: LogsViewProvider

    var body: some View {
        ScrollView {
            VStack {
                ForEach(provider.availableLogLevels(), id: \.self, content: { level in
                    Button(
                        action: {
                            provider.toggleLogFilter(level)
                        },
                        label: {
                            HStack {
                                if provider.shownLevels.contains(level) {
                                    Text("✅ \(level.formatted)")
                                } else {
                                    Text("🔲 \(level.formatted)")
                                }
                                Spacer()
                            }
                        }
                    )
                })
            }
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogsLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsLevelsView(provider: LogsViewProvider())
    }
}
