//
//  VideoPlayer.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 13/12/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import AVKit

class VideoPlayer: AVPlayerViewController {
    
    var timer: Timer?
    var videoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: videoURL)
        self.player = AVPlayer(url: url!) 
    }
}
