//
//  VideosCell.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 13/12/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SDWebImage

class VideosCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var video: Hit? {
        didSet {
            let videoUrl = "https://i.vimeocdn.com/video/\(video?.pictureID ?? "773604276")_200x150.jpg"
            let url = URL(string: videoUrl)
            videoImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
