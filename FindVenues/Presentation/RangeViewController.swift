//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class RangeViewController: UIViewController, UITextFieldDelegate {
    let button = UIButton(frame: CGRect(x: 100,
                                        y: 100,
                                        width: 200,
                                        height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        button.setTitle("food", for: .normal)
        button.addTarget(self, action: #selector(saveQuery), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func saveQuery() {
        if let query = button.currentTitle {
            LocalDataManager.saveData(data: query, key: Constants.LocalDataManagerSavings.queryKey)
        }
        TabBarViewController().reloadInputViews()
    }
}
