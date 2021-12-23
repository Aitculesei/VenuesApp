//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    let venuesTableView: UITableView = {
        let venuesTableView = UITableView()
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        
        return venuesTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        venuesTableView.backgroundColor = .lightGray
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        view.addSubview(venuesTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        venuesTableView.frame = view.bounds
    }

}

// MARK: - Extensions

// Delegate is used to handle interactions of cells
extension DetailsViewController: UITableViewDelegate {
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = venuesTableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.identifier, for: indexPath) as? UITableViewCell else {
            fatalError("Unable to determine Venues Table View Cell.")
        }
        
        
        return cell
    }
}
