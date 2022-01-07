//
//  VenueDetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 06.01.2022.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    let venueTitle = UILabel()
    let venuePhoto = UIImageView()
    let venueAddress = UILabel()
    let venuePhone = UILabel()
    let venueDistance = UILabel()
    var receivedVenue: VenueBO? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = receivedVenue else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        guard let location = venue.location else {
            fatalError("Address is missing.")
        }
        guard let phone = venue.phone else {
            fatalError("Phone number is missing.")
        }
        guard let distance = venue.distance else {
            fatalError("Distance cannot be nil.")
        }
        let convertedDistance = (Float(distance) / 1000)
        
        venueTitle.text = venue.name
        venueAddress.text = "📍 \(location)"
        venuePhone.text = "☎️ \(phone)"
        venueDistance.text = "\(convertedDistance) km from the current location"
        
        buildVenueDetailsView()
    }
    
    func buildVenueDetailsView() {
        venueTitle.frame = CGRect(origin: CGPoint(x: 100, y: 65), size: CGSize(width: 400, height: 21))
        view.addSubview(venueTitle)
        
        venuePhoto.frame = CGRect(origin: CGPoint(x: 20, y: 95), size: CGSize(width: 800, height: 400))
        view.addSubview(venuePhoto)
        
        venueAddress.frame = CGRect(origin: CGPoint(x: 23, y: 510), size: CGSize(width: 400, height: 21))
        view.addSubview(venueAddress)
        
        venuePhone.frame = CGRect(origin: CGPoint(x: 23, y: 540), size: CGSize(width: 400, height: 21))
        view.addSubview(venuePhone)
        
        venueDistance.frame = CGRect(origin: CGPoint(x: 23, y: 570), size: CGSize(width: 400, height: 21))
        view.addSubview(venueDistance)
    }
}
