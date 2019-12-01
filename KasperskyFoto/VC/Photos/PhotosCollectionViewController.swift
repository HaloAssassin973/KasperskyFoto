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
    
    private var selectedImages = [UIImage]()
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите что искать"
        
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCollectionView()
        setupSearchBar()
        setupEnterLabel()
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
    }
    
    // MARK: - NavigationItems action
    
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
//        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: "PhotosCell")
        
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        
        if let waterfallLayout = collectionViewLayout as? WaterfallLayout {
            waterfallLayout.delegate = self
        }
    }
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupSearchBar() {
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        navigationItem.hidesSearchBarWhenScrolling = false
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.searchBar.delegate = self
    }
    
    // MARK: - UICollecionViewDataSource, UICollecionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let unspashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unspashPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else { return }
        selectedImages.append(image)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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
