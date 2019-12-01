//
//  PhotoCollectionView.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit

class PhotoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .red
        return cell
    }
}
