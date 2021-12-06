//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

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

struct LogsLevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsLevelsView(provider: LogsViewProvider())
    }
}
