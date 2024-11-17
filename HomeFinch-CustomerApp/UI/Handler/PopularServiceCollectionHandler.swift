//
//  CategoriesWithImageCollectionHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UICOLLECTIONVIEW DELEGATE, DATASOURCE, LAYOUT
class PopularServiceCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var arrService = [Servicelist]()
    var didSelect: ((IndexPath) -> Void)? = nil
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrService.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularServiceCell.className, for: indexPath) as! PopularServiceCell
        let dict = self.arrService[indexPath.row]
        cell.titleLbl.text = dict.name
        cell.PriceLbl.text = String(format: "%@ %d", dict.currencyCode , dict.price)
        cell.rightBorderLbl.isHidden = (indexPath.item % 2 != 0)
        
        cell.imgService.setImage(url: dict.mainImagePath.getURL, placeholder: UIImage.image(type: .Placeholder))
        
        cell.imgCat.setImage(url: dict.category.image.getURL, placeholder: UIImage.image(type: .Placeholder_T))
        cell.imgCat.image = cell.imgCat.image?.withRenderingMode(.alwaysTemplate)
        cell.imgCat.tintColor = UIColor.white

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2) 
        return CGSize.init(width: width, height: width + 40)

    }
    
}
