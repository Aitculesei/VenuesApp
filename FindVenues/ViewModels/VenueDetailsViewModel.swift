//
//  VenueDetailsViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit

class VenueDetailsViewModel: NSObject {
    var receivedVenue: VenueDetailsBO?
    
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
    
    func getTitleView() -> UILabel {
        let venueTitle = UILabel()
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        venueTitle.text = venue.name
        
        return venueTitle
    }
    
    func getAddressView() -> UILabel {
        let venueAddress = UILabel()
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        guard var location = venue.location else {
            fatalError("Address cannot be missing.")
        }
        if location == "" {
            location = "<don't have a location specified>"
        }
        venueAddress.text = "📍 \(location)"
        
        return venueAddress
    }
    
    func getPhoneView() -> UILabel {
        let venuePhone = UILabel()
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        let phone: String
        if venue.phone == nil {
            phone = "<don't have a specified phone number>"
        } else {
            phone = venue.phone!
        }
        venuePhone.text = "☎️ \(phone)"
        
        return venuePhone
    }
    
    func getDistanceView() -> UILabel {
        let venueDistance = UILabel()
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        guard let distance = venue.distance else {
            fatalError("Distance cannot be nil.")
        }
        let convertedDistance = (Float(distance) / 1000)
        venueDistance.text = "\(NSString(format: "%.01f", convertedDistance)) km from the current location"
        
        return venueDistance
    }
    
    func getVenueImageView() -> UIImageView {
        let link = receivedVenue?.photo
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
