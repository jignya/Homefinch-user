//
//  SelectedPartCell.swift
//  HomeFinchCrew
//
//  Created by Mac on 6/4/21.
//

import UIKit

class SelectedServiceCell: UITableViewCell {
    
    @IBOutlet weak var viewChargeDetail: UIView!
    
    @IBOutlet weak var viewServiceDetail: UIView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServiceCharges: UILabel!

    @IBOutlet weak var tblPartDetail: UITableView!
    @IBOutlet weak var contblPartDetailHeight: NSLayoutConstraint!

    let partHandler = PartDetailTableHandler()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        self.tblPartDetail.setUpTable(delegate: partHandler, dataSource: partHandler, cellNibWithReuseId: SelectedPartCell.className)
        
        self.tblPartDetail.updateConstraintsIfNeeded()
        self.tblPartDetail.layoutIfNeeded()
        self.contblPartDetailHeight.constant =  self.tblPartDetail.contentSize.height

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}
