//
//  VideosCollectionViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 13/12/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit

class VideosCollectionViewController: UICollectionViewController {

    var networkDataFetcher = NetworkDataFetcher()
    var timer: Timer?
    
    var videos = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        networkDataFetcher.fetchVideos(searchTerm: "") { [weak self] (searchResults) in
            guard let fetchedVideos = searchResults else { return }
            self?.videos = fetchedVideos.hits
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
        seacrhController.searchBar.placeholder = "Поиск видео"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        let vc = segue.destination as! VideoPlayer
        let url = videos[indexPath.row].videos?.tiny?.url
        if segue.identifier == "showVideo" {
            vc.videoURL = url!
        }
    }


    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCell", for: indexPath) as! VideosCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showVideo", sender: indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension VideosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchVideos(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedVideos = searchResults else { return }
                self?.videos = fetchedVideos.hits
                self?.collectionView.reloadData()
            }
        })
    }
}

// MARK: - WaterfallLayoutDelegate
extension VideosCollectionViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
}
