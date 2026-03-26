//
//  LocalizationAppApp.swift
//  LocalizationApp
//
//  Created by Alex Arthur on 3/15/26.
//

import SwiftUI

@main
struct LocalizationApp: App {
    
    @AppStorage("selectedLanguage") private var language = "en"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, .init(identifier: language))
        }
    }
}
