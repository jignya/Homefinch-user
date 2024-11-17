//
//  CategoriesWithImageCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit
import Kingfisher

class OffersCell: UICollectionViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
//    var myBrand: Brand? {
//        didSet {
//            guard let brand = myBrand else { return }
//            self.imageView.setImage(url: brand.thumbnail.getURL, placeholder: UIImage.image(type: .image_placeholder))
//            self.titleLbl.text = brand.name
//        }
//    }
//
//    var mySubCat: CategoryModel? {
//        didSet {
//            guard let cat = mySubCat else { return }
//            self.imageView.setImage(url: cat.imageUrl.getURL, placeholder: UIImage.image(type: .image_placeholder))
//            self.imageView.contentMode = .scaleToFill
//            self.titleLbl.text = cat.name.uppercased()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

}
