//
//  OnePhotoViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SDWebImage

class OnePhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var photoUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: photoUrl)
        imageView!.sd_setImage(with: url, completed: nil)
    }

}
