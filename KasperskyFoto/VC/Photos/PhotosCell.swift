//
//  PhotosCell.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var photo: Hit! {
        didSet {
            let photoUrl = photo.webformatURL!
            let url = URL(string: photoUrl)
            photoImageView.sd_setImage(with: url, completed: nil)
            //print(SDImageCache.shared.diskCachePath)
        }
    }
}
