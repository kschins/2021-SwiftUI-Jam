//
//  Network.swift
//  MyPicks
//
//  Created by Kasey Schindler on 11/5/21.
//

import Foundation

enum URLs {
    static let scores = "https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard"
    static let news = "https://site.api.espn.com/apis/site/v2/sports/football/nfl/news"
    static let teams = "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams"
    static let specificTeam = ""
}

class Network {
    static let shared = Network()

    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json",
                                               "Accept" : "application/json"]
        
        return URLSession(configuration: configuration)
    }()
    
    private init() { }
    
    // URL Request that takes returns a Decodable type
    func request<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                // successful response, parse JSON body
                do {
                    let decoder = JSONDecoder()
                    //decoder.dateDecodingStrategy = .iso8601
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    
                    completion(.success(decodedResponse))
                } catch let error {
                    // decodable error
                    completion(.failure(error))
                }
            } else {
                // TODO: Proper error handling
                print("Something else went horribly wrong...handle error here")
            }
        }
    }
}
