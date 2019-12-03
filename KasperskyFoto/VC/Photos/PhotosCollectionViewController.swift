//
//  PhotosCollectionViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var photos = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        networkDataFetcher.fetchImages(searchTerm: "") { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.hits
            self?.collectionView.reloadData()
            self?.refresh()
        }
    }
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "Load View") {
            // pass data to next view
        }
    }
    func refresh() {
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
    }
    
    // MARK: - NavigationItems action
    
    
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
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        let vc = segue.destination as! OnePhotoViewController
        let url = photos[indexPath.row].largeImageURL!
        if segue.identifier == "showme" {
            vc.photoUrl = photos[indexPath.row].largeImageURL!
        }

    }
    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let unspashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unspashPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showme", sender: indexPath)
//        {
//            let destVC = UIViewController() as? OnePhotoViewController
//            let photoUrl = cell.unsplashPhoto.largeImageURL
//            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
//            destVC?.imageView!.sd_setImage(with:url, completed: nil)
//            destVC!.kek = "hui"
//        }
    }
    
    
}
    

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.hits
                self?.collectionView.reloadData()
                self?.refresh()
            }
        })
    }
}

// MARK: - WaterfallLayoutDelegate
extension PhotosCollectionViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photo = photos[indexPath.item]
        return CGSize(width: photo.imageWidth, height: photo.imageHeight)
    }
}
