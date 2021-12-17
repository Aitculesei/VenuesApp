//
//  SettingsPlistParser.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation

struct SettingsPlistParser {
    static var settingsData: NSDictionary?
    
    static func getSettingsData(forKey key: String) -> String? {
        if settingsData == nil {
            let uri = Bundle.main.url(forResource: "Settings", withExtension: "plist")
            guard let uriChecked = uri else {
                return nil
            }
            let dictionary = try? NSDictionary(contentsOf: uriChecked, error: ())
            settingsData = dictionary
        }
        guard let data = settingsData else {
            return nil
        }
        return data[key] as? String
    }
}
