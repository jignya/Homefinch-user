//
//  TimeCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 16/12/20.
//

import UIKit

class TimeCell: UITableViewCell {

    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var imgArw: UIImageView!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewDown: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var viewPrice: UIView!


    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var viewBorder: UIView!


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
