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
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "venuesTableCell")
        
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
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    // Rearrange the table view
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let toDoListAppDestinationElement = toDoListAppElements[sourceIndexPath.row]
//        toDoListAppElements.remove(at: sourceIndexPath.row)
//        toDoListAppElements.insert(toDoListAppDestinationElement, at: destinationIndexPath.row)
//        LocalDataManager.saveData(data: toDoListAppElements, key: "listElements")
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//
//            toDoListAppElements.remove(at: indexPath.row)
//            toDoListTableView.deleteRows(at: [indexPath], with: .fade)
//            LocalDataManager.saveData(data: toDoListAppElements, key: "listElements")
//
//            tableView.endUpdates()
//        } else if editingStyle == .insert {
//
//        }
//    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = venuesTableView.dequeueReusableCell(withIdentifier: "venuesTableCell", for: indexPath) as? VenuesTableViewCell else {
            fatalError("Unable to determine Venues Table View Cell.")
        }
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.venuesListTableView.count
//    }
//
//    // By default you cannot move rows
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        true
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = venuesTableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as? VenuesTableViewCell else {
//            fatalError("Unable to determine ReminderCell.")
//        }
//
//
//        return cell
//    }
}
