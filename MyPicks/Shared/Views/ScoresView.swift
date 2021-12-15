//
//  ScoresView.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import SwiftUI

struct ScoresView: View {
    @StateObject private var scoresViewModel = ScoresViewModel()
    @State var showMyBets = false
    @State var selectedGame: NFLEvent?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(scoresViewModel.games) { game in
                    GameCard(game: game)
                        .onTapGesture {
                            selectedGame = game
                        }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Week 9 Scores")
            .toolbar {
                Button("My Bets") {
                    showMyBets.toggle()
                }
            }
        }
        .sheet(isPresented: $showMyBets) {
            // show list of bets for this week
            MyBetsView()
        }
        .sheet(item: $selectedGame) { selected in
            // show game details, allow selecting a team and adjust line to what you got it as
            NewBetView(game: selected)
        }
        .onAppear {
            scoresViewModel.fetchScores()
        }
    }
}

struct GameCard: View {
    let game: NFLEvent
    
    var body: some View {
        ZStack {
            Color
                .gray
                .opacity(0.15)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                TeamView(team: game.awayTeam)
                TeamView(team: game.homeTeam)
                HStack {
                    if let odds = game.odds {
                        Text(odds.details)
                            .font(.footnote)
                    }
                    Spacer()
                    Text(game.status.type.shortDetail)
                        .font(.footnote)
                }
            }
            .padding()
        }
    }
}

struct TeamView: View {
    let team: NFLCompetitor
    
    var body: some View {
        HStack {
            AsyncImage(url: team.team.logo) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 25, height: 25)
            Text(team.team.name)
                .bold()
            Spacer()
            Text(team.score ?? "0")
        }
    }
}
