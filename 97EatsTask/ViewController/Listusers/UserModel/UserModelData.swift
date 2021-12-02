//
//  UserModelData.swift
//  MVVM Starter Project
//
//  Created by System Admin on 30/11/21.
//

import Foundation

class UserHeadData : Codable {
    let total, page, limit: Int?
    let data : [UserData]?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        data = try values.decodeIfPresent([UserData].self, forKey: .data)
    }
}

class UserData : Codable {
    let id, title, firstName, lastName: String?
    let picture: String?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }
}
