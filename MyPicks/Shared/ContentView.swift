//
//  ContentView.swift
//  Shared
//
//  Created by Kasey Schindler on 11/5/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            ScoresView()
                .tabItem {
                    Label("Scores", systemImage: "sportscourt")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
