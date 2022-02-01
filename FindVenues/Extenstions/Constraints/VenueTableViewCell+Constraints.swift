//
//  VenueTableViewCell+Constraints.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 31.01.2022.
//

import Foundation

extension VenuesTableViewCell {
    func setupConstraints() {
        venueName.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.height.equalTo(10)
        }
    }
}
