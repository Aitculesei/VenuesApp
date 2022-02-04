//
//  ViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 04.02.2022.
//

import Foundation

protocol ViewModel {
    associatedtype T
    associatedtype U

    var state: Bindable<T> { get set }

    func sendAction(action: U)
}
