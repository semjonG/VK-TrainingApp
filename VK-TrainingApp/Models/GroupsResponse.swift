//
//  GroupsResponse.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: GroupItem?
}

// MARK: - Response
struct GroupItem: Codable {
    let count: Int?
    let items: [Group]?
}

// MARK: - Item
struct Group: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
