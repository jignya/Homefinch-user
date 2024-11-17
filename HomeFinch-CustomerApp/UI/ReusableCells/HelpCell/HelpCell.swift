//
//  CellHelps.swift
//  HomeFinchCrew
//
//  Created by Mitesh Mewada on 11/12/20.
//

import UIKit

class HelpCell: UITableViewCell {

    
    @IBOutlet weak var viewContain: UIView!
    @IBOutlet weak var lblNoofService: UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var imgRightSide : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
