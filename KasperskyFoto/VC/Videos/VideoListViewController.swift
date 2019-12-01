//
//  VideoListViewController.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        }
        
        private func setupSearchBar() {
            let seacrhController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = seacrhController
            navigationItem.hidesSearchBarWhenScrolling = false
            seacrhController.hidesNavigationBarDuringPresentation = false
            seacrhController.obscuresBackgroundDuringPresentation = false
            seacrhController.searchBar.delegate = self as? UISearchBarDelegate
            seacrhController.searchBar.placeholder = "Поиск видео"
        }

}
