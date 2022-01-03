//
//  SettingsPlistParser.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation

/// The one that is parsing the data stored in the Settings plist.
struct SettingsPlistParser {
    /// A dictionary with the data stored in the Settings plist.
    static var settingsData: NSDictionary?
    
    /**
     The *getSettingsData* function gets the data stored in the Settings plist as a dictionary and returns a value as an optional String.
     
     - Parameter key: specify the key for the expected returned value
     
     - Returns: A new String containing the value associated with the given Key that is found in the Settings plist.
     */
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
