//
//  TechnicianUpdateCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit

class TechnicianUpdateCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!

    @IBOutlet weak var tblStatus: UITableView!
    @IBOutlet weak var conTblStatusHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewDotLine: UIView!

    let statusUpdateHandler = SubStatusupdateTableHandler()



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        self.tblStatus.estimatedRowHeight = 30
        self.tblStatus.rowHeight = UITableView.automaticDimension
        
        self.tblStatus.setUpTable(delegate: statusUpdateHandler, dataSource: statusUpdateHandler, cellNibWithReuseId: SubStatusUpdateCell.className)
        


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
