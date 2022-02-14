//
//  TabBarViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 10.02.2022.
//

import Foundation
import CoreLocation

class TabBarViewModel: NSObject {
    
    typealias T = State
    typealias U = Actions

    enum State {
        case idle
        case loading
        case loaded(location: CLLocation)
        case error(error: Error)
    }

    enum Actions {
        case loadData
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
                
                LocationManagerClass.shared.getUserLocation { [weak self] location in
                    DispatchQueue.main.async {
                        guard let strongSelf = self else {
                            return
                        }
                        
                        strongSelf.state.value = .loaded(location: location)
                    }
                }
            default:
                self.state.value = .idle
            }
        case .loading:
            switch action {
            case .loadData:
                print("+++ Unsupported state transition")
            default:
                self.state.value = .idle
            }
        case .loaded:
            switch action {
            case .loadData:
                print("+++ Unsupported state transition")
            default:
                self.state.value = .idle
            }
        case .error:
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
