//
//  Competitions.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 31.08.23.
//

import Foundation

struct Holes: Identifiable, Codable {
    let id: UUID
    var hole: Int
    var par: Int
    var hcp: Int
    var score: Int
    var tlsp_t: Float
    var tlsp_l: Float
    var tlsp_s: Float
    var tlsp_p: Float
    var nb_putt: Float
    var putt_distance: Float
    
    init(id: UUID=UUID()) {
        self.id = id
        self.hole = 0
        self.par = 0
        self.hcp = 0
        self.score = 0
        self.tlsp_t = -2
        self.tlsp_l = 1
        self.tlsp_s = 0
        self.tlsp_p = -1
        self.nb_putt = 2
        self.putt_distance = 10
    }
}


struct History: Identifiable, Codable {
    let id: UUID
    var competition: String
    var date_competition: Date
    var score: String
    var details: Holes
    
    init(id: UUID=UUID(), competition: String, score: String) {
        self.id = id
        self.competition = competition
        self.date_competition = Date()
        self.score = score
        self.details = Holes()
        
    }
    
}


struct Competitions: Identifiable, Codable {
    let id: UUID
    var competition: String
    var date_competition: Date
    var score: String
    var details: Holes
    
    init(id: UUID=UUID(), competition: String, score: String) {
        self.id = id
        self.competition = competition
        self.date_competition = Date()
        self.score = score
        self.details = Holes()
        
    }
    
}

extension Holes {
    static var emtpyHole: Holes {
        Holes()
    }
}



extension History {
    
    
    static var emptyHistory: History {
        History(competition: "new history --", score: "\(Int.random(in: -2...3))")
    }
}

extension Competitions {
    
    
    static var emptyCompetition: Competitions {
        Competitions(competition: "new record", score: "00")
    }
}

extension Competitions {
    static let sampleData: [Competitions] =
    [
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "British Master",
                     score: "73"),
        Competitions(competition: "PGA Championship",
                     score: "69"),
        Competitions(competition: "PGA Championship",
                     score: "69")
    ]
}


extension History {
    static let sampleData: [History] =
    [
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "British Master",
                     score: "73"),
        History(competition: "PGA Championship",
                     score: "69"),
        History(competition: "PGA Championship",
                     score: "69")
    ]
}
