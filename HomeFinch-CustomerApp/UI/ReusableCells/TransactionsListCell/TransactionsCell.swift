//
//  CellTransactionsList.swift
//  HomeFinchCrew
//
//  Created by Mitesh Mewada on 04/12/20.
//

import UIKit

class TransactionsCell: UITableViewCell,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var viewCircle: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var conTblListHeight: NSLayoutConstraint!
    
    var arrList = [Stub]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutUpdate()
    {        
        tblList.register(delegate: self, dataSource: self, cellNibWithReuseId: TransactionsListCell.className)

    }
    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsListCell.className, for: indexPath) as! TransactionsListCell
        
        let dict = arrList[indexPath.row]
        
        cell.viewCashback.isHidden = true
        cell.viewPurchase.isHidden = true
        
        
        if dict.type == "debit"
        {
            cell.viewPurchase.isHidden = false
            cell.lblPurchase.text = dict.descriptionField
            cell.lblPurchaseValue.isHidden = true    //text = dict.refId
            
            cell.lblPurchaseAmt.text = dict.amount
        }
        else
        {
            cell.viewCashback.isHidden = false
            cell.lblCashBack.text = dict.descriptionField
            cell.lblCashBackValue.isHidden = true    //text = dict.refId
            
            cell.lblCashBackAmt.text = dict.amount

        }
       

        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()
        self.conTblListHeight.constant = self.tblList.contentSize.height

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
}
