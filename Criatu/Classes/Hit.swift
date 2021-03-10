//
//  Hit.swift
//  Criatu
//
//  Created by Danilo Araújo on 09/03/21.
//

import Foundation

// MARK: - Hit
class Hit: Codable {
    let id: Int
    let pageURL: String
    let type: String
    var tags: String
    var tagsArray: [String] = []
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, favorites, likes, comments: Int
    let userID: Int
    let user: String
    let userImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
    
    init(id: Int, pageURL: String, type: String, tags: String, previewURL: String, previewWidth: Int, previewHeight: Int, webformatURL: String, webformatWidth: Int, webformatHeight: Int, largeImageURL: String, imageWidth: Int, imageHeight: Int, imageSize: Int, views: Int, downloads: Int, favorites: Int, likes: Int, comments: Int, userID: Int, user: String, userImageURL: String) {
        self.id = id
        self.pageURL = pageURL
        self.type = type
        self.tags = tags
        self.previewURL = previewURL
        self.previewWidth = previewWidth
        self.previewHeight = previewHeight
        self.webformatURL = webformatURL
        self.webformatWidth = webformatWidth
        self.webformatHeight = webformatHeight
        self.largeImageURL = largeImageURL
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageSize = imageSize
        self.views = views
        self.downloads = downloads
        self.favorites = favorites
        self.likes = likes
        self.comments = comments
        self.userID = userID
        self.user = user
        self.userImageURL = userImageURL
    }
}
