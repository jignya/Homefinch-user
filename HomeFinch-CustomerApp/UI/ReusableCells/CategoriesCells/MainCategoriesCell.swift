//
//  MainCategoriesCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class MainCategoriesCell: UICollectionViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var imgPlay: UIImageView!


    var myCat: CategoryList? {
        didSet {
            guard let c = myCat else { return }
            titleLbl.text = c.alias.capitalized
            thumb.setImage(url: c.image.getURL, placeholder: UIImage.image(type: .Placeholder_T))
            thumb.setImageColor(color: UIColor.white)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewBg.cornerRadius = self.viewBg.frame.size.height / 2.0
        print(self.viewBg.frame)
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

        
    }
}
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
