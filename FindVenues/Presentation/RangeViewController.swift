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
    private(set) var rangeViewModel: RangeViewModel!
    private(set) var queriesCollectionView: UICollectionView!
    var rangeSelectorView: UIView!
    var buttonsView: UIView!
    var checkboxView: UIView!
    var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeViewModel = RangeViewModel()
        buttonsView = UIView()
        
        createCollectionView()
        createRangeSelector()
        createShowCurrentLocationCheckBox()
        createResetButton()
        
        queriesCollectionView?.reloadData()
        queriesCollectionView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }
    }
    
    // MARK: - Create the Collection View with the queries
    
    func createCollectionView() {
        queriesCollectionView = rangeViewModel.createCollectionView(frame: self.view.frame)
        
        queriesCollectionView.dataSource = self
        queriesCollectionView.delegate = self
        
        self.view.addSubview(queriesCollectionView)
    }
    
    // MARK: - Add the range slider
    
    func createRangeSelector() {
        rangeSelectorView = rangeViewModel.getRangeSelectorView()
        
        buttonsView.addSubview(rangeSelectorView)
    }
    
    // MARK: - Add the checkbox that is responsible for either showing the current location on map or not
    
    func createShowCurrentLocationCheckBox() {
        checkboxView = rangeViewModel.getShowCurrentLocationCheckbox()
        
        buttonsView.addSubview(checkboxView)
    }
    
    // MARK: - A RESET button responsible for getting all the values to a default state
    
    func createResetButton() {
        resetButton = rangeViewModel.getResetButton()
        
        buttonsView.addSubview(resetButton)
    }
}

// MARK: - Objective C functions. Targets for the UI elements.

extension RangeViewController {
    // A new query was selected
    @objc func didSelectQuery(_ sender: UIButton) {
        if let query = sender.currentTitle {
            LocalDataManager.saveData(data: query, key: Constants.LocalDataManagerSavings.queryKey)
        }
        let tabBarVC = TabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.reloadInputViews()
        self.present(tabBarVC, animated: true, completion: nil)
    }
}
