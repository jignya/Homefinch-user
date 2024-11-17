//
//  MainCategoriesCollectionHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class MainCategoriesCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categories = [CategoryList]()
    var didSelect: ((CategoryList,IndexPath) -> Void)? = nil
    //    var didSelect: ((IndexPath) -> Void)? = nil
    var didScroll: (() -> Void)? = nil
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCell.className, for: indexPath) as! MainCategoriesCell
        
        cell.viewBg.cornerRadius =  30 //(collectionView.frame.height - 45 ) / 2
        cell.myCat = self.categories.at(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(categories.at(index: indexPath.row), indexPath)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = ((collectionView.frame.width ) / 4) - 20
//        return CGSize.init(width: width, height: collectionView.frame.height)
        return CGSize.init(width: 90, height: 90)
    }
    
}
