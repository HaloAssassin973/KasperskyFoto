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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPhotoImageView()
    }
    
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var video: Hit? {
        didSet {
            print(video)
            let videoUrl = "https://i.vimeocdn.com/video/\(video?.pictureID ?? "773604276")_200x150.jpg"
            let url = URL(string: videoUrl)
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }
}
