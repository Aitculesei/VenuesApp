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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createCollectionView()
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
