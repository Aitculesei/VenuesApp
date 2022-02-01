//
//  VenuesTableViewCell.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 21.12.2021.
//

import UIKit
import SnapKit

class VenuesTableViewCell: UITableViewCell {
    var venueName: UILabel = {
        let label = UILabel()
        label.text = "default"
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
