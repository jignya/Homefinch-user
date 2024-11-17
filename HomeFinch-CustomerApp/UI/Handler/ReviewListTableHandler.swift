//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class ReviewListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //    var arrServicesList = [ServiceData]()
    //    var arrMaterialList = [JobIssueList]()
    
    var arrServicesList = [JobserviceFilterData]()
    var arrMaterialList = [JobIssueListFilterData]()
    var arrOtherServiceList = [Jobotherservice]()
    
    //MARK: Tableview Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return  arrServicesList.count + arrOtherServiceList.count
        }
        
        return  arrMaterialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.className, for: indexPath) as! ReviewCell
        
        cell.lblUnderLine.isHidden = true
        
        if indexPath.section == 0
        {
            //            let dict = arrServicesList[indexPath.row]
            //            cell.lblservice.text = dict.serviceData.serviceDescription
            //            cell.lblAmount.text = String(format: "%@ %@",dict.serviceData.currencyCode, dict.serviceData.price )
            //
            //            if dict.serviceData.isAdditionalHours == 1 && dict.data.count == 1
            //            {
            //                let datadict = dict.data[0]
            //                cell.lblAmount.text =  String(format: "%@ %@",dict.serviceData.currencyCode, datadict.materialTotalPrice)
            //            }
            
            if arrServicesList.count - 1 >= indexPath.row && arrServicesList.count > 0
            {
                let dict = arrServicesList[indexPath.row]
                if dict.isAdditionalHours == 1
                {
                    cell.lblservice.text = dict.serviceDescription //String(format: "%@ x %.1f",dict.serviceDescription, dict.serviceQty)
                }
                else
                {
                    cell.lblservice.text = String(format: "%@ x %.f",dict.serviceDescription, dict.serviceQty)
                }
                cell.lblAmount.text = String(format: "%@ %@",dict.currencyCode, dict.price)
            }
            else
            {
                let dict = arrOtherServiceList[indexPath.row - arrServicesList.count]
                cell.lblservice.text = dict.serviceName
                cell.lblAmount.text = String(format: "%@ %@",dict.currencyCode, dict.serviceTotalPrice)
            }
            
            if indexPath.row == (arrServicesList.count + arrOtherServiceList.count) - 1 && arrMaterialList.count > 0
            {
                cell.lblUnderLine.isHidden = false
            }
            
        }
        else
        {
            
            let dict = arrMaterialList[indexPath.row]
            cell.lblservice.text = String(format: "%@ x %@",dict.materialName, dict.materialQuantity)
            cell.lblAmount.text = String(format: "%@ %@",dict.currencyCode, dict.materialTotalPrice)
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0 && (self.arrServicesList.count > 0 || self.arrOtherServiceList.count > 0)
        {
            return 40
        }
        else if section == 1 && self.arrMaterialList.count > 0
        {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 && self.arrServicesList.count == 0 && self.arrOtherServiceList.count == 0
        {
            return nil
        }
        else if section == 1 && self.arrMaterialList.count == 0
        {
            return nil
        }
        
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: view1.frame.size.width - 40, height: 40))
        view1.backgroundColor = UIColor.clear
        
        label.text = section == 0 ? "Service Charges" : "Parts"
        label.textAlignment = NSTextAlignment.left
        
        label.tag = 25
        label.textColor = UserSettings.shared.themeColor2()
        label.font = UIFont.roboto(size: 14, weight: .Bold)
        view1.addSubview(label)
        
        return view1
    }
    
}
