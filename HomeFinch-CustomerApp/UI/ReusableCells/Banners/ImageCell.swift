//
//  BannerCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class ImageCell: UICollectionViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    
    var myImage: URL? {
        didSet {
            imageView.setImage(url: myImage, placeholder: UIImage.image(type: .Placeholder))
        }
    }
    
    var setImage: String! {
        didSet {
            imageView.image = UIImage(named: setImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
