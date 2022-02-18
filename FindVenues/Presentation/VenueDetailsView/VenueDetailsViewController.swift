//
//  VenueDetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 06.01.2022.
//

import UIKit
import SwiftSpinner

class VenueDetailsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private(set) var venueDetailsViewModel = VenueDetailsViewModel()
    var receivedVenue: VenueDetailsBO?
    
    var venueDetailsCollectionView: UICollectionView!
    var venueDetailsView: UIView!
    var venueTitle: UILabel!
    var venuePhoto: UIImageView!
    var venueAddress: UILabel!
    var venuePhone: UILabel!
    var venueDistance: UILabel!
    
//    convenience init(_ receivedVenue: VenueDetailsBO?) {
//        self.init(nibName:nil, bundle:nil)
//
//        self.receivedVenue = receivedVenue
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = receivedVenue?.venueBO else {
            fatalError("Venue details are missing / Venue is missing.")
        }
        self.title = venue.name
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createCollectionView()
        populateWithData()
        venueDetailsViewModel.sendAction(action: .loadData)
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
        
        venuePhoto = self.getVenueImageView(link: receivedVenue?.photo)
        
        // Adding single and double tap gestures
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        venuePhoto.addGestureRecognizer(tapGR)
        let doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageDoubleTapped(_:)))
        doubleTapGR.numberOfTapsRequired = 2
        venuePhoto.addGestureRecognizer(doubleTapGR)
        
        venueDetailsView.addSubview(venuePhoto)
    }
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        venueDetailsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        venueDetailsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.venueDetailsViewIdentifier)
        venueDetailsCollectionView.backgroundColor = UIColor.white
        
        venueDetailsCollectionView.dataSource = self
        venueDetailsCollectionView.delegate = self
        
        self.view.addSubview(venueDetailsCollectionView)
    }
}

// MARK: - Functions for building views

extension VenueDetailsViewController {
    func getTitleView() -> UILabel {
        let venueTitle = UILabel()
//        guard let venue = receivedVenue?.venueBO else {
//            fatalError("Venue details are missing / Venue is missing.")
//        }
//        venueTitle.text = venue.name
        
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

// MARK: - Storyboarded

extension VenueDetailsViewController: Storyboarded {
    
}

// MARK: - Setting up the bindings

extension VenueDetailsViewController {
    private func setupBindings() {
        self.venueDetailsViewModel.state.bind { state in
            switch state{
            case .idle:
                // Hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
            case .loading:
                // Show spinner
                DispatchQueue.main.async {
                    SwiftSpinner.show("Loading venue details...")
                    SwiftSpinner.show(delay: 3.0, title: "It's taking a little longer than expected...")
                }
            case .loaded:
                // hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
                self.venueDetailsViewModel.sendAction(action: .reset)
            case .error(let error):
                //show error
                DispatchQueue.main.async {
                    SwiftSpinner.show("Failed to load the venue!", animated: false)
                }
                
                self.venueDetailsViewModel.sendAction(action: .reset)
            }
        }
    }
}
