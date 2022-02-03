//
//  Bindable.swift
//  FindVenues
//
//  Created by Taras, Alexandru on 31.01.2022.
//

import Foundation

class Bindable<T> {

    var value: T {
        didSet {
            observer?(value)
        }
    }

    init(value: T) {
        self.value = value
    }

    private var observer: ((T) -> ())?

    func bind(observer: @escaping (T) -> ()) {
        self.observer = observer
    }
}
