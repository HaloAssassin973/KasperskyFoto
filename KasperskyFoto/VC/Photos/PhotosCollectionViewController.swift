//
//  PhotosCollectionViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    var timer: Timer?
    let reachability = try! Reachability()
    
    var photos = [Hit]()
    var cacheURLs = [String]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        networkDataFetcher.fetchPhotos(searchTerm: "") { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.hits
            for image in fetchedPhotos.hits {
                self?.cacheURLs.append(image.webformatURL!)
            }
            self?.collectionView.reloadData()
        }
    }

    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        if let waterfallLayout = collectionViewLayout as? WaterfallLayout {
            waterfallLayout.delegate = self
        }
    }
    
    private func setupSearchBar() {
        self.definesPresentationContext = true
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        navigationItem.hidesSearchBarWhenScrolling = false
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.searchBar.delegate = self
        seacrhController.searchBar.placeholder = "Поиск фото"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        let vc = segue.destination as! OnePhotoViewController
        let url = photos[indexPath.row].largeImageURL!
        if segue.identifier == "showPhoto" {
            vc.photoURL = url
        }
    }
    
    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if reachability.connection == .unavailable {
            return defaults.array(forKey: "cache")?.count ?? 0
        }
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        
        if reachability.connection == .unavailable {
            let urls = defaults.array(forKey: "cache") as! [String]
            cell.photoImageView.image = SDImageCache.shared.imageFromCache(forKey: urls[indexPath.row])
        } else {
            cell.photo = photos[indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if reachability.connection == .unavailable {
            let alertController = UIAlertController(title: "Нет сети", message: "Нельзя посмотреть полное изображения", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "showPhoto", sender: indexPath)
        }
    }
    
}
    

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchPhotos(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.hits
                self?.cacheURLs.removeAll()
                for image in fetchedPhotos.hits {
                    self?.cacheURLs.append(image.webformatURL!)
                }
                self?.collectionView.reloadData() 
            }
        })
    }
    
}

// MARK: - WaterfallLayoutDelegate
extension PhotosCollectionViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if reachability.connection == .unavailable {
            return CGSize(width: 100, height: 100)
        }
        let photo = photos[indexPath.item]
        return CGSize(width: photo.webformatWidth!, height: photo.webformatHeight!)
    }
}
