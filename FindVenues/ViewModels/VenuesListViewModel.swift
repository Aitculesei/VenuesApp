//
//  VenuesListViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit

class VenuesListViewModel: NSObject {
    private var repo: VenueRepository!
    var receivedVenues: [VenueDetailsBO] = []
    
    override init() {
        super.init()
        
        repo = VenueRepository()
        repo.getVenues { result in
            switch result {
            case .success(let venuesBO):
                for venue in venuesBO {
                    guard let venueID = venue.id else {
                        fatalError("Venue id found nil!")
                    }
                    
                    self.repo.getVenuePhotos(venueID: venueID) { result in
                        switch result {
                        case .success(let venuePhotos):
                            if venuePhotos.isEmpty {
                                self.receivedVenues.append(VenueDetailsBO(venueBO: venue, photo: nil))
                            } else {
                                self.receivedVenues.append(VenueDetailsBO(venueBO: venue, photo: venuePhotos[0].photo!))
                            }
                        case .failure(let error):
                            print("Thrown error when we received venue photos. \(error)")
                        }
                    }
                }
            case .failure(let error):
                print("VenuesListVM: Something is baaad with getting the venues \(error)")
            }
        }
    }
    
    func createTableView() -> UITableView {
        let venuesTableView = UITableView()
        
        venuesTableView.backgroundColor = .white
        venuesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.TableViewCell.identifier)
        
        return venuesTableView
    }
}
