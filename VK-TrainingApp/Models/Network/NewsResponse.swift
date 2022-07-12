//
//  NewsResponse.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)

// MARK: - NewsJSON
struct NewsJSON: Codable {
    let response: NewsResponse?
}

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let items: [NewsItem]?
    let profiles: [Profile]?
    let groups: [Group]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - ResponseItem
class NewsItem: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory, isFavorite: Bool?
    let postType, text: String? // отсюда не  приходит текст новости
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: Comments?
    let likes: PurpleLikes? // отсюда не  приходят лайки новости
//    let reposts: Reposts?
//    let views: Views?
//    let copyright: Copyright?
//    let donut: Donut?
    let shortTextRate: Double?
    let postID: Int?
    let type: String?
    let photos: Photos?
    var profile: Profile? // связанный профиль (не парсится)
    var group: Group? // связанная группа (не парсится)
    

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes //reposts, views, copyright, donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type, photos
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let photo: Photo?
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Copyright
struct Copyright: Codable {
    let link: String?
    let type, name: String?
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool?

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let canLike, count, userLikes, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let items: [PhotosItem]?
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let albumID, date, id, ownerID: Int?
    let accessKey: String?
    let canComment, postID: Int?
    let sizes: [Size]?
    let text: String? // ???
    let userID: Int?
    let hasTags: Bool?
    let likes: FluffyLikes? // ???
    let comments: Views?
    let reposts: Reposts?
    let canRepost: Int?
    
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
        case accessKey = "access_key"
        case canComment = "can_comment"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case hasTags = "has_tags"
        case likes, comments, reposts
        case canRepost = "can_repost"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let count, userLikes: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
//struct Reposts: Codable {
//    let count, userReposted: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userReposted = "user_reposted"
//    }
//}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String?
}

// MARK: - Profile
struct Profile: Codable {
    let id, sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: OnlineInfo?
    let online: Int?
    let firstName, lastName: String?
    let canAccessClosed, isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible: Bool?
    let lastSeen: Int?
    let isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
