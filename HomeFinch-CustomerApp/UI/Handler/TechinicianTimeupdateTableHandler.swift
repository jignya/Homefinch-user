//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class TechinicianTimeupdateTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    

    var arrList = [[String:Any]]()

    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TechnicianUpdateCell.className, for: indexPath) as! TechnicianUpdateCell
        
        let dict = arrList[indexPath.row]
        
        let strStartDate = dict["value"] as? String ?? ""
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateformatter1 = DateFormatter()
        dateformatter1.dateFormat = "HH:mm:ss"

        if let serviceDate = dateformatter.date(from: strStartDate)
        {
            dateformatter.dateFormat = "hh:mm a"
            cell.lblTime.text = dateformatter.string(from: serviceDate)
        }
        else
        {
            if let serviceDate = dateformatter1.date(from: strStartDate)
            {
                dateformatter1.dateFormat = "hh:mm a"
                cell.lblTime.text = dateformatter1.string(from: serviceDate)
            }
        }
        
        cell.lblStatus.text = dict["title"] as? String

        cell.statusUpdateHandler.arrList = dict["subArr"] as? [[String:Any]] ?? []
        cell.viewDotLine.isHidden = (cell.statusUpdateHandler.arrList.count == 0)
        cell.tblStatus.reloadData()
        cell.tblStatus.updateConstraintsIfNeeded()
        cell.tblStatus.layoutIfNeeded()
        cell.conTblStatusHeight.constant = cell.tblStatus.contentSize.height
            
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
