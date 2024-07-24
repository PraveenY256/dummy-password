//
//  dummy_passwordApp.swift
//  dummy password
//
//  Created by Praveen Yeddu on 20/07/24.
//

import SwiftUI

@main
struct dummy_passwordApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
