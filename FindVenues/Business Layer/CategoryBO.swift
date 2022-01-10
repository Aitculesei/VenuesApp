//
//  CategoryBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.01.2022.
//

import UIKit

struct CategoryBO: Codable {
    let id: String?
    let name: String?
    let icon: String?

    init(venueCategoriesData: CategoryData) {
        self.id = venueCategoriesData.id
        self.name = venueCategoriesData.name
        guard let prefix = venueCategoriesData.icon.mapPrefix, let suffix = venueCategoriesData.icon.suffix else {
            fatalError("Icon URL is missing!")
        }
        self.icon = "\(prefix)\(suffix)"
    }
}
