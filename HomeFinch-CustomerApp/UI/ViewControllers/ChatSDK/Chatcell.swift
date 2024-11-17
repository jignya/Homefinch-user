//
//  Chatcell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/01/21.
//

import UIKit

class Chatcell: UITableViewCell {
    
    @IBOutlet weak var viewSender: UIView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var viewReceiver: UIView!
    @IBOutlet weak var lblDate: UILabel!


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
