//
//  Search.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 24.06.2023.
//

import Foundation

struct Search: Decodable {
    let resultCount : Int
    let results: [Podcast]
    
}
struct Podcast: Decodable {
    var trackName: String?
    var artistName: String
    var trackCount: Int?
    var feedUrl: String?
    var artworkUrl600: String?
}
