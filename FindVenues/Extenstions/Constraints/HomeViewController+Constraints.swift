//
//  HomeViewController+Constraints.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 25.01.2022.
//

import Foundation

extension HomeViewController {
    func setupConstraints() {
        venuesMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
