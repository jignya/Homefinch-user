//
//  SelectedPartCell.swift
//  HomeFinchCrew
//
//  Created by Mac on 6/4/21.
//

import UIKit

class SelectedPartCell: UITableViewCell {
    
    @IBOutlet weak var viewDetail: UIView!

    @IBOutlet weak var viewPartDetail: UIView!
    @IBOutlet weak var lblPartName: UILabel!
    @IBOutlet weak var lblPartModelName: UILabel!
    @IBOutlet weak var lblPartCharges: UILabel!

    @IBOutlet weak var lblUnderLine: UILabel!

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
