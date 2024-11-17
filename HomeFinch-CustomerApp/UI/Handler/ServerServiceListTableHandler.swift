//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class ServerServiceListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource ,UIPopoverPresentationControllerDelegate{
    
    var arrServices = [Jobrequestitem]()
    var didSelect: ((IndexPath) -> Void)? = nil
    var SelectIssueClick: ((IndexPath) -> Void)? = nil  
    var CancelIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming
    var EditIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming
    var deleteTapped: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming

        
    var strComeFrom :String = ""
    var isEditable :Bool = false


    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceListCell.className, for: indexPath) as! ServiceListCell
        
        cell.imgArw.image = UIImage(named: "Down")
        cell.btnSelect.isHidden = true
        cell.btnFollowUp.isHidden = true
        
        let dict = arrServices[indexPath.row]
        cell.lblName.text = dict.items
        cell.lblDesc.text = dict.descriptionField
        
        cell.imgStatusIcon.image = CommonFunction.shared.setIssueStatusIcon(status: dict.status)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 1
        cell.imgStatusIcon.tag = indexPath.row
        cell.imgStatusIcon.isUserInteractionEnabled = true
        cell.imgStatusIcon.addGestureRecognizer(tapGesture)

        
        cell.strcomeFrom = "joblist"
        cell.images.removeAll()
        for attachment in dict.jobitemsattachments
        {
            var dictimage = [String:Any]()
            dictimage["id"] = attachment.id
            dictimage["path"] = attachment.path
            dictimage["job_request_id"] = attachment.jobRequestId
            cell.images.append(dictimage)
        }
        
        cell.ImShSetLayout()
        
        if strComeFrom == "list" // added issue - service list screen
        {
            cell.btnSelect.isHidden = false
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)
            
            if dict.isSelected == 1
            {
                cell.btnSelect.isSelected = true
            }
            else
            {
                cell.btnSelect.isSelected = false
            }
        }

        if dict.isExpand == 1
        {
            cell.imgArw.image = UIImage(named: "Up")
            cell.viewImages.isHidden = (cell.images.count == 0)
            cell.viewDesc.isHidden = (dict.descriptionField.count == 0)
            cell.viewButtons.isHidden = !isEditable
            cell.viewDelete.isHidden = false
        }
        else
        {
            cell.imgArw.image = UIImage(named: "Down")
            cell.viewButtons.isHidden = true
            cell.viewDesc.isHidden = true
            cell.viewImages.isHidden = true
            cell.viewDelete.isHidden = true
        }
        
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(BtnDeleteClick(_:)), for: .touchUpInside)

        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(BtnEditClick(_:)), for: .touchUpInside)

        cell.btnCancel.tag = indexPath.row
        cell.btnCancel.addTarget(self, action: #selector(BtnCancelClick(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = arrServices[indexPath.row]
        
        if dict.isExpand == 0
        {
            dict.isExpand = 1
        }
        else
        {
            dict.isExpand = 0
        }
        
        arrServices[indexPath.row] = dict
        tableView.reloadRows(at: [indexPath], with: .none)
        self.didSelect?(indexPath)
        
    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.deleteTapped?(indexPath)
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dict = arrServices[indexPath.row]
        if dict.status == 11
        {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    
    //MARK: Button Methods
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        
        let dict = arrServices[indexpath.row]
        
        if btn.isSelected
        {
            dict.isSelected = 1
        }
        else
        {
            dict.isSelected = 0
        }
        
        arrServices[indexpath.row] = dict
        self.SelectIssueClick?(indexpath)
    }
   
    @objc func BtnDeleteClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.deleteTapped?(indexpath)
    }
    
    @objc func BtnCancelClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.CancelIssueClick?(indexpath)
    }
    
    @objc func BtnEditClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.EditIssueClick?(indexpath)
    }
    
    //MARK: Gesture Methods
    @objc func tapGesture(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let dict = arrServices[img.tag]
            
            let status = UserSettings.shared.initialData.issueStatusList.filter{$0.id == dict.status}
            
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
