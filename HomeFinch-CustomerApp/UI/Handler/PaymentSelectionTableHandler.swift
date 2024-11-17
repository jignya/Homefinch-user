//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class PaymentSelectionTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var SelectMethodClick: ((IndexPath,Bool) -> Void)? = nil  

    var arrMethods = [[String:Any]]()
    
    //MARK: Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentSelectionCell.className, for: indexPath) as! PaymentSelectionCell
       
        cell.lblName.text = arrMethods[indexPath.row]["name"] as? String
        cell.btnSelect.isSelected = false
        cell.conImgViewHeightConstant.constant = 0
        
        if indexPath.row == 1
        {
            cell.conImgViewHeightConstant.constant = 40
        }
        
        if arrMethods[indexPath.row]["isSelected"] as? String == "1"
        {
            cell.btnSelect.isSelected = true
        }
        
        cell.btnSelect.tag = indexPath.item
        cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)

      
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 // UITableView.automaticDimension
    }
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.SelectMethodClick?(indexpath, btn.isSelected)
    }
}
