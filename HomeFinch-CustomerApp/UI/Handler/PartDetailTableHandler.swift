//
//  ServiceListTableHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class PartDetailTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var arrServices = [JobIssueList]()

    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectedPartCell.className, for: indexPath) as! SelectedPartCell
        
        let dt = arrServices[indexPath.row]
        
        cell.lblPartModelName.isHidden = true
        cell.lblUnderLine.isHidden = false
        
        if dt.isExtra == 1
        {
            cell.lblPartName.text = String(format: "%@ - %@ Hour", dt.materialName,dt.materialQuantity) //self.HoursFromString(string: dt.extraHours)
            cell.lblPartCharges.text = String(format: "%@ %@", dt.currencyCode, dt.materialTotalPrice)
        }
        else if dt.type == 2
        {
            cell.lblPartName.text = "Service base price"
            cell.lblPartCharges.text = String(format: "%@ %@", dt.currencyCode, dt.materialTotalPrice)
        }
        else
        {
            cell.lblPartName.text = String(format: "Part - %@ x %@ Qty", dt.materialName,dt.materialQuantity)
            cell.lblPartCharges.text = String(format: "%@ %@", dt.currencyCode, dt.materialTotalPrice)
        }
        
        if indexPath.row == arrServices.count - 1
        {
            cell.lblUnderLine.isHidden = true
        }
        
        cell.selectionStyle = .none
        

        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: Conversion
    func HoursFromString (string: String) -> Float {
        let components: Array = string.components(separatedBy:":")
        let hours = Int(components[0])!
        let minutes = Int(components[1])!
        let seconds = Int(components[2])!
        let totalSeconds = (hours * 3600) + (minutes * 60) + seconds
        return Float((totalSeconds/3600))
    }
    
}
