//
//  SearchService.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 24.06.2023.
//

import Foundation
import Alamofire
class SearchService {
    static func fetchData(searchText: String, completion: @escaping ([Podcast]) -> Void ){
        let mainUrl = "https://itunes.apple.com/search"
        let parameters = ["media": "podcast", "term" : searchText]
        AF.request(mainUrl,parameters: parameters).responseData { response in
            if let error = response.error{
                print(error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            do{
                let searchResult = try JSONDecoder().decode(Search.self, from: data)
                completion(searchResult.results)
            } catch {
                
            }
        }
    }
}
