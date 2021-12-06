//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

struct FilesView: View {
    let provider: FilesViewProvider

    var body: some View {
        List(provider.loadedFileNames, id: \.self, rowContent: { filename in
            NavigationLink(
                destination: Text(""),
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

struct FilesView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView(
            provider: FilesViewProvider()
        )
    }
}
