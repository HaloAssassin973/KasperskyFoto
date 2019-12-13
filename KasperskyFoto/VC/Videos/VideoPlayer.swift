//
//  VideoPlayer.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 13/12/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import AVKit

class VideoPlayer: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://player.vimeo.com/external/328940142.hd.mp4?s=1ea57040d1487a6c9d9ca9ca65763c8972e66bd4&profile_id=174")!
        self.player = AVPlayer(url: url)
        self.player?.play()
    }
    
    
}
