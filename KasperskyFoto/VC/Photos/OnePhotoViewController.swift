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
    var kek = "oioioioioi"
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoUrl = kek
        let imageUrl = photoUrl
        let url = URL(string: imageUrl)
        imageView!.sd_setImage(with: url, completed: nil)
        print(kek)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
