//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SimpleCheckbox
import SnapKit

class RangeViewController: UIViewController, UIScrollViewDelegate {
    let buttonsView = UIView()
    var collectionViewHeightConstraint: Constraint?
    var queriesCollectionView: UICollectionView!
    var rangeSelectorView: UIView!
    var rangeSelector = UISlider()
    let rangeLabel = UILabel()
    var checkboxView: UIView!
    var showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    var resetButton: UIButton!
    
    var queriesDataSource: [CategoryBO] = [] {
        didSet {
            queriesCollectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCollectionView()
        createRangeSelector()
        createShowCurrentLocationCheckBox()
        
        createResetButton()
        queriesCollectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    // MARK: - Create the Collection View with the queries
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        queriesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        queriesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier)
        queriesCollectionView.backgroundColor = .white
        
        queriesCollectionView.dataSource = self
        queriesCollectionView.delegate = self
        
        self.view.addSubview(queriesCollectionView)
    }
    
    // MARK: - Add the range slider
    
    func createRangeSelector() {
        
        rangeSelectorView = UIView(frame: .zero)
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
        buttonsView.addSubview(rangeSelectorView)
    }
    
    // MARK: - Add the checkbox that is responsible for either showing the current location on map or not
    
    func createShowCurrentLocationCheckBox() {
        checkboxView = UIView()
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
        
        buttonsView.addSubview(checkboxView)
    }
    
    // MARK: - A RESET button responsible for getting all the values to a default state
    
    func createResetButton() {
        resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitle("Release", for: .highlighted)
        resetButton.addTarget(self, action: #selector(didTapReset(_:)), for: .touchUpInside)
        resetButton.backgroundColor = .lightGray
        
        buttonsView.addSubview(resetButton)
    }
    
    func saveRangeValueLocally() {
        LocalDataManager.saveData(data: rangeSelector.value, key: Constants.LocalDataManagerSavings.rangeValueKey)
    }
}

// MARK: - Objective C functions. Targets for the UI elements.

extension RangeViewController {
    // A new query was selected
    @objc func didSelectQuery(_ sender: UIButton) {
        if let query = sender.currentTitle {
            LocalDataManager.saveData(data: query, key: Constants.LocalDataManagerSavings.queryKey)
        }
        TabBarViewController().reloadInputViews()
    }
    
    // Update the value of the UISlider's label
    @objc func updateSelectedRangeLabel(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.rangeLabel.text = "\(self.rangeSelector.value) km"
        }
        saveRangeValueLocally()
    }
    
    // Change the state of the checkbox
    @objc func checkBoxValueDidChange(_ sender: SimpleCheckbox.Checkbox) {
        LocationManagerClass.isCurrentLocationON = sender.isChecked
    }
    
    // Reset button
    @objc func didTapReset(_ sender: UIButton!) {
        showCurrentLocationCheckBox.isChecked = false
        LocationManagerClass.isCurrentLocationON = showCurrentLocationCheckBox.isChecked
        rangeSelector.value = 1.0
        saveRangeValueLocally()
        rangeLabel.text = "\(rangeSelector.value)"
    }
}
