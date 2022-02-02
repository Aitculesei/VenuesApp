//
//  RangeViewModel.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 02.02.2022.
//

import Foundation
import UIKit
import SnapKit
import SimpleCheckbox

class RangeViewModel: NSObject {
    private var repo: VenueRepository!
    private var queriesCollectionView: UICollectionView!
    var collectionViewHeightConstraint: Constraint?
    private var rangeLabel = UILabel()
    var rangeSelector = UISlider()
    var showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    private(set) var queriesDataSource: [CategoryBO] = []
    
    override init() {
        super.init()
        
        repo = VenueRepository()
        repo.getCategories { result in
            switch result {
            case .success(let categoriesBO):
                self.queriesDataSource = categoriesBO
            case .failure(let error):
                print("Categories got a problem \(error)")
            }
        }
    }
    
    func createCollectionView(frame: CGRect) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        queriesCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        queriesCollectionView.register(QueriesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier)
        queriesCollectionView.backgroundColor = .white
        
        return queriesCollectionView
    }
    
    func getRangeSelectorView() -> UIView {
        let rangeSelectorView = UIView()
        
        // ADDING THE LABEL FOR THE RANGE SLIDER TITLE
        let rangeSliderTitle = UILabel()
        rangeSliderTitle.textAlignment = .left
        rangeSliderTitle.text = "Range"
        
        rangeSelectorView.addSubview(rangeSliderTitle)
        
        rangeSliderTitle.snp.makeConstraints { make in
            make.top.width.equalToSuperview() // deleted .leading because of the .width
            make.height.equalTo(21)
        }
        
        // ADDING THE RANGE SLIDER (SELECTOR)
        rangeSelector.isUserInteractionEnabled = true
        rangeSelectorView.addSubview(rangeSelector)
        
        rangeSelector.snp.makeConstraints { make in
            make.top.equalTo(rangeSliderTitle.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        rangeSelector.minimumValue = 1
        rangeSelector.maximumValue = 5
        rangeSelector.isContinuous = false
        rangeSelector.tintColor = .blue
        rangeSelector.value = LocalDataManager.loadData(key: Constants.LocalDataManagerSavings.rangeValueKey, type: Float.self) ?? 1
        rangeSelector.addTarget(self, action: #selector(updateSelectedRangeLabel(_:)), for: .valueChanged)
        
        rangeLabel.text = "\(rangeSelector.value) km"
        
        // ADDING THE LABEL FOR THE SELECTED RANGE VALUE
        rangeSelectorView.addSubview(rangeLabel)
        
        rangeLabel.isUserInteractionEnabled = true
        rangeLabel.snp.makeConstraints { make in
            make.top.equalTo(rangeSelector.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(21)
        }
        
        rangeSelectorView.translatesAutoresizingMaskIntoConstraints = false
        
        return rangeSelectorView
    }
    
    func saveRangeValueLocally() {
        LocalDataManager.saveData(data: rangeSelector.value, key: Constants.LocalDataManagerSavings.rangeValueKey)
    }
    
    func getShowCurrentLocationCheckbox() -> UIView {
        let checkboxView = UIView()
        // CREATE THE CHECKBOX
        checkboxView.addSubview(showCurrentLocationCheckBox)
        
        showCurrentLocationCheckBox.checkmarkStyle = .tick
        showCurrentLocationCheckBox.borderStyle = .square
        showCurrentLocationCheckBox.emoji = "✅"
        showCurrentLocationCheckBox.snp.makeConstraints { make in
            make.top.leading.height.equalToSuperview()
            make.width.equalTo(35)
        }
        showCurrentLocationCheckBox.addTarget(self, action: #selector(checkBoxValueDidChange(_:)), for: .valueChanged)
        
        // CREATE CHECKBOX LABEL
        let checkBoxLabel = UILabel()
        checkboxView.addSubview(checkBoxLabel)
        
        checkBoxLabel.text = "Show current location on map"
        
        checkBoxLabel.snp.makeConstraints { make in
            make.top.height.equalToSuperview()
            make.leading.equalTo(showCurrentLocationCheckBox.snp.trailing).offset(10)
        }
        
        return checkboxView
    }
    
    func getResetButton() -> UIButton {
        let resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitle("Release", for: .highlighted)
        resetButton.addTarget(self, action: #selector(didTapReset(_:)), for: .touchUpInside)
        resetButton.backgroundColor = .lightGray
        
        return resetButton
    }
}

// MARK: - Objective C functions. Targets for the UI elements.

extension RangeViewModel {
    // Update the value of the UISlider's label
    @objc func updateSelectedRangeLabel(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.rangeLabel.text = "\(self.rangeSelector.value) km"
        }
        saveRangeValueLocally()
    }
    
    // Reset button
    @objc func didTapReset(_ sender: UIButton!) {
        showCurrentLocationCheckBox.isChecked = false
        LocationManagerClass.isCurrentLocationON = showCurrentLocationCheckBox.isChecked
        rangeSelector.value = 1.0
        saveRangeValueLocally()
        rangeLabel.text = "\(rangeSelector.value)"
    }
    
    // Change the state of the checkbox
    @objc func checkBoxValueDidChange(_ sender: SimpleCheckbox.Checkbox) {
        LocationManagerClass.isCurrentLocationON = sender.isChecked
    }
}
