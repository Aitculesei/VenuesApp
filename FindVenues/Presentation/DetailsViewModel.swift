//
//  DetailsViewModel.swift
//  FindVenues
//
//  Created by Taras, Alexandru on 31.01.2022.
//

import Foundation

protocol ViewModel {
    associatedtype T
    associatedtype U

    var state: Bindable<T> { get set }

    func sendAction(action: U)
}

class DetailsViewModel: ViewModel {

    typealias T = State
    typealias U = Actions

    enum State {
        case idle
        case loading
        case loaded(results: [VenueBO])
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
                self.repository.getVenues { result in
                    switch result {
                    case .failure(let error):
                        self.state.value = .error(error: error)
                    case .success(let data):
                        self.state.value = .loaded(results: data)
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

    private let repository = VenueRepository()
}
