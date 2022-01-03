//
//  LocalDataManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import Foundation

/// Responsible for managing the data locally: *Store*, *Load*, *Reset*
class LocalDataManager {
    
    /**
     The *saveData* function is responsible for **Encoding**, **Storing locally** at a given key and **Synchronizing** the currently existing data.
     
     - Parameters:
        - data: exactly what we want to encode and store. Generic type
        - key: the specified key where the given data will be stored. String type
     */
    static func saveData<T: Codable>(data: T, key: String) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("Cannot be encoded \(error)")
        }
    }
    
    /**
     The *loadData* function is responsible for **Decoding** and  **Returning** the  data found at the specified key that is stored locally.
     
     - Parameters:
        - key: the specified key where the given data will be stored. String type
        - type: specifies the type that is expected to be returned
     
     - Precondition: at the specified Key there must be some data stored. Cannot be nil.
     
     - Returns: nil / the data decoded that is found to be stored locally at the specified Key.
     */
    static func loadData<T: Codable>(key: String, type: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            print("Cannot be decoded")
        }
        
        return nil
    }
    
    /**
     The *resetData* function is responsible for **Resetting** all the locally stored data and also **Synchronizing** the currently existing data (none).
     */
    static func resetData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
