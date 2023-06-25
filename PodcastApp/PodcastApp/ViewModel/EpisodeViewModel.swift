//
//  EpisodeViewModel.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit
struct EpisodeViewModel{
    let episode: Episode!
    init(episode: Episode!) {
        self.episode = episode
    }
    var profileImageURL : URL? {
        return URL(string: episode.imageUrl)
    }
    var title: String?{
        return episode.title
        
    }
    var description:String?{
        return episode.description
    }
    var pubDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyy"
        return dateFormatter.string(from: episode.pubDate)
    }
}
