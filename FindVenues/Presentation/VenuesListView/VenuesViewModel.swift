//
//  VenuesViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.02.2022.
//

import Foundation
import CoreLocation

class VenuesViewModel: ViewModel {
    
    typealias T = State
    typealias U = Actions

    enum State {
        case idle
        case loading
        case loaded(results: [VenueDetailsBO])
//        case venueImageLoaded(image: UIImage)
        case error(error: Error)
    }

    enum Actions {
        case loadData
//        case getAnnotationImage(link: String)
        case reset
    }

    var state: Bindable<State> = Bindable<State>(value: State.idle)

    func sendAction(action: Actions) {
        transition(action: action)
    }

    private func transition(action: Actions) {
        switch self.state.value {
        case .idle:
            switch action {
            case .loadData:
                self.state.value = .loading
                self.repo.getVenues { result in
                    switch result {
                    case .success(let venuesBO):
                        var venuesWithPhotos: [VenueDetailsBO] = []
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
//                                    fatalError("Thrown error when we received venue photos. \(error)")
                                    self.state.value = .error(error: error)
                                }
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.state.value = .loaded(results: venuesWithPhotos)
                        }
                    case .failure(let error):
                        print("VenuesListVM: Something is baaad with getting the venues \(error)")
                    }
                }
//            case .getAnnotationImage(let link):
//                self.state.value = .loading
//                UIImageView().downloaded(from: link) { image in
//                    guard let image = image else {
//                        fatalError("Missing an image url!")
//                    }
//
//                    self.state.value = .venueImageLoaded(image: image)
//                }
            default:
                self.state.value = .idle
            }
        default:
            switch action {
            case .loadData:
                print("+++ Unsupported state transition")
            default:
                self.state.value = .idle
            }
        }
    }

    private let repo = VenueRepository()
}
