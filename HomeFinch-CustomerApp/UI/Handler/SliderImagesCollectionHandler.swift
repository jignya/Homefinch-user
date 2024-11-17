//
//  BannersCollectionHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class SliderImagesCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [String]()
    var isStatic : Bool!
    var imageContentMode: UIView.ContentMode = .scaleAspectFit
    var didEndDecelerating: (() -> Void)? = nil
    var didScroll: (() -> Void)? = nil
    var didSelect: (() -> Void)? = nil


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.className, for: indexPath) as! ImageCell
        cell.imageView.contentMode = imageContentMode
        
        if isStatic
        {
            cell.setImage = images.at(index: indexPath.row)

        }
        else
        {
            cell.myImage = images.at(index: indexPath.row).getURL

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("slider select")
        if collectionView.tag == 101
        {
            didSelect?()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didEndDecelerating?()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?()
    }
    
}
