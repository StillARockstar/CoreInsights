//
//  SwiftUIView.swift
//  
//
//  Created by Michael Schoder on 06.12.21.
//

import SwiftUI

struct FileView: View {
    let content: String

    var body: some View {
        ScrollView {
            Text(content)
                .lineLimit(nil)
                .font(Font.system(.caption2, design: .monospaced))
        }
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        FileView(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est leo, vehicula eu eleifend non, auctor ut arcu")
    }
}

