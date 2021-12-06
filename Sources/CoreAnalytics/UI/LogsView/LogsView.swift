//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI
import CoreInsightsShared

struct LogsView: View {
    @ObservedObject var provider: LogsViewProvider

    var body: some View {
        ScrollView {
            HStack {
                NavigationLink(
                    destination: {
                        Text("Levels")
                    },
                    label: {
                        Text("Levels")
                    }
                )
                NavigationLink(
                    destination: {
                        Text("Levels")
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

struct LogMessageListView: View {
    let message: LogMessage

    var body: some View {
        NavigationLink(
            destination: {
                Text("")
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

#if DEBUG
struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(provider: LogsViewProvider())
    }
}
#endif

