//
//  ViewUserModel.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation

class UserDetail: Codable {
    let id, title, firstName, lastName: String?
    let picture: String?
    let gender, email, dateOfBirth, phone: String?
    let location: Location?
    let registerDate, updatedDate: String?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        registerDate = try values.decodeIfPresent(String.self, forKey: .registerDate)
        updatedDate = try values.decodeIfPresent(String.self, forKey: .updatedDate)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
    }

}

// MARK: - Location
class Location: Codable {
    let street, city, state, country: String?
    let timezone: String?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }
}
