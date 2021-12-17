//
//  Constants.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.12.2021.
//

import Foundation

struct Constants {
    enum Venue {
        static let details = "https://api.foursquare.com/v2/venues/1/"
        static let search = "https://api.foursquare.com/v2/venues/search?client_id=\(SettingsPlistParser.getSettingsData(forKey: "client_id") ?? "")&client_secret=\(SettingsPlistParser.getSettingsData(forKey: "client_secret") ?? "")"
    }
}
