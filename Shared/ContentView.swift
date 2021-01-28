//
//  ContentView.swift
//  Shared
//
//  Created by ADH Media Production on 1/28/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ITS90MultiPlatformDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ITS90MultiPlatformDocument()))
    }
}
