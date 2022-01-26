//
//  VenueDetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 06.01.2022.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    var venueDetailsCollectionView: UICollectionView!
    let venueDetailsView = UIView()
    let venueTitle = UILabel()
    let venuePhoto = UIImageView()
    let venueAddress = UILabel()
    let venuePhone = UILabel()
    let venueDistance = UILabel()
    var receivedVenue: VenueDetailsBO? {
        didSet {
            self.populateWithData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildVenueDetailsView()
    }
    
    func populateWithData() {
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        guard var location = venue.location else {
            fatalError("Address cannot be missing.")
        }
        guard let distance = venue.distance else {
            fatalError("Distance cannot be nil.")
        }
        
        uploadPhoto(link: self.receivedVenue?.photo)
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
    }
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        venueDetailsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        venueDetailsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.venueDetailsViewIdentifier)
        venueDetailsCollectionView.backgroundColor = .white
        
        venueDetailsCollectionView.dataSource = self
        venueDetailsCollectionView.delegate = self
        
        self.view.addSubview(venueDetailsCollectionView)
    }
    
    func uploadPhoto(link: String?) {
        if let venuePhotoURL = link {
            var venueImage: UIImage?
            venuePhoto.downloaded(from: venuePhotoURL) { image in
                venueImage = image
            }
            venueImage = venueImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            venuePhoto.image = venueImage
            
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
            venuePhoto.addGestureRecognizer(tapGR)
            venuePhoto.isUserInteractionEnabled = true
        } else {
            venuePhoto.image = UIImage() // Placeholder
        }
    }
    
    func buildVenueDetailsView() {
        createCollectionView()
        
        venueDetailsView.addSubview(venueTitle)
        venueDetailsView.addSubview(venuePhoto)
        venueDetailsView.addSubview(venueAddress)
        venueDetailsView.addSubview(venuePhone)
        venueDetailsView.addSubview(venueDistance)
    }
}

// MARK: - Objective C functions

extension VenueDetailsViewController {
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("Image tapped")
            sender.view?.snp.makeConstraints({ make in
                make.width.equalToSuperview()
            })
        }
    }
}
