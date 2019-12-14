//
//  OnePhotoViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SDWebImage

class OnePhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    var photoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: photoURL)
        imageView!.sd_setImage(with: url, placeholderImage: UIImage(), options: [.progressiveLoad, .highPriority], completed: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / (imageView.image?.size.width ?? 0)
        let heightScale = size.height / (imageView.image?.size.height ?? 0)
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {

        let yOffset = max(0, (size.height - (imageView.image?.size.height ?? 0)) / 2)
        topConstraint.constant = yOffset
        bottomConstraint.constant = yOffset
      
        let xOffset = max(0, (size.width - (imageView.image?.size.width ?? 0)) / 2)
        leadingConstraint.constant = xOffset
        trailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}
