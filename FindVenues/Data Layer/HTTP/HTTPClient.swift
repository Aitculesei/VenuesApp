//
//  HTTPClient.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 16.12.2021.
//

import Foundation

enum HTTPErrors: Error {
    case badRequest
    case noData
    case badData
}

class HTTPClient: HTTPClientProtocol {
    func get<T: Codable>(class: T.Type, url: String, parameters: [AnyHashable : String], headers: [AnyHashable : String]?, completion: @escaping (Result<T, HTTPErrors>) -> Void) {
        guard var urlComps = URLComponents(string: url) else {
            completion(.failure(.badRequest))
            return
        }
//        var urlComps = URLComponents()
        print("URL INITIAL COMPONENTS: \(urlComps)")
        // Set the URL parameters
//        urlComps.scheme = Constants.VenueSearchURL.scheme
//        urlComps.host = Constants.VenueSearchURL.host
//        urlComps.path = Constants.VenueSearchURL.path
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "client_id", value: "\(SettingsPlistParser.getSettingsData(forKey: "client_id") ?? "")"))
        queryItems.append(URLQueryItem(name: "client_secret", value: "\(SettingsPlistParser.getSettingsData(forKey: "client_secret") ?? "")"))
        for (key, value) in parameters {
            guard let name = key as? String else {
                print("HTTPClient error: Name for the URLQueryItem (key) is nil!")
                return
            }
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        urlComps.queryItems = queryItems
        
        print("URL COMPONENTS: \(urlComps)")
        
        guard let url = urlComps.url else {
            completion(.failure(.badRequest))
            return
        }
        
        print("URL AFTER COMPONENTS: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set the URL headers
        request.allHTTPHeaderFields = [
            "Accept" : "application/json"
        ]
        
        print("URL Headers: \(request.allHTTPHeaderFields)")
        
        let header: [String: String] = [:]
        if (headers as? [String: String]) == nil {
            print("HTTPClient: nil headers")
        } else {
            request.allHTTPHeaderFields?.merge(header, uniquingKeysWith: { current, _ in
                current
            })
        }
        
//        print("Final request: \(request)")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            // HERE WE MAKE SURE THAT WE GET SOME DATA BACK
            print("START THE URLSession!")
            guard let data = data, error == nil else {
                print("Something went wrong in creating a data task.")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
//            guard let httpResponse = response,
//            (200...299).contains((httpResponse as! HTTPURLResponse).statusCode) else {
//                print("HTTPClient: URLSession response error: \(response)")
//                return
//            }
            
            var dataResults: T?
            do {
                dataResults = try JSONDecoder().decode(T.self, from: data)
            }
            catch {
                print("Failed to convert data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
            }
            
            guard let json = dataResults else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(json))
            }
        })
        .resume()
//        dataTask.resume()
    }
}
