//
//  ScoresViewModel.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import Foundation

class ScoresViewModel: ObservableObject {
    @Published var games: [NFLEvent] = []

    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json",
                                               "Accept" : "application/json"]
        
        return URLSession(configuration: configuration)
    }()

    func fetchScores() {
        let urlRequest = URLRequest(url: URL(string: URLs.scores)!)
        
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                // successful response, parse JSON body
                do {
                    let decoder = JSONDecoder()
                    //decoder.dateDecodingStrategy = .iso8601
                    let decodedResponse = try decoder.decode(ScoresResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.games = decodedResponse.events
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
