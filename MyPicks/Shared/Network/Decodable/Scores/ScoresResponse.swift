//
//  ScoresResponse.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import Foundation

struct ScoresResponse: Decodable, Identifiable {
    let id = UUID()
    //let leagues: []
    //let season: []
    //let week: [NFLTeam]
    let events: [NFLEvent]
}

struct NFLWeek: Decodable {
    let number: Int
    let teamsOnBye: [NFLTeam]
}

struct NFLTeam: Decodable, Identifiable {
    let id: String
    let uid: String
    let location: String
    let name: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
    let isActive: Bool
    let logo: URL
    let color: String?
    let alternateColor: String?
}

struct NFLEvent: Decodable, Identifiable {
    let id: String
    let uid: String
    let date: String
    let name: String
    let competitions: [NFLCompetition]
    let weather: NFLWeather?
    let status: NFLGameStatus
    
    var homeTeam: NFLCompetitor {
        competitions[0].competitors[0]
    }
    
    var awayTeam: NFLCompetitor {
        competitions[0].competitors[1]
    }
    
    var odds: NFLSpread? {
        if let odds = competitions[0].odds, odds.count > 0 {
            return odds[0]
        }
        
        return nil
    }
}

struct NFLCompetition: Decodable, Identifiable {
    let id: String
    let uid: String
    let date: String
    let attendance: Int
    let timeValid: Bool
    let neutralSite: Bool
    let conferenceCompetition: Bool
    let venue: NFLVenue
    let competitors: [NFLCompetitor]
    let status: NFLGameStatus
    let weather: NFLWeather?
    //let broadcasts
    //let leaders
    let odds: [NFLSpread]?
}

struct NFLSpread: Decodable {
    let provider: NFLSpreadProvider
    let details: String
    let overUnder: Double
}

struct NFLWeather: Decodable {
    let displayValue: String
    let highTemperature: Int
    let conditionId: String
}

struct NFLSpreadProvider: Decodable {
    let id: String
    let name: String
    let priority: Int
}

struct NFLGameStatus: Decodable {
    let clock: Double
    let displayClock: String
    let period: Int
    let type: NFLGameStatusType // ??? weird name
}

struct NFLGameStatusType: Decodable {
    let id: String
    let name: String
    let state: String
    let completed: Bool
    let description: String
    let detail: String
    let shortDetail: String
}

struct NFLVenue: Decodable, Identifiable {
    let id: String
    let fullName: String
    let address: NFLAddress
    let capacity: Int
    let indoor: Bool
}

struct NFLCompetitor: Decodable, Identifiable {
    let id: String
    let uid: String
    let homeAway: String
    let winner: Bool?
    let score: String?
    let team: NFLTeam
}

struct NFLAddress: Decodable {
    let city: String
    let state: String
}
