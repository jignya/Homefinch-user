//
//  CardCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 26/02/21.
//

import UIKit

class CardCell: UITableViewCell {
    
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewBg: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
