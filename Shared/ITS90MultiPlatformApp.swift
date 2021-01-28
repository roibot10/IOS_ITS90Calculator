//
//  ITS90MultiPlatformApp.swift
//  Shared
//
//  Created by ADH Media Production on 1/28/21.
//

import SwiftUI

@main
struct ITS90MultiPlatformApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ITS90MultiPlatformDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
