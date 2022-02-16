//
//  TabBarViewController+createTabBarMenu.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 28.01.2022.
//

import UIKit

extension TabBarViewController {
    func createTabBarMenu() {
        homeVC.title = "Home"
        rangeVC.title = "Distance"
        venuesVC.title = "Venues"
        
        homeVC.coordinator = self.coordinator
        venuesVC.coordinator = self.coordinator
        
        // Assign VC to Tab bar controller
        self.setViewControllers([homeVC, rangeVC, venuesVC], animated: false)
        
        guard let items = self.tabBar.items else {return}
        let images = ["house", "slider.horizontal.3", "list.bullet.rectangle.portrait.fill"]
        
        for (index, item) in items.enumerated() {
            item.image = UIImage(systemName: images[index])
        }
        
        // Change tint color
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}
