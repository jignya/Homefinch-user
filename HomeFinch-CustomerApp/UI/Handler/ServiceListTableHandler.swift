//
//  ServiceListTableHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class ServiceListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var arrServices = [[String:Any]]()
    var didSelect: ((IndexPath) -> Void)? = nil
    var SelectIssueClick: ((IndexPath) -> Void)? = nil  // for service_listing
    var CancelIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming
    var EditIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming

        
    var strComeFrom :String = ""


    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceListCell.className, for: indexPath) as! ServiceListCell
        
        cell.imgArw.image = UIImage(named: "Down")
        cell.btnSelect.isHidden = true

        let dict = arrServices[indexPath.row]
        cell.lblName.text = dict["issueName"] as? String //"AC making Noise"
        cell.lblDesc.text = dict ["comments"] as? String
        cell.images = dict["images"] as? [[String:Any]] ?? []
        cell.strcomeFrom = strComeFrom
        cell.ImShSetLayout()
        
        if strComeFrom == "list" // added issue - service list screen
        {
            cell.btnSelect.isHidden = false
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)
            
            if dict["isSelected"] as? String == "1"
            {
                cell.btnSelect.isSelected = true
            }
            else
            {
                cell.btnSelect.isSelected = false
            }
        }
        
        if dict["isExpand"] as? String == "1"
        {
            cell.imgArw.image = UIImage(named: "Up")
            cell.viewImages.isHidden = (cell.images.count == 0)
            cell.viewDesc.isHidden = false
        }
        else
        {
            cell.imgArw.image = UIImage(named: "Down")
            cell.viewImages.isHidden = true
            cell.viewDesc.isHidden = true
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! ServiceListCell

        var dict = arrServices[indexPath.row]
        
        if dict["isExpand"] as? String == "0"
        {
            dict["isExpand"] = "1"
            cell.imgArw.image = UIImage(named: "Up")
            cell.viewImages.isHidden = false
            cell.viewDesc.isHidden = false
        }
        else
        {
            dict["isExpand"] = "0"

            cell.imgArw.image = UIImage(named: "Down")
            cell.viewImages.isHidden = true
            cell.viewDesc.isHidden = true
        }
        
        arrServices[indexPath.row] = dict
        tableView.reloadRows(at: [indexPath], with: .none )
//        tableView.beginUpdates()
//        tableView.endUpdates()
        self.didSelect?(indexPath)
        
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
//    {
//        let cell = tableView.cellForRow(at: indexPath) as! ServiceListCell
//        cell.imgArw.image = UIImage(named: "Down")
//        cell.viewImages.isHidden = true
//        cell.viewDesc.isHidden = true
//
//        tableView.beginUpdates()
//        tableView.endUpdates()
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        
        var dict = arrServices[indexpath.row]
        
        if btn.isSelected
        {
            dict["isSelected"] = "1"
        }
        else
        {
            dict["isSelected"] = "0"
        }
        
        arrServices[indexpath.row] = dict
        self.SelectIssueClick?(indexpath)
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
    
}
