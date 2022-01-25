//
//  RangeViewController+collectionView.swift
//  FindVenues
//
//  Created by Aitculesei, Andrei on 20.01.2022.
//

import UIKit
import SnapKit

enum Section: Int {
    case categories = 0
    case buttons = 1
}

extension RangeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Section.categories.rawValue {
            return queriesDataSource.count
        } else if section == Section.buttons.rawValue {
            return 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Section.categories.rawValue {
            return createCategoriesCollection(collectionView, cellForItemAt: indexPath)
        } else if indexPath.section == Section.buttons.rawValue {
            return createButtons(collectionView, cellForItemAt: indexPath)
        }
        
        return UICollectionViewCell()
    }
    
    func createButtons(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier, for: indexPath) as? UICollectionViewCell else {
            fatalError("Queries Collection View cell could not be created.")
        }

        cell.contentView.addSubview(buttonsView)
        setupConstraints()
        
        return cell
    }
    
    func createCategoriesCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier, for: indexPath) as? UICollectionViewCell else {
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
        loadingActivityIndicator.tag = 999
        
        let button = UIButton()
        let categoryLabel = UILabel()
        let categoryNameSplitted = self.queriesDataSource[indexPath.row].name?.split(separator: " ")
        categoryLabel.text = String(categoryNameSplitted?[0] ?? "")
        
        cell.contentView.addSubview(button)
        cell.contentView.addSubview(categoryLabel)
        cell.contentView.addSubview(loadingActivityIndicator)
        
        button.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(categoryLabel.snp.top).offset(-2)
        }
        
        loadingActivityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let viewWithTag = self.view.viewWithTag(999) {
                viewWithTag.removeFromSuperview()
            }
            categoryIcon = categoryIcon?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            button.setImage(categoryIcon, for: .normal)
            button.setTitle("\(self.queriesDataSource[indexPath.row].name!)", for: .normal)
            
            categoryLabel.snp.makeConstraints { make in
                make.centerX.bottom.equalToSuperview()
            }
            
            button.addTarget(self, action: #selector(self.didSelectQuery), for: .touchUpInside)
            button.backgroundColor = .blue
        }
        
        DispatchQueue.main.async {
            self.collectionViewHeightConstraint?.update(offset: self.queriesCollectionView.contentSize.height)
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
        if indexPath.section == Section.categories.rawValue {
            let width = collectionView.bounds.width / 5.0
            let height = width
            
            return CGSize(width: width, height: height)
        } else if indexPath.section == Section.buttons.rawValue {
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            
            return CGSize(width: width, height: height)
        }
        
        return CGSize()
    }
}
