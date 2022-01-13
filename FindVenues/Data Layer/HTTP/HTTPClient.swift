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
        
        // Set the URL parameters
        var queryItems = [URLQueryItem]()

        queryItems.append(Constants.API.Client.id)
        queryItems.append(Constants.API.Client.secret)

        for (key, value) in parameters {
            guard let name = key as? String else {
                print("HTTPClient error: Name for the URLQueryItem (key) is nil!")
                return
            }
            let queryItem = URLQueryItem(name: name, value: value)
            queryItems.append(queryItem)
        }
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else {
            completion(.failure(.badRequest))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set the URL headers
        request.allHTTPHeaderFields = [
            "Accept" : "application/json",
            "cookie" : Constants.API.stupidCookie
        ]
        
        if let headers = headers as? [String: String] {
            request.allHTTPHeaderFields?.merge(headers, uniquingKeysWith: { current, _ in
                current
            })
        } else {
            print("HTTPClient: nil headers")
        }
        
        print("URL=\(url)")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong in creating a data task.")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            var dataResults: T?
            do {
                let decoder = JSONDecoder()
                dataResults = try decoder.decode(T.self, from: data)
            }
            catch {
                print("Failed to convert data: \(error)")
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
    }
}
