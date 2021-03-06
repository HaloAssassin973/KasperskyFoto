//
//  SearchResults.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import Foundation

// MARK: - MediaObject
struct MediaObject: Codable {
    let totalHits: Int?
    let hits: [Hit]
    let total: Int?
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String?
    let webformatHeight, webformatWidth, likes, imageWidth: Int?
    let id, userID, views, comments: Int?
    let pageURL: String?
    let imageHeight: Int?
    let webformatURL: String?
    let type: String?
    let previewHeight: Int?
    let tags: String?
    let downloads: Int?
    let user: String?
    let favorites, imageSize, previewWidth: Int?
    let userImageURL, previewURL: String?
    let pictureID: String?
    let videos: Videos?
    let duration: Int?

    enum CodingKeys: String, CodingKey {
        case pictureID = "picture_id"
        case videos, duration
        case largeImageURL, webformatHeight, webformatWidth, likes, imageWidth, id
        case userID = "user_id"
        case views, comments, pageURL, imageHeight, webformatURL, type, previewHeight, tags, downloads, user, favorites, imageSize, previewWidth, userImageURL, previewURL
    }
}

// MARK: - Videos
struct Videos: Codable {
    let large, small, medium, tiny: Large?
}

// MARK: - Large
struct Large: Codable {
    let url: String?
    let width, size, height: Int?
}
