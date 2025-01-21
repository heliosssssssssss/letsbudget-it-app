//
//  letsbudget_itApp.swift
//  letsbudget.it
//
//  Created by user267420 on 1/18/25.
//

import SwiftUI
import SwiftData

@main
struct letsbudget_itApp: App {
    @StateObject private var viewState = ViewState()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            PreInitializationView()
                .environmentObject(viewState)
        }
        .modelContainer(sharedModelContainer)
    }
}

struct PreInitializationView: View {
    @EnvironmentObject var viewState: ViewState

    var body: some View {
        if viewState.isAuthenticated {
            NavUI()
        } else {
            InitializationView()
        }
    }
}

