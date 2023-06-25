//
//  SearchViewModel.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 24.06.2023.
//

import Foundation
struct SearchViewModel {
    let podcast: Podcast
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    var photoImageUrl: URL?{
        return URL(string: podcast.artworkUrl600 ?? "")
    }
    var trackCount: String?{
        return "\(podcast.trackCount ?? 0)"
    }
    var artistName: String?{
        return podcast.artistName
    }
    var trackName: String?{
        return podcast.trackName
    }
}
