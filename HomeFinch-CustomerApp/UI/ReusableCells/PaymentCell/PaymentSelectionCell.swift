//
//  PaymentSelectionCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 05/01/21.
//

import UIKit

class PaymentSelectionCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var conImgViewHeightConstant: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
