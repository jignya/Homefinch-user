//
//  QuotationCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit

class QuotationCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgArw: UIImageView!
    @IBOutlet weak var tblPartList: UITableView!
    @IBOutlet weak var contblPartListHeight: NSLayoutConstraint!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var imgStatusIcon: UIImageView!


    // MARK: PRIVATE
    let quotationlisthandler = QuotationPartListTableHandler()
    var superTblIndexpath : IndexPath!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        self.ImShSetLayout()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ImShSetLayout()
    {
        
        self.tblPartList.estimatedRowHeight = 80
        self.tblPartList.rowHeight = UITableView.automaticDimension
        
        self.tblPartList.setUpTable(delegate: quotationlisthandler, dataSource: quotationlisthandler, cellNibWithReuseId: QuotationPartCell.className)
        
        /// Handling actions
        
        quotationlisthandler.SelectServiceClick = {(indexpath, selected) in
            
//            let cell = self.tblPartList.cellForRow(at: indexpath) as! QuotationPartCell

//            if selected
//            {
//                cell.stackBorderView.borderColor = UIColor.statusTextColor(status: .completed)!
//                cell.stackBorderView.backgroundColor = UIColor(red: 242.0/255.0, green: 248.0/255.0, blue: 244.0/255.0, alpha: 1)
//            }
//            else
//            {
//                cell.stackBorderView.borderColor = UIColor(red: 230.0/255.0, green: 232.0/255.0, blue: 244.0/255.0, alpha: 1)
//                cell.stackBorderView.backgroundColor = UIColor.white
//            }
            
            self.tblPartList.reloadData()

            let arr = self.quotationlisthandler.arrServices.filter{$0.isSelected == 1}
            
            let vc = UIApplication.topViewController()
            if vc is QUOTATIONVIEW
            {
                let viewvc = vc as! QUOTATIONVIEW
                if arr.count == 0
                {
                    var arrMainServices = viewvc.quotationlisthandler.arrServices
                    let dict = arrMainServices[self.superTblIndexpath.row]
                    dict.isSelected = 0
                    arrMainServices[self.superTblIndexpath.row] = dict
                    viewvc.tblServices.reloadData()
                }
                else
                {
                    var arrMainServices = viewvc.quotationlisthandler.arrServices
                    let dict = arrMainServices[self.superTblIndexpath.row]
                    dict.isSelected = 1
                    arrMainServices[self.superTblIndexpath.row] = dict
                    viewvc.tblServices.reloadData()
                }
                
                viewvc.calculateTotalOfservices(isfisrtTime: false)
            }
        }
        
       
    }
    
}
