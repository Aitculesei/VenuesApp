//
//  Coordinator.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 14.02.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var nav: UINavigationController { get set } //PUSH & POP views
    
    func start()
}
