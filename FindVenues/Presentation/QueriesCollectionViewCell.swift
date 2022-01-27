//
//  QueriesCollectionViewCell.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 22.12.2021.
//

import UIKit

class QueriesCollectionViewCell: UICollectionViewCell {
    var categoryIcon: UIImage?
    let imageview = UIImageView()
    let loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.style = .large
        indicator.color = .blue
            
        // The indicator should be animating when
        // the view appears.
        indicator.startAnimating()
            
        // Setting the autoresizing mask to flexible for all
        // directions will keep the indicator in the center
        // of the view and properly handle rotation.
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
    let button = UIButton()
    let categoryLabel = UILabel()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
