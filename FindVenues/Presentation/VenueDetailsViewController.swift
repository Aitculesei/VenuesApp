//
//  VenueDetailsViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 06.01.2022.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    private(set) var venueDetailsViewModel = VenueDetailsViewModel()
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
        
        venueTitle = venueDetailsViewModel.getTitleView()
        venueDetailsView.addSubview(venueTitle)
        
        venueAddress = venueDetailsViewModel.getAddressView()
        venueDetailsView.addSubview(venueAddress)
        
        venuePhone = venueDetailsViewModel.getPhoneView()
        venueDetailsView.addSubview(venuePhone)
        
        venueDistance = venueDetailsViewModel.getDistanceView()
        venueDetailsView.addSubview(venueDistance)
        
        venuePhoto = venueDetailsViewModel.getVenueImageView()
        venueDetailsView.addSubview(venuePhoto)
    }
    
    func createCollectionView() {
        venueDetailsCollectionView = venueDetailsViewModel.getVenueDetailsCollectionView(frame: self.view.frame)
        
        venueDetailsCollectionView.dataSource = self
        venueDetailsCollectionView.delegate = self
        
        self.view.addSubview(venueDetailsCollectionView)
    }
}
