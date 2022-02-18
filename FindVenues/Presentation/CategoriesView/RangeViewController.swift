//
//  RangeViewController.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 13.12.2021.
//

import UIKit
import SimpleCheckbox
import SnapKit
import SwiftSpinner

class RangeViewController: UIViewController, UIScrollViewDelegate {
    private(set) var rangeViewModel: RangeViewModel!
    private(set) var queriesCollectionView: UICollectionView!
    let showCurrentLocationCheckBox = SimpleCheckbox.Checkbox()
    var rangeSelectorView: UIView!
    var rangeSelector: UISlider!
    private var rangeLabel: UILabel!
    var buttonsView: UIView!
    var checkboxView: UIView!
    var resetButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private(set) var queriesDataSource: [CategoryBO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeViewModel = RangeViewModel()
        buttonsView = UIView()
        
        createCollectionView()
        createRangeSelector()
        createShowCurrentLocationCheckBox()
        createResetButton()
        
        queriesCollectionView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }
        
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(40)
//            make.height.equalTo(25)
        }
        
        createBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rangeViewModel.sendAction(action: .loadData)
    }
    
    // MARK: - Create the Collection View with the queries
    
    func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        queriesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        queriesCollectionView.register(QueriesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier)
        queriesCollectionView.backgroundColor = .white
        
        queriesCollectionView.dataSource = self
        queriesCollectionView.delegate = self
        
        self.view.addSubview(queriesCollectionView)
    }
    
    // MARK: - Add the range slider
    
    func createRangeSelector() {
        // ADDING THE LABEL FOR THE RANGE SLIDER TITLE
        rangeSelectorView = UIView()
        rangeSelector = UISlider()
        rangeLabel = UILabel()
        
        let rangeSliderTitle = UILabel()
        rangeSliderTitle.textAlignment = .left
        rangeSliderTitle.text = "Range"
        
        rangeSelectorView.addSubview(rangeSliderTitle)
        
        rangeSliderTitle.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
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
        rangeSelector.addTarget(self, action: #selector(updateSelectedRangeLabel(_:)), for: .valueChanged)
        
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
}

// MARK: - Objective C functions

extension RangeViewController {
    // Update the value of the UISlider's label
    @objc func updateSelectedRangeLabel(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.rangeLabel.text = "\(self.rangeSelector.value) km"
        }
        self.rangeViewModel.sendAction(action: .setRange(sender.value))
    }
    
    // Change the state of the checkbox
    @objc func checkBoxValueDidChange(_ sender: SimpleCheckbox.Checkbox) {
        self.rangeViewModel.sendAction(action: .checkCurrentLocationCheckbox(sender.isChecked))
    }
    
    // Reset button
    @objc func didTapReset(_ sender: UIButton!) {
        showCurrentLocationCheckBox.isChecked = false
        LocationManagerClass.isCurrentLocationON = showCurrentLocationCheckBox.isChecked
        rangeSelector.value = 1.0
        
        self.rangeViewModel.sendAction(action: .resetEntireView(rangeSelector.value))
        
        rangeLabel.text = "\(rangeSelector.value)"
    }
}

// MARK: - Create bindings

extension RangeViewController {
    func createBindings() {
        self.rangeViewModel.state.bind { state in
            switch state{
            case .idle:
                // Hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
            case .loading:
                // Show spinner
                DispatchQueue.main.async {
                    SwiftSpinner.show("Loading the categories...")
                    SwiftSpinner.show(delay: 3.0, title: "It's taking a little longer than expected...")
                }
            case .loaded(let data, let currentRangeSelectorValue):
                self.queriesDataSource = data
                self.rangeSelector.value = currentRangeSelectorValue
                self.rangeLabel.text = "\(self.rangeSelector.value) km"
                self.queriesCollectionView.reloadData()
                // hide spinner
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                }
                self.rangeViewModel.sendAction(action: .reset)
            case .error(let error):
                //show error
                DispatchQueue.main.async {
                    SwiftSpinner.show("Failed to load the categories!", animated: false)
                }
                
                self.rangeViewModel.sendAction(action: .reset)
            }
        }
    }
}
