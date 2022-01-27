//
//  VenueDetailsViewController+Constraints.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 25.01.2022.
//

import Foundation

extension VenueDetailsViewController {
    func setupConstraints() {
        venueDetailsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        venueDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        venueTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
        }
        
        venuePhoto.snp.makeConstraints { make in
            make.top.equalTo(venueTitle.snp.bottom).offset(25)
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(325)
        }
        
        venueAddress.snp.makeConstraints { make in
            make.top.equalTo(venuePhoto.snp.bottom).offset(25)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        venuePhone.snp.makeConstraints { make in
            make.top.equalTo(venueAddress.snp.bottom).offset(5)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        venueDistance.snp.makeConstraints { make in
            make.top.equalTo(venuePhone.snp.bottom).offset(5)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
    }
}
