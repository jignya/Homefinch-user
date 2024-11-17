//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SubStatusupdateTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {

    var arrList = [[String:Any]]()

    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubStatusUpdateCell.className, for: indexPath) as! SubStatusUpdateCell
        
        let dict = arrList[indexPath.row]
        
        let strStartDate = dict["value"] as? String ?? ""
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm:ss"
        if let serviceDate = dateformatter.date(from: strStartDate)
        {
            dateformatter.dateFormat = "hh:mm a"
            cell.lblTime.text = dateformatter.string(from: serviceDate)
        }
        
        cell.lblStatus.text = String(format: "- %@", dict["title"] as? String ?? "")
        
        
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
}
