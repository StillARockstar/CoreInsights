//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

@available(iOS 14.0, watchOS 7.0, *)
struct FilesView: View {
    let provider: FilesViewProvider

    var body: some View {
        List(provider.loadedFileNames, id: \.self, rowContent: { filename in
            NavigationLink(
                destination: FileView(content: provider.content(of: filename)),
                label: {
                    VStack {
                        Text(filename)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Body1Text(provider.lastChanged(of: filename), alignment: .leading)
                    }
                })
        })
    }
}

@available(iOS 14.0, watchOS 7.0, *)
struct FilesView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView(
            provider: FilesViewProvider()
        )
    }
}
