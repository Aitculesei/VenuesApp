// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct VenuesDTO: Codable {
    let results: [VenueDTO]
}

// MARK: - Result
struct VenueDTO: Codable {
    let fsqID: String
    let categories: [Category]
    let distance: Int
    let geocodes: Geocodes
    let location: Location
    let name: String
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, distance, geocodes, location, name
        case timezone
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let icon: Icon
}

// MARK: - Icon
struct Icon: Codable {
    let prefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case prefix
        case suffix
    }
}

// MARK: - Geocodes
struct Geocodes: Codable {
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let country: String
    let crossStreet, locality, postcode, region: String?

    enum CodingKeys: String, CodingKey {
        case address, country
        case crossStreet = "cross_street"
        case locality, postcode, region
    }
}
