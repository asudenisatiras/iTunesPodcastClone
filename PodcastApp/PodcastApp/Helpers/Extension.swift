//
//  Extension.swift
//  PodcastApp
//
//  Created by Asude Nisa Tıraş on 25.06.2023.
//

import UIKit
import CoreMedia
extension UIImageView{
    func customMode(){
        self.clipsToBounds = true
        self.contentMode = .scaleToFill
    }
}
extension CMTime{
    func formatString() -> String {
        let totalSecond = Int(CMTimeGetSeconds(self))
        let second = totalSecond % 60
        let minutes = totalSecond / 60
        let formatString = String(format: "%02d : %02d", minutes, second)
        return formatString
    }
}
