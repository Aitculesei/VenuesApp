//
//  GetVenuePhotosAPI.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.01.2022.
//

import Foundation

// MARK: - Welcome
struct VenuePhotosDTO: Codable {
    let response: VenuePhotoResponse
}

// MARK: - Response
struct VenuePhotoResponse: Codable {
    let venue: Venue
    let pageConfig: PageConfig
}

// MARK: - PageConfig
struct PageConfig: Codable {
    let hideTastepile, showSeeAllTipsButton: Bool
    let tipCountMax: Int
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String
    let photos: Photos
}

// MARK: - BestPhoto
struct BestPhoto: Codable {
    let id: String
    let createdAt: Int
    let prefix: String
    let suffix: String
    let width, height: Int
    let visibility: String
}

// MARK: - Photo
struct Photo: Codable {
    let photoPrefix: String
    let suffix: String
    let photoDefault: Bool

    enum CodingKeys: String, CodingKey {
        case photoPrefix
        case suffix
        case photoDefault
    }
}

// MARK: - Likes
struct Photos: Codable {
    let count: Int
    let groups: [Group]
}

// MARK: - Group
struct Group: Codable {
    let type, name: String
    let count: Int
    let items: [BestPhoto]
}
