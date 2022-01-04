//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit

class RangeViewController: UIViewController {
    var queriesDataSource = ["restaurant", "food", "art", "music", "cultural", "pub", "bistro", "drinks"]
    var queriesCollectionView: UICollectionView?
    var rangeSelector : UISlider = UISlider()
    let resetButton = UIButton()
    var showCurrentLocationCheckBox: CheckBox! = CheckBox()
    let rangeLabel : UILabel = UILabel(frame: CGRect(x: 30, y: 330, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSelector.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
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
    
    // MARK: - Create the Collection View with 8 queries
    
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
    
    func createRangeSelector() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 50, y: 285)
        label.textAlignment = .center
        label.text = "Range"
        
        rangeLabel.isUserInteractionEnabled = true
        
        rangeSelector.isUserInteractionEnabled = true
        rangeSelector = UISlider(frame: CGRect (x: 45,y: 70,width: 310,height: 31))
        rangeSelector.center = CGPoint(x: 185, y: 315)
        rangeSelector.minimumValue = 1
        rangeSelector.maximumValue = 10
        rangeSelector.isContinuous = false
        rangeSelector.tintColor = .blue
        rangeSelector.value = 1
        rangeLabel.text = "\(rangeSelector.value) km"
        
        self.view.addSubview(label)
        self.view.addSubview(rangeSelector)
        self.view.addSubview(rangeLabel)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!)
    {
        print("payback value: \(sender.value)")
        rangeLabel.text = "\(sender.value) km"
    }
    
    func createShowCurrentLocationCheckBox() {
        showCurrentLocationCheckBox.style = .tick
        showCurrentLocationCheckBox.borderStyle = .square
        showCurrentLocationCheckBox.frame = CGRect(x: 40, y: 355, width: 35, height: 35)
        showCurrentLocationCheckBox.addTarget(self, action: #selector(checkBoxValueDidChange(_:)), for: .valueChanged)
        
        self.view.addSubview(showCurrentLocationCheckBox)
    }
    
    @objc func checkBoxValueDidChange(_ sender: CheckBox) {
        
        print(sender.isChecked)
    }
    
    func addChecboxLabel() {
        let checkBoxLabel = UILabel(frame: CGRect(x: 75, y: 355, width: 275, height: 35))
        
        checkBoxLabel.textAlignment = .center
        checkBoxLabel.text = "Show current location on map"
        
        self.view.addSubview(checkBoxLabel)
    }
    
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
        
        let button = UIButton(frame: CGRect(x: 0,
                                            y: 20,
                                            width: 85,
                                            height: 40))
        button.setTitle(queriesDataSource[indexPath.row], for: .normal)
        button.addTarget(self, action: #selector(didSelectQuery), for: .touchUpInside)
        button.backgroundColor = .blue
        
        cell.addSubview(button)
        
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
