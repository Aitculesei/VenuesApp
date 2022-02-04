//
//  RangeViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit
import SnapKit
import SimpleCheckbox

class RangeViewModel: ViewModel {
    var collectionViewHeightConstraint: Constraint?
    private var rangeLabel = UILabel()
    var rangeSelector = UISlider()
    var showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    
    typealias T = State
    typealias U = Actions

    enum State {
        case idle
        case loading
        case loaded(results: [CategoryBO], currentRangeSelectorValue: Float)
        case error(error: Error)
    }

    enum Actions {
        case loadData
        case checkCurrentLocationCheckbox(_ sender: SimpleCheckbox.Checkbox)
        case setRange(_ sender: UISlider)
        case resetEntireView(_ minimumRangeValue: Float)
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
                self.repo.getCategories { result in
                    switch result {
                    case .success(let categoriesBO):
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.state.value = .loaded(results: categoriesBO, currentRangeSelectorValue: LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.rangeValueKey, type: Float.self) ?? 1)
                        }
                    case .failure(let error):
                        self.state.value = .error(error: error)
                    }
                }
            case .checkCurrentLocationCheckbox(let sender):
                self.state.value = .idle
                LocationManagerClass.isCurrentLocationON = sender.isChecked
            case .setRange(let sender):
                self.state.value = .idle
                LocalDataManager.saveData(data: sender.value, key: Constants.LocalDataManagerSavings.rangeValueKey)
            case .resetEntireView(let minimumRangeValue):
                self.state.value = .idle
                LocalDataManager.saveData(data: minimumRangeValue, key: Constants.LocalDataManagerSavings.rangeValueKey)
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
