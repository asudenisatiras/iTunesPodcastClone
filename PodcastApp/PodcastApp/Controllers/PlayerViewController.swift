//
//  PlayerViewController.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit
import AVKit
class PlayerViewController: UIViewController {
     
    var episode: Episode
    private var mainStackView : UIStackView!
    private let player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector (handleCloseButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        return button
    }()
    private let episodeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let sliderView: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    private let volumeSliderView: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector (handleVolumeSliderView), for: .valueChanged)
        return slider
    }()
    private var volumeStackView : UIStackView!
    
    private let minusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.1")
        imageView.tintColor = .lightGray
        return imageView
    }()
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "speaker.wave.3.fill")
        imageView.tintColor = .lightGray
        return imageView
    }()
    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = "00.00"
        label.textAlignment = .left
        return label
    }()
    
    private let endLabel: UILabel = {
        let label = UILabel()
        label.text = "00.00"
        label.textAlignment = .right
        return label
    }()
        
    private let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "name"
            label.textAlignment = .center
            label.numberOfLines = 2
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
            return label
        }()
    
        private let userLabel: UILabel = {
            let label = UILabel()
            label.text = "name"
            label.textAlignment = .center
            return label
        }()
    private lazy var goForWardButton: UIButton = {
        let button = UIButton(type:.system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "goforward.30"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector (handleGoForward),for: .touchUpInside)
        return button
    }()
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector (handleGoPlayButton), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    private lazy var goBackWardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        button.addTarget(self, action: #selector (handlegoBackWardButton),for: .touchUpInside)
        return button
    }()
    private var playStackView: UIStackView!
    private var timerStackView: UIStackView!
    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        startPlay()
        configureUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PlayerViewController{
    fileprivate func updateForward(value: Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), exampleTime)
        player.seek(to: seekTime)
    }
    fileprivate func updateSlider(){
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.sliderView.value = Float(resultSecondTime)
    }
    @objc private func handleGoPlayButton(_ sender: UIButton){
        if player.timeControlStatus == .paused{
            player.play()
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            player.pause()
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    @objc private func handleGoForward(_ sender: UIButton){
       updateForward(value: 30)
    }
    @objc private func handlegoBackWardButton(_sender:UIButton){
       updateForward(value: -15)
    }
    @objc private func handleVolumeSliderView(_ sender: UISlider){
        player.volume = sender.value
    }
}
extension PlayerViewController {
    @objc private func handleCloseButton(_ sender:UIButton){
        player.pause()
        self.dismiss(animated: true)
    }
}
extension PlayerViewController{
    fileprivate func updateTimeLabel(){
        let interval = CMTimeMake(value:1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
        }
    }
    private func style(){
        view.backgroundColor = .white
        timerStackView = UIStackView(arrangedSubviews: [startLabel, endLabel])
        timerStackView.axis = .horizontal
        
        let fullTimerStackView = UIStackView(arrangedSubviews: [sliderView,timerStackView])
        fullTimerStackView.axis = .vertical
        playStackView = UIStackView(arrangedSubviews: [UIView(),goBackWardButton,UIView(),playButton,UIView(),goForWardButton,UIView()])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        
        volumeStackView = UIStackView(arrangedSubviews: [minusImageView, volumeSliderView,plusImageView])
        volumeStackView.axis = .horizontal
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton, episodeImageView,fullTimerStackView,UIView(), nameLabel,userLabel,UIView(), playStackView,volumeStackView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalTo:view.widthAnchor, multiplier: 0.8 ),
            sliderView.heightAnchor.constraint(equalToConstant: 40),
            playStackView.heightAnchor.constraint(equalToConstant: 60),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -32),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }
    private func startPlay(){
        guard let url = URL(string: episode.streamUrl) else { return  }
        let playerItem = AVPlayerItem(url:url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.volumeSliderView.value = 40
        updateTimeLabel()
    }
    private func configureUI(){
        self.episodeImageView.kf.setImage(with: URL(string: episode.imageUrl))
        self.nameLabel.text = episode.title
        self.userLabel.text = episode.author
    }
}

