////
////  VenueSearchAPI.swift
////  FindVenues
////
////  Created by Aitculesei, Andrei on 14.12.2021.
////
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let meta: Meta
    let response: Response
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case code
        case requestID
    }
}

// MARK: - Response
struct Response: Codable {
    let venues: [VenueDTO]
}

// MARK: - Venue
struct VenueDTO: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let venuePage: VenuePage
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix
        case suffix
    }
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode, cc, city, state: String
    let country: String
    let formattedAddress: [String]
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}

// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String
}
