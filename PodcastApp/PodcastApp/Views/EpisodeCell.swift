//
//  EpisodeCell.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit

class EpisodeCell: UITableViewCell{
    
    var episode: Episode?{
        didSet{
            configure()
        }
    }
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemCyan
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let pubDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "pubDateLabel"
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.text = "title Label"
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.text = "title Label"
        return label
    }()
    private var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EpisodeCell{
    private func setup(){
        backgroundColor = .red
        configureUI()
    }
    private func configureUI(){
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeImageView)
        NSLayoutConstraint.activate([
            episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeImageView.heightAnchor.constraint(equalToConstant: 100),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)

        ])
        stackView = UIStackView(arrangedSubviews: [pubDateLabel, titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    
        
    }
    private func configure(){
        guard let episode = self.episode else { return }
        let viewModel = EpisodeViewModel(episode: episode)
        self.titleLabel.text = viewModel.title
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.episodeImageView.kf.setImage(with: viewModel.profileImageURL)
        self.pubDateLabel.text = viewModel.pubDate
        }
    }

