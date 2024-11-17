//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class QuotationMainListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    
    var didSelect: ((IndexPath) -> Void)? = nil
    var SelectServiceClick: ((IndexPath,Bool) -> Void)? = nil
    var arrServices = [JobQuotationData]()
    var arrOtherServiceList = [Jobotherservice]()

    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count + arrOtherServiceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuotationCell.className, for: indexPath) as! QuotationCell
        
        if arrServices.count - 1 >= indexPath.row && arrServices.count > 0
        {
            let dict = arrServices[indexPath.row]
            cell.lblName.text = dict.jobRequestItemData.items
            
            cell.imgArw.isHidden = false
            cell.imgStatusIcon.isHidden = false

            cell.lblPrice.text = String(format: "%@ %d", dict.currencyCode, dict.sum)
            
            cell.imgStatusIcon.image = CommonFunction.shared.setIssueStatusIcon(status: dict.jobRequestItemData.status)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
            tapGesture.numberOfTapsRequired = 1
            cell.imgStatusIcon.tag = indexPath.row
            cell.imgStatusIcon.isUserInteractionEnabled = true
            cell.imgStatusIcon.addGestureRecognizer(tapGesture)
            cell.imgStatusIcon.contentMode = .scaleToFill

            cell.ImShSetLayout()
            cell.superTblIndexpath = indexPath
            
            // service list table handling
            if dict.serviceData.count > 0
            {
                cell.quotationlisthandler.arrServices = dict.serviceData
            }
            else
            {
                cell.quotationlisthandler.arrServices = []
            }
            
            let arr = cell.quotationlisthandler.arrServices.filter{$0.isSelected == 1}

            if dict.isSelected == 0 || (dict.isSelected == 1 && arr.count == 0) || (dict.isSelected == 1 && dict.jobRequestItemData.status == 8)
            {
                cell.btnSelect.isSelected = false
            }
            else
            {
                cell.btnSelect.isSelected = true
            }
            
            if (dict.jobRequestItemData.status == 8)
            {
                cell.btnSelect.alpha = 0
            }
            
            cell.tblPartList.reloadData()
            cell.tblPartList.updateConstraintsIfNeeded()
            cell.tblPartList.layoutIfNeeded()
            
            var height : CGFloat = 0
            for dictdata in cell.quotationlisthandler.arrServices
            {
                 height = height + CGFloat(dictdata.data.count * 50) + 90 + CGFloat((dictdata.recommended == 1) ? (25 + 10) : 0)
            }
            
            cell.contblPartListHeight.constant = height //cell.tblPartList.contentSize.height

            
            //------------------------------------------------------
            
            if dict.isExpand == 1
            {
                cell.imgArw.image = UIImage(named: "Up")
                cell.tblPartList.isHidden = false
            }
            else
            {
                cell.imgArw.image = UIImage(named: "Down")
                cell.tblPartList.isHidden = true
            }
            
            
            cell.btnSelect.tag = indexPath.item
            cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)
            cell.isUserInteractionEnabled = true

        }
        else
        {
            let dict = arrOtherServiceList[indexPath.row - arrServices.count]
            cell.lblName.text = dict.serviceName
            cell.lblPrice.text = String(format: "%@ %@",dict.currencyCode, dict.serviceTotalPrice)
            cell.imgArw.isHidden = true
            cell.btnSelect.isSelected = true
            cell.isUserInteractionEnabled = false
            cell.imgStatusIcon.isHidden = true
            cell.tblPartList.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        if isSelectAvailable == false // while timer is one for awaiting approval
//        {
//            return
//        }
        
        let dict = arrServices[indexPath.row]
        if dict.jobRequestItemData.status == 8
        {
            return
        }
        
        if arrServices.count - 1 >= indexPath.row && arrServices.count > 0
        {
            if dict.isExpand == 0
            {
                dict.isExpand = 1
            }
            else
            {
                dict.isExpand = 0
            }
            arrServices[indexPath.row] = dict
            self.didSelect?(indexPath)

        }

    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if arrServices.count - 1 >= indexPath.row && arrServices.count > 0
        {
//            return UITableView.automaticDimension
            let dict = arrServices[indexPath.row]
            
            if dict.isExpand == 0
            {
                return 60
            }

            var height : CGFloat = 0.0
            for dictdata in dict.serviceData
            {
                 height = height + CGFloat(dictdata.data.count * 50) + 90 + CGFloat((dictdata.recommended == 1) ? (25 + 10) : 0)
            }
            
           return height + 60

        }
        else
        {
            return 60
        }
        
    }
    
    //MARK:- Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        
        let dict = arrServices[btn.tag]
        if dict.jobRequestItemData.status == 8
        {
            return
        }
        
        if arrServices.count - 1 >= btn.tag && arrServices.count > 0
        {
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
        
    }
    
    
    
    //MARK:- Gesture Methods
    @objc func tapGesture(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let dict = arrServices[img.tag]
            
            let status = UserSettings.shared.initialData.issueStatusList.filter{$0.id == dict.jobRequestItemData.status}
            
            if status.count > 0
            {
                let pop = PopOverView.create(status: status[0].name, sender: img)
                
                pop.modalPresentationStyle = .popover
                // set up the popover presentation controller
                pop.popoverPresentationController?.delegate = self
                pop.popoverPresentationController?.permittedArrowDirections = .down
                pop.popoverPresentationController?.sourceView = img // button

                let vc = UIApplication.topViewController()
                vc?.present(pop, animated: true, completion: nil)

            }
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        // Force popover style

        return UIModalPresentationStyle.none
    }

}
