//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class QuotationPartListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var SelectServiceClick: ((IndexPath,Bool) -> Void)? = nil
    var arrServices = [ServiceData]()
    var isSelectAvailable:Bool = false

    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuotationPartCell.className, for: indexPath) as! QuotationPartCell
        
        cell.viewPartModel.isHidden = true
        
        let dictData = arrServices[indexPath.row]
        
//        cell.btnSelect.isHidden = !isSelectAvailable
        
        cell.viewRecommend.isHidden = !(dictData.recommended == 1)

        cell.lblPartServiceName.text = dictData.serviceData.serviceDescription
        cell.lblPartServiceAmount.text = String(format: "%@ %d", dictData.currencyCode, dictData.sum)
    
        cell.partHandler.arrServices = dictData.data
        
        cell.tblPartDetail.reloadData()
        cell.tblPartDetail.updateConstraintsIfNeeded()
        cell.tblPartDetail.layoutIfNeeded()
        cell.contblPartDetailHeight.constant = CGFloat(dictData.data.count * 50)
        cell.tblPartDetail.isHidden = (dictData.data.count == 0)

//        let arrr1 = dictData.data.filter({$0.type == 1 || $0.isExtra == 1})
//        cell.contblPartDetailHeight.constant = CGFloat(arrr1.count * 50)
//        cell.tblPartDetail.isHidden = (arrr1.count == 0)
        
        if dictData.isSelected == 0
        {
            cell.btnSelect.isSelected = false
            cell.stackBorderView.borderColor = UIColor(red: 230.0/255.0, green: 232.0/255.0, blue: 244.0/255.0, alpha: 1)
            cell.stackBorderView.backgroundColor = UIColor.white
        }
        else
        {
            cell.btnSelect.isSelected = true
            cell.stackBorderView.borderColor = UIColor.statusTextColor(status: .completed)!
            cell.stackBorderView.backgroundColor = UIColor(red: 242.0/255.0, green: 248.0/255.0, blue: 244.0/255.0, alpha: 1)
        }

        cell.btnSelect.tag = indexPath.item
        cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)
        
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        
        let dictData = arrServices[indexPath.row]
        let height = CGFloat(dictData.data.count * 50)
        return height + 90 + ((dictData.recommended == 1) ? (25 + 10) : 0)
    }
    
    //MARK:- Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        
        let dict = arrServices[btn.tag]
        if btn.isSelected
        {
            dict.isSelected = 1
        }
        else
        {
            dict.isSelected = 0
        }
        arrServices[btn.tag] = dict
        
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.SelectServiceClick?(indexpath, btn.isSelected)
    }
    
    //MARK:- Conversion
    func HoursFromString (string: String) -> Float {
        let components: Array = string.components(separatedBy:":")
        let hours = Int(components[0])!
        let minutes = Int(components[1])!
        let seconds = Int(components[2])!
        let totalSeconds = (hours * 3600) + (minutes * 60) + seconds
        return Float((totalSeconds/3600))
    }
}
