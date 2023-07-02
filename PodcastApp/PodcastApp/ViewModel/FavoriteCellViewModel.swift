//
//  FavoritesViewModel.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 2.07.2023.
//

import Foundation
struct FavoritesCellViewModel {
    var podcastCoreData: PodcastCoreData!
    init(podcastCoreData: PodcastCoreData!) {
        self.podcastCoreData = podcastCoreData
    }
    var imageUrlPodcast: URL?{
        return URL(string: podcastCoreData.artworkUrl600!)
    }
    var podcastNameLabel: String? {
        return podcastCoreData.trackName
    }
    var podcastArtistName: String? {
        return podcastCoreData.artistName
    }
//    var podcastNameLabel: String? {
//        return podcastCoreData.feedUrl
//    }
}
