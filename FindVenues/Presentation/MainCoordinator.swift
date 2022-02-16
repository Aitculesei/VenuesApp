//
//  MainCoordinator.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 15.02.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var nav: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.nav = navigationController
    }
    
    func start() {
        let vc = TabBarViewController.instantiate()
        vc.coordinator = self
        nav.pushViewController(vc, animated: false)
    }
    
    func showDetails(data: VenueDetailsBO) {
        let vc = VenueDetailsViewController.instantiate()
        vc.receivedVenue = data
        vc.coordinator = self
        nav.pushViewController(vc, animated: true)
    }
}
