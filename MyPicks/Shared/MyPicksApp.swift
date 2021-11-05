//
//  MyPicksApp.swift
//  Shared
//
//  Created by Kasey Schindler on 11/5/21.
//

import SwiftUI

@main
struct MyPicksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
