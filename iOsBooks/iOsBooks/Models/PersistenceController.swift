//
//  PersistenceController.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BookModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error: \(error)")
            }
        }
    }
}
