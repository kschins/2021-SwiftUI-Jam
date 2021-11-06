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
    let score: String?
    //let linescores: []
}

struct NFLGameStatus: Decodable {
    let clock: Double
    let displayClock: String
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
}

struct NFLAddress: Decodable {
    let city: String
    let state: String
}
