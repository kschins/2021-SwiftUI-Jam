//
//  ScoresView.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import SwiftUI

struct ScoresView: View {
    @StateObject private var scoresViewModel = ScoresViewModel()

    var body: some View {
        NavigationView {
            List(scoresViewModel.games) {
                Text($0.name)
            }
            .navigationTitle("Scores")
        }
        .onAppear {
            scoresViewModel.fetchScores()
        }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
