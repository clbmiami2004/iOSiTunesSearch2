//
//  SearchResult.swift
//  iOSiTuneSearch
//
//  Created by Lambda_School_Loaner_201 on 11/2/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"
    }
}

struct  SearchResults: Codable {
    let results: [SearchResult]
}



