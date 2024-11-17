//
//  PartCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit

class PartCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPart: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblWarranty: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var viewDahed: UIView!
    @IBOutlet weak var viewBorder: UIView!

    @IBOutlet weak var btnSelect: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

}
