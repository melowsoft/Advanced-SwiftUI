//
//  SwiftUI_AdvancedApp.swift
//  SwiftUI Advanced
//
//  Created by Tony on 05/01/2022.
//

import SwiftUI
import Firebase

@main
struct SwiftUI_AdvancedApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
