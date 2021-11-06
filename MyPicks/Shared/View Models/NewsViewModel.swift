//
//  NewsViewModel.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []

    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json",
                                               "Accept" : "application/json"]
        
        return URLSession(configuration: configuration)
    }()

    func fetchNews() {
        let urlRequest = URLRequest(url: URL(string: URLs.news)!)
        
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                // successful response, parse JSON body
                do {
                    let decoder = JSONDecoder()
                    //decoder.dateDecodingStrategy = .iso8601
                    let decodedResponse = try decoder.decode(NewsResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.articles = decodedResponse.articles
                    }
                } catch let error {
                    // decodable error
                    print("Decodable Error: \(error)")
                }
            } else {
                // TODO: Proper error handling
                print("Something else went horribly wrong...handle error here")
            }
        }.resume()
    }
}
