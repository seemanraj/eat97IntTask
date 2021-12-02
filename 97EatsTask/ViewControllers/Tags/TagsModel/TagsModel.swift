//
//  TagsModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

class TagData: Codable {
    let data: [String]?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([String].self, forKey: .data)
    }
}
