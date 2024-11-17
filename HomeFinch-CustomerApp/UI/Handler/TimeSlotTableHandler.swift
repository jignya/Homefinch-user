//
//  TimeSlotTableHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class TimeSlotTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var TimeSlots = [TimeSlot]()
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCell.className, for: indexPath) as! TimeCell
        
        let dict = TimeSlots[indexPath.row]
        cell.lbltime.text = UserSettings.shared.string24To12String(time: dict.slotTime)
        
        cell.isUserInteractionEnabled = true
        cell.viewDown.isHidden = true
        cell.lblAvailable.text = "Available"
        
        if dict.isselected == "1"
        {
            cell.viewMain.backgroundColor = UIColor(red: 227.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        }
        else
        {
            cell.viewMain.backgroundColor = UIColor.white
        }

        if dict.slotFull == true
        {
            cell.lblAvailable.text = "Slot Full"
            cell.lbltime.alpha = 0.7
            cell.viewMain.alpha = 0.8
            cell.isUserInteractionEnabled = false
            cell.viewDash.isHidden = true
            cell.viewBorder.isHidden = false
        }
        else
        {
            cell.viewDash.isHidden = false
            cell.viewBorder.isHidden = true
            cell.lbltime.alpha = 1
            cell.viewMain.alpha = 1


//            let ViewBorder = CAShapeLayer()
//            ViewBorder.strokeColor = UserSettings.shared.themeColor().cgColor
//            ViewBorder.lineDashPattern = [5, 3]
//            ViewBorder.frame = cell.viewMain.bounds //CGRect(x: 0, y: 0, width: cell.viewMain.frame.width - 1, height: cell.viewMain.frame.height)
//            ViewBorder.fillColor = nil
//            ViewBorder.path = UIBezierPath(rect: cell.viewMain.bounds).cgPath
//            cell.viewMain.layer.addSublayer(ViewBorder)

        }
        
        
        if dict.highDemandUtilization
        {
            cell.viewDown.isHidden = false
            
            cell.imgArw.image = UIImage(named: "Price_up")
            cell.viewPrice.borderColor = UIColor.statusBackgroundColor(status: .cancelled)!
            cell.viewPrice.backgroundColor = UIColor.statusBackgroundColor(status: .cancelled)
            cell.lblCountry.textColor = UIColor.statusTextColor(status: .cancelled)
        }
        

        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let cell = tableView.cellForRow(at: indexPath) as! TimeCell
//        cell.viewMain.backgroundColor = UIColor(red: 227.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
        
        for i in 0..<TimeSlots.count
        {
            let dict = TimeSlots[i]

            if i == indexPath.row
            {
                dict.isselected = "1"
            }
            else
            {
                dict.isselected = "0"
            }
            
            TimeSlots[i] = dict
        }
        
        tableView.reloadData()
        self.didSelect?(indexPath)


    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
//    {
//        let cell = tableView.cellForRow(at: indexPath) as! TimeCell
//        cell.viewMain.backgroundColor = UIColor.white
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
