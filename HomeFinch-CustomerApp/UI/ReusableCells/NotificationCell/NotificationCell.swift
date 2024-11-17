//
//  NotificationCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 14/12/20.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgArw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVilla: UIImageView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewBg: UIView!


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
