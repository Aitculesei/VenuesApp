//
//  VenueDetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 06.01.2022.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    private(set) var venueDetailsViewModel = VenueDetailsViewModel()
    var receivedVenue: VenueDetailsBO?
    
    var venueDetailsCollectionView: UICollectionView!
    var venueDetailsView: UIView!
    var venueTitle: UILabel!
    var venuePhoto: UIImageView!
    var venueAddress: UILabel!
    var venuePhone: UILabel!
    var venueDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createCollectionView()
        populateWithData()
    }
    
    func populateWithData() {
        venueDetailsView = UIView()
        
        venueTitle = self.getTitleView()
        venueDetailsView.addSubview(venueTitle)
        
        venueAddress = self.getAddressView()
        venueDetailsView.addSubview(venueAddress)
        
        venuePhone = self.getPhoneView()
        venueDetailsView.addSubview(venuePhone)
        
        venueDistance = self.getDistanceView()
        venueDetailsView.addSubview(venueDistance)
        
        venuePhoto = venueDetailsViewModel.getVenueImageView(link: receivedVenue?.photo)
        
        // Adding single and double tap gestures
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        venuePhoto.addGestureRecognizer(tapGR)
        let doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageDoubleTapped(_:)))
        doubleTapGR.numberOfTapsRequired = 2
        venuePhoto.addGestureRecognizer(doubleTapGR)
        
        venueDetailsView.addSubview(venuePhoto)
    }
    
    func createCollectionView() {
        venueDetailsCollectionView = venueDetailsViewModel.getVenueDetailsCollectionView(frame: self.view.frame)
        
        venueDetailsCollectionView.dataSource = self
        venueDetailsCollectionView.delegate = self
        
        self.view.addSubview(venueDetailsCollectionView)
    }
}

// MARK: - Functions for building views

extension VenueDetailsViewController {
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
}

// MARK: - Objective C functions

extension VenueDetailsViewController {
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            sender.view?.snp.remakeConstraints({ make in
                make.edges.equalToSuperview()
                make.bottom.equalTo(venueAddress.snp.top).offset(125)
            })
        }
    }
    
    @objc func imageDoubleTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            sender.view?.snp.remakeConstraints({ make in
                make.top.equalTo(venueTitle.snp.bottom).offset(25)
                make.trailing.leading.equalToSuperview().inset(10)
                make.height.equalTo(400)
            })
        }
    }
}
