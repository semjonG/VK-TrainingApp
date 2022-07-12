//
//  PhotosResponse.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photosResponse = try? newJSONDecoder().decode(PhotosResponse.self, from: jsonData)

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let response: PhotoItems?
}

// MARK: - Response
struct PhotoItems: Codable {
    let count: Int?
    let items: [Photo]?
}

// MARK: - Item
struct Photo: Codable {
    let albumID, date, id, ownerID: Int?
    let postID: Int?
    let sizes: [Size]?
    let text: String?
    let hasTags: Bool?
    let likes: Likes?
    let reposts: Reposts?
    
    var largePhotoURL: String {
        return sizes?.last?.url ?? ""
    }
    
    var smallPhotoURL: String {
        return sizes?.first?.url ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case postID = "post_id"
        case sizes, text
        case hasTags = "has_tags"
        case likes, reposts
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int?
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}
