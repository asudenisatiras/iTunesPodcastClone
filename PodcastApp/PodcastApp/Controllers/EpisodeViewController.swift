//
//  EpisodeViewController.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit
private let reuseIdentifier = "EpisodeCell"
class EpisodeViewController: UITableViewController {
    private var podcast : Podcast
    private var episodeResult : [Episode] = []{
        didSet{
            self.tableView.reloadData()
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
extension EpisodeViewController{
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
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
