//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI
import CoreInsightsShared

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
struct LogMessageView: View {
    let message: LogMessage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Date")
                        .font(Font.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    Text(message.formattedDate)
                        .font(Font.system(.body, design: .monospaced))
                }
                Divider()
                Group {
                    Text("Message")
                        .font(Font.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    Text(message.text)
                        .font(Font.system(.body, design: .monospaced))
                }
                Divider()
                Group {
                    Text("Level")
                        .font(Font.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    Text(message.formattedLevel)
                        .font(Font.system(.body, design: .monospaced))
                }
                Divider()
                Group {
                    Text("Tags")
                        .font(Font.system(.footnote, design: .monospaced))
                        .foregroundColor(.gray)
                    Text(message.formattedTags)
                        .font(Font.system(.body, design: .monospaced))
                }
            }
        }
    }
}
