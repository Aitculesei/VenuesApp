//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SimpleCheckbox
import RangeUISlider

class RangeViewController: UIViewController {
    var queriesDataSource: [CategoryBO] = [] {
        didSet {
            queriesCollectionView?.reloadData()
        }
    }
    var queriesCollectionView: UICollectionView?
//    var rangeSelector : UISlider = UISlider()
    let resetButton = UIButton()
    var showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    let rangeLabel : UILabel = UILabel(frame: CGRect(x: 30, y: 330, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createCollectionView()
        createRangeSelector()
        createShowCurrentLocationCheckBox()
        addChecboxLabel()
        
        self.view.addSubview(resetButton)
        createResetButton()
    }
    
    @objc func didSelectQuery(_ sender: UIButton) {
        if let query = sender.currentTitle {
            LocalDataManager.saveData(data: query, key: Constants.LocalDataManagerSavings.queryKey)
        }
        TabBarViewController().reloadInputViews()
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
        label.center = CGPoint(x: 50, y: 285)
        label.textAlignment = .center
        label.text = "Range"
//
//        rangeLabel.isUserInteractionEnabled = true
//
//        rangeSelector.isUserInteractionEnabled = true
//        rangeSelector = UISlider(frame: CGRect (x: 45,y: 70,width: 310,height: 31))
//        rangeSelector.center = CGPoint(x: 185, y: 315)
//        rangeSelector.minimumValue = 1
//        rangeSelector.maximumValue = 10
//        rangeSelector.isContinuous = false
//        rangeSelector.tintColor = .blue
//        rangeSelector.value = 1
//        rangeLabel.text = "\(rangeSelector.value) km"
//
//        self.view.addSubview(label)
//        self.view.addSubview(rangeSelector)
//        self.view.addSubview(rangeLabel)
        
        let rangeSlider = RangeUISlider()
        rangeSlider.frame = CGRect(origin: CGPoint(x: 185, y: 315), size: CGSize(width: 100,height: 50))
//        rangeSlider.center = CGPoint(x: 185, y: 315)
        rangeSlider.isUserInteractionEnabled = true
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        rangeSlider.delegate = self
        rangeSlider.barHeight = 20
        rangeSlider.barCorners = 10
        rangeSlider.leftKnobColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        rangeSlider.leftKnobWidth = 40
        rangeSlider.leftKnobHeight = 40
        rangeSlider.leftKnobCorners = 20
        rangeSlider.rightKnobColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        rangeSlider.rightKnobWidth = 40
        rangeSlider.rightKnobHeight = 40
        rangeSlider.rightKnobCorners = 20
        self.view.addSubview(rangeSlider)
    }
    
    // MARK: - Add the checkbox that is responsible for either showing the current location on map or not
    
    func createShowCurrentLocationCheckBox() {
        showCurrentLocationCheckBox.checkmarkStyle = .tick
        showCurrentLocationCheckBox.borderStyle = .square
        showCurrentLocationCheckBox.emoji = "✅"
        showCurrentLocationCheckBox.frame = CGRect(x: 40, y: 370, width: 35, height: 35)
        showCurrentLocationCheckBox.addTarget(self, action: #selector(checkBoxValueDidChange(_:)), for: .valueChanged)
        
        self.view.addSubview(showCurrentLocationCheckBox)
    }
    
    @objc func checkBoxValueDidChange(_ sender: SimpleCheckbox.Checkbox) {
        
        print(sender.isChecked)
    }
    
    func addChecboxLabel() {
        let checkBoxLabel = UILabel(frame: CGRect(x: 75, y: 370, width: 275, height: 35))
        
        checkBoxLabel.textAlignment = .center
        checkBoxLabel.text = "Show current location on map"
        
        self.view.addSubview(checkBoxLabel)
    }
    
    // MARK: - A RESET button responsible for getting all the values to a default state
    
    func createResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: UIControl.State.normal)
        resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 45).isActive = true
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
                                            height: 40))
        var loadingActivityIndicator: UIActivityIndicatorView = {
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
//            button.imageView?.contentMode = .scaleAspectFit
//            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(self.didSelectQuery), for: .touchUpInside)
            button.backgroundColor = .blue
            
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected query: \(queriesDataSource[indexPath.row])")
    }
}

extension RangeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(queriesDataSource[indexPath.row])
    }
}

extension RangeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 5.0
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

extension RangeViewController: RangeUISliderDelegate {
    func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        print("payback value: \(maxValueSelected)")
        rangeLabel.text = "\(maxValueSelected) km"
    }
}
