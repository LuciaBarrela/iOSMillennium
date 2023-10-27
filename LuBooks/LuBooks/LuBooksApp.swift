//
//  LuBooksApp.swift
//  LuBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import SwiftUI

@main
struct LuBooksApp: App {
    let persistenceController = PersistenceController.shared

    @State private var showContentView = false

    var body: some Scene {
        WindowGroup {
            if showContentView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                WelcomeView(showContentView: $showContentView)
            }
        }
    }
}
