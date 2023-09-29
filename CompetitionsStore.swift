//
//  CompetitionsStore.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 31.08.23.
//

import SwiftUI
@MainActor
class CompetitionsStore: ObservableObject {
    @Published var competitions: [Competitions] = []
    //var private fname: String = "competitions.data"
    
    private static func fileURL(fname: String) throws -> URL {

        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(fname)")

    }
    
    func load() async throws {
        let task = Task<[Competitions], Error> {
            let fileURL = try Self.fileURL(fname: "competitions.data")
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let gameCompetitions = try JSONDecoder().decode([Competitions].self, from: data)
            return gameCompetitions
        }
        let competitions = try await task.value
        self.competitions = competitions
    }
    
    func save(competitions: [Competitions]) async throws {
        print("Save called")
        let task = Task {
            let data = try JSONEncoder().encode(competitions)
            let outfile = try Self.fileURL(fname: "competitions.data")
            try data.write(to: outfile)
        }
        _ = try await task.value


    }
 


    
}
