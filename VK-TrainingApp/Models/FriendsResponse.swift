//
//  FriendsResponse.swift
//  VK-TrainingApp
//
//  Created by mac on 04.06.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let friendsResponse = try? newJSONDecoder().decode(FriendsResponse.self, from: jsonData)

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: FriendItems?
}

// MARK: - FriendItems
struct FriendItems: Codable {
    let count: Int?
    let items: [Friend]?
}

// MARK: - Friend
struct Friend: Codable {
    let id: Int?
    let isClosed: Bool?
    let sex: Int?
    let trackCode: String?
    let canAccessClosed: Bool?
    let bdate: String?
    let city: City?
    let firstName, nickname: String?
    let photo50: String?
    let photo100: String?
    let online: Int?
    let lastName: String?
    let faculty: Int?
    let facultyName: String?
    let graduation, university: Int?
    let universityName: String?
    let relation: Int?
    let educationForm, educationStatus: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isClosed = "is_closed"
        case sex
        case trackCode = "track_code"
        case canAccessClosed = "can_access_closed"
        case bdate, city
        case firstName = "first_name"
        case nickname
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case lastName = "last_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation, university
        case universityName = "university_name"
        case relation
        case educationForm = "education_form"
        case educationStatus = "education_status"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let title: String?
}
