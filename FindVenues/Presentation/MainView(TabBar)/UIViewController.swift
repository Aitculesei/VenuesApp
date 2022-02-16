//
//  ViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SwiftSpinner
import CoreLocation

class TabBarViewController: UITabBarController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    private(set) var venuesVC: VenuesViewController!
    private(set) var rangeVC: RangeViewController!
    private(set) var homeVC: HomeViewController!
    private var tabBarViewModel: TabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarViewModel = TabBarViewModel()
        
        setupBindings()
        tabBarViewModel.sendAction(action: .loadData)
    }
}

extension TabBarViewController {
    private func setupBindings() {
        self.tabBarViewModel.state.bind { state in
            switch state{
            case .idle:
                print("Idle")
            case .loading:
                DispatchQueue.main.async {
                    SwiftSpinner.show("Getting the current location...")
                    SwiftSpinner.show(delay: 13.0, title: "It's taking a little longer than expected...")
                }
            case .loaded(let location):
                self.venuesVC = VenuesViewController()
                self.rangeVC = RangeViewController()
                self.homeVC = HomeViewController(location)
                self.createTabBarMenu()
                
                self.tabBarViewModel.sendAction(action: .reset)
            case .error(let error):
                DispatchQueue.main.async {
                    SwiftSpinner.show("Failed to load the current location. Using a custom location...", animated: false)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.venuesVC = VenuesViewController()
                    self.rangeVC = RangeViewController()
                    self.homeVC = HomeViewController()
                    self.createTabBarMenu()
                }
                
                self.tabBarViewModel.sendAction(action: .reset)
            }
        }
    }
}
