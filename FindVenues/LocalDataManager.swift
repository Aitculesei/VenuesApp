//
//  LocalDataManager.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import Foundation

class LocalDataManager {
    
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
    
    static func resetData() {
        print("Before RESET: \(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)")
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print("After RESET: \(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)")
    }
}
