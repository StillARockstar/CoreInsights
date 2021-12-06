//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI
import CoreInsightsShared

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogsView: View {
    @ObservedObject var provider: LogsViewProvider

    var body: some View {
        ScrollView {
            HStack {
                NavigationLink(
                    destination: {
                        LogsLevelsView(provider: provider)
                    },
                    label: {
                        Text("Levels")
                    }
                )
                NavigationLink(
                    destination: {
                        LogsTagsView(provider: provider)
                    },
                    label: {
                        Text("Tags")
                    }
                )
            }
            VStack {
                ForEach(provider.filteredLogMessages, id: \.id, content: { logMessage in
                    LogMessageListView(message: logMessage)
                })
                if provider.moreLogBatchesAvailabe {
                    Button("Load More", action: {
                        provider.loadMoreLogs()
                    })
                }
            }
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogMessageListView: View {
    let message: LogMessage

    var body: some View {
        NavigationLink(
            destination: {
                LogMessageView(message: message)
            },
            label: {
                VStack(alignment: .leading) {
                    Text(message.formattedDate)
                        .font(Font.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Text(message.text)
                        .font(Font.system(.caption2, design: .monospaced))
                        .multilineTextAlignment(.leading)
                }
            }
        )
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(provider: LogsViewProvider())
    }
}
