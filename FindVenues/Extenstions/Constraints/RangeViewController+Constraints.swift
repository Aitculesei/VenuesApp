//
//  RangeViewController+Constraints.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 20.01.2022.
//

import UIKit
import SnapKit

extension RangeViewController {
    func setupConstraints() {
        buttonsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rangeSelectorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }

        checkboxView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(rangeSelectorView.snp.bottom).offset(50)
            make.height.equalTo(35)
        }

        resetButton.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
    
//    override func willTransition(
//        to newCollection: UITraitCollection,
//        with coordinator: UIViewControllerTransitionCoordinator
//    ) {
//        super.willTransition(to: newCollection, with: coordinator)
//        let isPortrait = UIDevice.current.orientation.isPortrait
//
//        rangeSelectorView.snp.updateConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//
//        // 3
//        lblTimer.font = UIFont.systemFont(ofSize: isPortrait ? 20 : 32, weight: .light)
//    }
}
