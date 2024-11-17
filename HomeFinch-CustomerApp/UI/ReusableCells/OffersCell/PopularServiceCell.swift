//
//  PopularServiceCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/01/21.
//

import UIKit

class PopularServiceCell: UICollectionViewCell {
    
    // MARK: OUTLETS
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var imgCat: UIImageView!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rightBorderLbl: UILabel!

    @IBOutlet weak var viewBg: UIView!

        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

}
