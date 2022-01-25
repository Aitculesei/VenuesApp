//
//  VenuesViewController+Constraints.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 25.01.2022.
//

import Foundation

extension VenuesViewController {
    func setupConstraints() {
        venuesTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
