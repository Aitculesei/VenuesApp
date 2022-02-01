//
//  VenueViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 01.02.2022.
//

import Foundation

class VenuesViewModel: NSObject {
    private var repo: VenueRepository!
    
    override init() {
        super.init()
        
        self.repo = VenueRepository()
    }
    
    func getVenuesV(completion: @escaping ([VenueBO], [VenueDetailsBO]) -> Void) {
        repo.getVenues { result in
            switch result {
            case .success(let venuesBO):
                var venuesWithPhotos = [VenueDetailsBO]()
                for venue in venuesBO {
                    guard let venueID = venue.id else {
                        fatalError("Venue id found nil!")
                    }
                    
                    self.repo.getVenuePhotos(venueID: venueID) { result in
                        switch result {
                        case .success(let venuePhotos):
                            if venuePhotos.isEmpty {
                                venuesWithPhotos.append(VenueDetailsBO(venueBO: venue, photo: nil))
                            } else {
                                venuesWithPhotos.append(VenueDetailsBO(venueBO: venue, photo: venuePhotos[0].photo!))
                            }
                        case .failure(let error):
                            print("Thrown error when we received venue photos. \(error)")
                        }
                    }
                }
                completion(venuesBO, venuesWithPhotos)
            case .failure(let error):
                print("Something is baaad with getting the venues \(error)")
            }
        }
    }
    
    func getCategories(completion: @escaping ([CategoryBO]) -> Void) {
        repo.getCategories { result in
            switch result {
            case .success(let categoriesBO):
                completion(categoriesBO)
            case .failure(let error):
                print("Categories got a problem \(error)")
            }
        }
    }
}
