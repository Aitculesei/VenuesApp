//
//  VenuePhotoDetailsBO.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.01.2022.
//

import SwiftUI

struct VenuePhotoDetailsBO: Codable {
    let id: String?
    let photo: String?
    
    init(venueID: String?, venueDetailsAPIData: BestPhoto?) {
        self.id = venueID
        if venueDetailsAPIData != nil {
            self.photo = venueDetailsAPIData!.prefix + "\(Constants.API.Photo.dimensions)" + venueDetailsAPIData!.suffix
        } else {
            self.photo = nil
        }
    }
}
