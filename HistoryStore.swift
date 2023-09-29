//
//  HistoryStore.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 15.09.23.
//





import SwiftUI
@MainActor
class HistoryStore: ObservableObject {
    @Published var history: [History] = []
    //var private fname: String = "competitions.data"
    
    private static func fileURL(fname: String) throws -> URL {

        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(fname)")

    }
    
    func load() async throws {
        let task = Task<[History], Error> {
            let fileURL = try Self.fileURL(fname: "history.data")
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let gameCompetitions = try JSONDecoder().decode([History].self, from: data)
            return gameCompetitions
        }
        let competitions = try await task.value
        self.history = competitions
    }
    
    func save(history: [History]) async throws {
        print("Save called")
        let task = Task {
            let data = try JSONEncoder().encode(history)
            let outfile = try Self.fileURL(fname: "history.data")
            try data.write(to: outfile)
        }
        _ = try await task.value



    }
 


    
}
