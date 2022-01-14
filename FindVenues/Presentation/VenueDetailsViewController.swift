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
//    var receivedVenue: VenueBO? {
//        didSet {
//            self.viewDidLoad()
//        }
//    }
    var receivedVenue: VenueDetailsBO? {
        didSet {
            self.viewDidLoad()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        guard var location = venue.location else {
            fatalError("Address cannot be missing.")
        }
        guard let distance = venue.distance else {
            fatalError("Distance cannot be nil.")
        }
        let phone: String
        if venue.phone == nil {
            phone = "<don't have a specified phone number>"
        } else {
            phone = venue.phone!
        }
        let convertedDistance = (Float(distance) / 1000)
        if location == "" {
            location = "<don't have a location specified>"
        }
        
        venueTitle.text = venue.name
        venueAddress.text = "📍 \(location)"
        venuePhone.text = "☎️ \(phone)"
        venueDistance.text = "\(NSString(format: "%.01f", convertedDistance)) km from the current location"
        
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
