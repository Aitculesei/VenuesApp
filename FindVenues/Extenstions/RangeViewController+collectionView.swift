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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.queriesCollectionIdentifier, for: indexPath) as? QueriesCollectionViewCell {
            if indexPath.section == Section.categories.rawValue {
                return createCategoriesCollection(collectionView, cellForItemAt: indexPath, cell: cell)
            } else if indexPath.section == Section.buttons.rawValue {
                return createButtons(collectionView, cell: cell)
            }
        }
        
        return UICollectionViewCell()
    }
    
    func createButtons(_ collectionView: UICollectionView, cell: UICollectionViewCell) -> UICollectionViewCell {
        cell.contentView.addSubview(buttonsView)
        setupConstraints()
        
        return cell
    }
    
    func createCategoriesCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cell: QueriesCollectionViewCell) -> UICollectionViewCell {
        guard let categoryIconUrl = queriesDataSource[indexPath.row].icon else {
            fatalError("\(queriesDataSource[indexPath.row].name) category icon is missing.")
        }
        cell.imageview.downloaded(from: categoryIconUrl) { icon in
            cell.categoryIcon = icon
        }
        
        cell.loadingActivityIndicator.tag = 999
        
        let categoryNameSplitted = self.queriesDataSource[indexPath.row].name?.split(separator: " ")
        cell.categoryLabel.text = String(categoryNameSplitted?[0] ?? "")
        
        cell.contentView.addSubview(cell.button)
        cell.contentView.addSubview(cell.categoryLabel)
        cell.contentView.addSubview(cell.loadingActivityIndicator)
        
        cell.button.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(cell.categoryLabel.snp.top).offset(-2)
        }
        
        cell.loadingActivityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let viewWithTag = self.view.viewWithTag(999) {
                viewWithTag.removeFromSuperview()
            }
            cell.categoryIcon = cell.categoryIcon?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            cell.button.setImage(cell.categoryIcon, for: .normal)
            cell.button.setTitle("\(self.queriesDataSource[indexPath.row].name!)", for: .normal)
            
            cell.categoryLabel.snp.makeConstraints { make in
                make.centerX.bottom.equalToSuperview()
            }
            
            cell.button.addTarget(self, action: #selector(self.didSelectQuery), for: .touchUpInside)
            cell.button.backgroundColor = .blue
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
