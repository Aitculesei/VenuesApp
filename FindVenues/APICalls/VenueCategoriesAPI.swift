//
//  VenueCategoriesAPI.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.01.2022.
//

import Foundation

// MARK: - Welcome
struct CategoriesDTO: Codable {
    let response: ResponseCategory
}


// MARK: - Response
struct ResponseCategory: Codable {
    let categories: [CategoryData]?
}

// MARK: - CategoryCategory
struct CategoryData: Codable {
    let categories: [CategoryData]
    let icon: Icon
    let id, name, pluralName, shortName: String
}
