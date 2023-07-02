//
//  EpisodeViewController.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit
import CoreData
private let reuseIdentifier = "EpisodeCell"

class EpisodeViewController: UITableViewController {
   
    private var podcast : Podcast
    private var episodeResult : [Episode] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    private var isFavorite = false {
        didSet{
            setupNavBarItem()
        }
    }
    private var resultsCoreDataItems: [PodcastCoreData] = []{
        didSet{
            let isValue = resultsCoreDataItems.contains(where: {$0.feedUrl == self.podcast.feedUrl})
            if isValue{
                isFavorite = true
            }else {
                isFavorite = false
            }
        }
    }
    init(podcast: Podcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
       setup()
    fetchData()
    }
}
extension EpisodeViewController{
    fileprivate func fetchData(){
        EpisodeService.fetchData(urlString: self.podcast.feedUrl!) { result in
            DispatchQueue.main.async {
                self.episodeResult = result
            }
        }
    }
}
extension EpisodeViewController {
    @objc private func handleFavoriteButton() {
        if isFavorite{
            deleteCoreData()
        }else {
            addCoreData()
            
        }
    }
}
extension EpisodeViewController{
    private func deleteCoreData(){
        CoreDataController.deleteCoreData(array: resultsCoreDataItems, podcast: podcast)
        self.isFavorite = false
    }
    private func addCoreData(){
        let model = PodcastCoreData(context: context)
        CoreDataController.addCoreData(model: model, podcast: self.podcast)
        isFavorite = true
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarController
         mainTabController.viewControllers?[0].tabBarItem.badgeValue = "New"
    }
    private func fetchCoreData(){
        let fetchRequest = PodcastCoreData.fetchRequest()
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { result in
            self.resultsCoreDataItems = result
            
        }
  }
    private func setupNavBarItem(){
        if isFavorite {
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = navRightItem
        } else {
            let navRightItem = UIBarButtonItem(image:UIImage(systemName: "heart")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = navRightItem
        }
        
    }
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupNavBarItem()
        fetchCoreData()
    }
}
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        cell.episode = self.episodeResult[indexPath.item]
        cell.backgroundColor = .white
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodeResult[indexPath.item]
        let controller = PlayerViewController(episode: episode)
        self.present(controller, animated: true)
    }
}
