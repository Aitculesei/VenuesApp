// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct VenuesDTO: Codable {
    let response: ResponseVenue?
}

// MARK: - Item
struct Item: Codable {
    let unreadCount: Int?
}

// MARK: - Response
struct ResponseVenue: Codable {
    let venues: [VenueData]?
    let geocode: Geocode?
}

// MARK: - Geocode
struct Geocode: Codable {
    let what, geocodeWhere: String?
    let feature: Feature?
}

// MARK: - Feature
struct Feature: Codable {
    let cc, name, displayName, matchedName: String?
    let highlightedName: String?
    let woeType: Int?
    let slug, id, longId: String?
    let geometry: Geometry?
}

// MARK: - Geometry
struct Geometry: Codable {
    let center: Center?
    let bounds: Bounds?
}

// MARK: - Bounds
struct Bounds: Codable {
    let ne, sw: Center?
}

// MARK: - Center
struct Center: Codable {
    let lat, lng: Double?
}

// MARK: - Venue
struct VenueData: Codable {
    let id, name: String?
    let contact: Contact?
    let location: Location?
    let canonicalURL: String?
    let canonicalPath: String?
    let categories: [Category]?
    let verified: Bool?
    let stats: Stats?
    let url: String?
    let urlSig: String?
    let allowMenuURLEdit: Bool?
    let beenHere: BeenHere?
    let specials: Specials?
    let hereNow: HereNow?
    let referralId: String?
    let hasPerk: Bool?
}

// MARK: - BeenHere
struct BeenHere: Codable {
    let lastCheckinExpiredAt: Int?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let icon: Icon?
    let primary: Bool?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix, mapPrefix: String?
    let suffix: String?
}

// MARK: - Contact
struct Contact: Codable {
    let phone, formattedPhone: String?
}

// MARK: - HereNow
struct HereNow: Codable {
    let count: Int?
    let summary: String?
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let postalCode, cc, city, state: String?
    let country, contextLine: String?
    let contextGeoId: Double?
    let formattedAddress: [String]?
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}

// MARK: - Specials
struct Specials: Codable {
    let count: Int?
}

// MARK: - Stats
struct Stats: Codable {
    let tipCount, usersCount, checkinsCount: Int?
}
