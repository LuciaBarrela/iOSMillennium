//
//  iOsBooksApp.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import SwiftUI

@main
struct iOsBooksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
