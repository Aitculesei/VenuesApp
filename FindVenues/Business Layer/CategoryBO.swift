//
//  CategoryBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.01.2022.
//

struct CategoryBO: Codable {
    let id: String?
    let name: String?

    init(venueCategoriesData: CategoryData) {
        self.id = venueCategoriesData.id
        self.name = venueCategoriesData.name
    }
}
