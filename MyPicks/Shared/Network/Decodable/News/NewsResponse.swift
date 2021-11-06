//
//  NewsResponse.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import Foundation

struct NewsResponse: Decodable {
    let header: String
    let articles: [Article]
}

struct Article: Decodable, Identifiable {
    let id = UUID()
    //let images: [NewsImage]
    let headline: String
    let description: String
    let published: String // TODO: use DateFormatter to decode on the fly to Date
    let type: String
    let premium: Bool
    // let links: [NewsLink]
    let lastModified: String // TODO: use DateFormatter to decode on the fly to Date
    // let categories: [NewsCategoty]
}

struct NewsImage: Decodable {
    let name: String
    let type: StringLiteralType
    let url: URL
    let width: Int?
    let height: Int?
    let ratio: String?
}
