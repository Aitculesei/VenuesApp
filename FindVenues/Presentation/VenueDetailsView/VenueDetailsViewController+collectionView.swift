//
//  VenueDetailsViewController+collectionView.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 25.01.2022.
//

import UIKit
import SnapKit

extension VenueDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.venueDetailsViewIdentifier, for: indexPath) as? UICollectionViewCell else {
            fatalError("Venue Details Collection View cell could not be created.")
        }
        cell.contentView.addSubview(venueDetailsView)
        setupConstraints()
        
        return cell
    }
}

extension VenueDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}

