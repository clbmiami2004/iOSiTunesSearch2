//
//  SearchResultController.swift
//  iOSiTuneSearch
//
//  Created by Lambda_School_Loaner_201 on 11/2/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var search: [SearchResult] = []


func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem1 = URLQueryItem(name: "term", value: searchTerm)
    let searchQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQueryItem1, searchQueryItem2]
        guard let requestURL = urlComponents?.url else {
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, _,
            error in
            if let error = error {
                print("Error Fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data return from data task")
                return
            }
            
            let jsonDecoder = JSONDecoder()
    
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.search = searchResults.results
                self.search.append(contentsOf: searchResults.results)
            } catch {
                print("Unable to decode data \(error)")
            }
            completion()
        }
        task.resume()
    }
}


