//
//  NewsView.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import SwiftUI

struct NewsView: View {
    @StateObject private var newsViewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            List(newsViewModel.articles) {
                NewsRow(article: $0)
            }
            .navigationTitle("NFL News")
        }
        .onAppear {
            newsViewModel.fetchNews()
        }
    }
}

struct NewsRow: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.headline)
                .fixedSize(horizontal: false, vertical: true)
                .font(.headline)
                .padding(.bottom, 5)
            Text(article.description)
                .fixedSize(horizontal: false, vertical: true)
                .font(.subheadline)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
