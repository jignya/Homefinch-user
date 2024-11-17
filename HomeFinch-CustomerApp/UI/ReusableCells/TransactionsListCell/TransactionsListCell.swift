//
//  CellTransactionsList.swift
//  HomeFinchCrew
//
//  Created by Mitesh Mewada on 04/12/20.
//

import UIKit

class TransactionsListCell: UITableViewCell {

    
    @IBOutlet weak var mainStackview: UIStackView!
    
    @IBOutlet weak var viewCashback: UIView!
    @IBOutlet weak var lblCashBack: UILabel!
    @IBOutlet weak var lblCashBackValue: UILabel!
    @IBOutlet weak var lblCashBackAmt: UILabel!

    @IBOutlet weak var lblPurchase: UILabel!
    @IBOutlet weak var lblPurchaseValue: UILabel!
    @IBOutlet weak var lblPurchaseAmt: UILabel!

    @IBOutlet weak var viewPurchase: UIView!
    
    
    
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
