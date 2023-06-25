//
//  EpisodeModel.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import Foundation
import FeedKit

struct Episode{
    let title: String
    let pubDate: Date
    let description: String
    let imageUrl: String
    let streamUrl: String
    let author: String?
    
    init(value: RSSFeedItem) {
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.streamUrl = value.enclosure?.attributes?.url ?? ""
        self.description = value.iTunes?.iTunesSubtitle ?? value.description ?? ""
        self.imageUrl = value.iTunes?.iTunesImage?.attributes?.href ?? ""
        self.author = value.iTunes?.iTunesAuthor?.description ?? value.author ?? ""
    }
}
