//
//  SwiftUI_AdvancedApp.swift
//  SwiftUI Advanced
//
//  Created by Tony on 05/01/2022.
//

import SwiftUI

@main
struct SwiftUI_AdvancedApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
