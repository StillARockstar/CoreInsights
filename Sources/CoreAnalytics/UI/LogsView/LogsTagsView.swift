//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

@available(iOS 14.0, watchOS 7.0, *)
struct LogsTagsView: View {
    @ObservedObject var provider: LogsViewProvider

    var body: some View {
        ScrollView {
            VStack {
                ForEach(provider.availableTags(), id: \.self, content: { tag in
                    Button(
                        action: {
                            provider.toggleTagFilter(tag)
                        },
                        label: {
                            HStack {
                                if provider.shownTags?.contains(tag) ?? false {
                                    Text("✅ \(tag)")
                                } else {
                                    Text("🔲 \(tag)")
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

@available(iOS 14.0, watchOS 7.0, *)
struct LogsTagsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTagsView(provider: LogsViewProvider())
    }
}

