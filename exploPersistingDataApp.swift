//
//  exploPersistingDataApp.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 31.08.23.
//

import SwiftUI

@main
struct exploPersistingDataApp: App {
    
    @StateObject private var store = CompetitionsStore()
    @StateObject private var histo = HistoryStore()
    var body: some Scene {
        WindowGroup {
            ContentView(competitions: $store.competitions, history: $histo.history) {
                Task {
                    do {
                        try await store.save(competitions: store.competitions)
                        print("store.save called")
                    } catch {
                        print("Error when saving")
                        fatalError(error.localizedDescription)
                        
                    }
                }
                Task {
                    do {
                        try await histo.save(history: histo.history)
                        print("history.save called")
                    } catch {
                        print("Error when saving")
                        fatalError(error.localizedDescription)
                        
                    }
                }

                
                
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        //fatalError(error.localizedDescription)
                        print("Error when loading")
                    }
                }
                .task {
                    do {
                        try await histo.load()
                    } catch {
                        //fatalError(error.localizedDescription)
                        print("Error when loading")
                    }
                }
        }
    }
}
