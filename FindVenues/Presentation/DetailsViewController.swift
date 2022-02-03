//
//  DetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    lazy var venuesTableView: UITableView = {
        let venuesTableView = UITableView()
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        
        return venuesTableView
    }()

    let viewModel = DetailsViewModel()

    private var venues: [VenueBO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        venuesTableView.backgroundColor = .lightGray
        venuesTableView.delegate = self
        venuesTableView.dataSource = self
        view.addSubview(venuesTableView)

        self.setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.sendAction(action: .loadData)
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
        self.venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = venuesTableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.identifier) else {
            fatalError("Unable to determine Venues Table View Cell.")
        }

        if let venues = self.venues  {
            cell.textLabel?.text = venues[indexPath.row].name
        }
        
        return cell
    }
}

extension DetailsViewController {

    private func setupBindings() {
        self.viewModel.state.bind { state in
            switch state {
            case .idle:
                // hide spinner
                print("idle.")
            case .loading:
                // show spinner
                print("loading...")
            case .loaded(let data):
                self.venues = data
                self.venuesTableView.reloadData()
                // hide spinner
                self.viewModel.sendAction(action: .reset)
            case .error(let error):
                //show error
                self.viewModel.sendAction(action: .reset)
                print("error \(error.localizedDescription)")
            }
        }
    }
}
