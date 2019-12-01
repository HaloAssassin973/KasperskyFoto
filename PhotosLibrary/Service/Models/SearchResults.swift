//
//  SearchResults.swift
//  PhotosLibrary
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import Foundation

struct Foto: Decodable {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

// MARK: - Hit
struct Hit: Decodable {
    let largeImageURL: String?
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let id, userID, views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites, imageSize, previewWidth: Int
    let userImageURL, previewURL: String

    enum CodingKeys: String, CodingKey {
        case largeImageURL, webformatHeight, webformatWidth, likes, imageWidth, id
        case userID = "user_id"
        case views, comments, pageURL, imageHeight, webformatURL, type, previewHeight, tags, downloads, user, favorites, imageSize, previewWidth, userImageURL, previewURL
    }
}
