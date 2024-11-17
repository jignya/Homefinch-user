//
//  ReviewCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/01/21.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var lblservice: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblUnderLine: UILabel!


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
