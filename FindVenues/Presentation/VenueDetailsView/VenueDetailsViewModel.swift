//
//  VenueDetailsViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit

class VenueDetailsViewModel: NSObject {
    override init() {
        super.init()
    }
    
    func getVenueDetailsCollectionView(frame: CGRect) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let venueDetailsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        venueDetailsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.venueDetailsViewIdentifier)
        venueDetailsCollectionView.backgroundColor = UIColor.white
        
        return venueDetailsCollectionView
    }
    
    func getVenueImageView(link: String?) -> UIImageView {
        let venuePhoto = UIImageView()
        if let venuePhotoURL = link {
            var venueImage: UIImage?
            venuePhoto.downloaded(from: venuePhotoURL) { image in
                venueImage = image
            }
            venueImage = venueImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            venuePhoto.image = venueImage
            
            venuePhoto.isUserInteractionEnabled = true
        } else {
            venuePhoto.image = UIImage() // Placeholder
        }
        
        return venuePhoto
    }
}
