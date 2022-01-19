//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SimpleCheckbox
import RangeUISlider

protocol ManageVenuesConsideringTheSelectedQuery: AnyObject {
    func shouldUpdateVenues()
}

class RangeViewController: UIViewController {
    weak var delegateNecessaryVenuesFunctionality: ManageVenuesConsideringTheSelectedQuery?
    var queriesDataSource: [CategoryBO] = [] {
        didSet {
            queriesCollectionView?.reloadData()
        }
    }
    var queriesCollectionView: UICollectionView?
    var rangeSelector : UISlider = UISlider()
    let rangeLabel : UILabel = UILabel(frame: CGRect(x: 30, y: 430, width: 200, height: 21))
    let resetButton = UIButton()
    var showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createCollectionView()
        createRangeSelector()
        createShowCurrentLocationCheckBox()
        addChecboxLabel()
        
        createResetButton()
    }
    
    // MARK: - Create the Collection View with the queries
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        queriesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        queriesCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.identifier)
        queriesCollectionView?.backgroundColor = UIColor.white
        
        queriesCollectionView?.dataSource = self
        queriesCollectionView?.delegate = self
        
        self.view.addSubview(queriesCollectionView ?? UICollectionView())
    }
    
    // MARK: - Add the range slider
    
    func createRangeSelector() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 50, y: 385)
        label.textAlignment = .center
        label.text = "Range"
        
        rangeLabel.isUserInteractionEnabled = true
        
        rangeSelector.isUserInteractionEnabled = true
        rangeSelector = UISlider(frame: CGRect (x: 45, y: 370, width: 310, height: 31))
        rangeSelector.center = CGPoint(x: 185, y: 415)
        rangeSelector.minimumValue = 1
        rangeSelector.maximumValue = 5
        rangeSelector.isContinuous = false
        rangeSelector.tintColor = .blue
//        if let range = LocationManagerClass.range {
//            rangeSelector.value = range
//        } else {
//            rangeSelector.value = 1.0
//        }
        rangeSelector.value = 1.0
        rangeSelector.addTarget(self, action: #selector(updateSelectedRangeLabel(_:)), for: .valueChanged)
        rangeLabel.text = "\(rangeSelector.value) km"

        self.view.addSubview(label)
        self.view.addSubview(rangeSelector)
        self.view.addSubview(rangeLabel)
    }
    
    // MARK: - Add the checkbox that is responsible for either showing the current location on map or not
    
    func createShowCurrentLocationCheckBox() {
        showCurrentLocationCheckBox.checkmarkStyle = .tick
        showCurrentLocationCheckBox.borderStyle = .square
        showCurrentLocationCheckBox.emoji = "✅"
        showCurrentLocationCheckBox.frame = CGRect(x: 33, y: 465, width: 35, height: 35)
        showCurrentLocationCheckBox.addTarget(self, action: #selector(checkBoxValueDidChange(_:)), for: .valueChanged)
        
        self.view.addSubview(showCurrentLocationCheckBox)
    }
    
    func addChecboxLabel() {
        let checkBoxLabel = UILabel(frame: CGRect(x: 63, y: 465, width: 275, height: 35))
        
        checkBoxLabel.textAlignment = .center
        checkBoxLabel.text = "Show current location on map"
        
        self.view.addSubview(checkBoxLabel)
    }
    
    // MARK: - A RESET button responsible for getting all the values to a default state
    
    func createResetButton() {
        resetButton.frame = CGRect(origin: CGPoint(x: 180, y: 775), size: CGSize(width: 70, height: 30))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitle("Release", for: .highlighted)
        resetButton.addTarget(self, action: #selector(didTapReset(_:)), for: .touchUpInside)
        resetButton.backgroundColor = .lightGray
        
        self.view.addSubview(resetButton)
    }
}

// MARK: - Extensions

extension RangeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return queriesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.identifier, for: indexPath) as? UICollectionViewCell else {
            fatalError("Queries Collection View cell could not be created.")
        }
        
        guard let categoryIconUrl = queriesDataSource[indexPath.row].icon else {
            fatalError("\(queriesDataSource[indexPath.row].name) category icon is missing.")
        }
        var categoryIcon: UIImage?
        let imageview = UIImageView()
        imageview.downloaded(from: categoryIconUrl) { icon in
            categoryIcon = icon
        }
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: 20,
                                            width: 85,
                                            height: 60))
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
        loadingActivityIndicator.center = CGPoint(
            x: 40,
            y: 20
        )
        loadingActivityIndicator.tag = 999
        button.addSubview(loadingActivityIndicator)
        cell.addSubview(button)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let viewWithTag = self.view.viewWithTag(999) {
                viewWithTag.removeFromSuperview()
            }
            categoryIcon = categoryIcon?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            button.setImage(categoryIcon, for: .normal)
            button.setTitle(self.queriesDataSource[indexPath.row].name, for: .normal)
            
            let categoryLabel = UILabel(frame: CGRect(x: 0, y: 64, width: 90, height: 10))
            let categoryNameSplitted = self.queriesDataSource[indexPath.row].name?.split(separator: " ")
            categoryLabel.text = String(categoryNameSplitted?[0] ?? "")
            button.addSubview(categoryLabel)
            button.addTarget(self, action: #selector(self.didSelectQuery), for: .touchUpInside)
            button.backgroundColor = .blue
        }
        
        return cell
    }
}

extension RangeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("Selected query: \(queriesDataSource[indexPath.row])")
    }
}

extension RangeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 5.0
        let height = width
        
        return CGSize(width: width, height: height)
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
//        delegateNecessaryVenuesFunctionality?.shouldUpdateVenues()
    }
    
    // Update the value of the UISlider's label
    @objc func updateSelectedRangeLabel(_ sender: UISlider) {
        rangeLabel.text = "\(rangeSelector.value) km"
        LocationManagerClass.range = rangeSelector.value * 1000.0
//        LocalDataManager.saveData(data: rangeSelector.value, key: "rangeValue")
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
        rangeLabel.text = "\(rangeSelector.value)"
    }
}
