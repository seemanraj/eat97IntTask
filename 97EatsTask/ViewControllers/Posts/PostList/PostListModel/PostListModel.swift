//
//  PostListModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
class PostHeadData: Codable {
    let data: [PostData]?
    let total, page, limit: Int?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([PostData].self, forKey: .data)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
    }
}

// MARK: - Datum
class PostData: Codable {
    let id: String?
    let image: String?
    let likes: Int?
    let tags: [String]?
    let text, publishDate: String?
    let owner: Owner?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        publishDate = try values.decodeIfPresent(String.self, forKey: .publishDate)
        owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
    }
}

// MARK: - Owner
class Owner: Codable {
    let id: String?
    let title: Title?
    let firstName, lastName: String?
    let picture: String?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(Title.self, forKey: .title)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }
}

enum Title: String, Codable {
    case miss = "miss"
    case mr = "mr"
    case mrs = "mrs"
    case ms = "ms"
}
