//
//  HELP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit
import SkyFloatingLabelTextField

class HELP: UIViewController {
    
    static func create() -> HELP {
        return HELP.instantiate(fromImShStoryboard: .Profile)
    }
    
    
    @IBOutlet weak var lblManageYourServiceOrders : UILabel!
    @IBOutlet weak var lblDoyouneedhelpwith: UILabel!
    @IBOutlet weak var lblWanttoReachUsforMoreHelp: UILabel!
    @IBOutlet weak var txtEmailCustomerCare: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCallCustomerCare: SkyFloatingLabelTextField!
    @IBOutlet weak var txtWebsite: SkyFloatingLabelTextField!

    @IBOutlet weak var viewManageServiceOrders: UIView!
    @IBOutlet weak var viewNeedHelp: UIView!
    @IBOutlet weak var tblServiceOdr: UITableView!
    @IBOutlet weak var tblNeedHelp: UITableView!
    @IBOutlet var contblServiceOrderHeight: NSLayoutConstraint!
    @IBOutlet var contblNeedhelpHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnWebsite: UIButton!

    
    var arrNeedHelp = [[String:Any]]()
    var arrServiceOrder = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Help"
        }
        
        setLabel()
        self.ImShSetLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()
        
    }
    
    func setLabel()
    {
        txtEmailCustomerCare.placeholder = "Email Customer Care"
        txtCallCustomerCare.placeholder = "Call Customer Care"
        
        txtEmailCustomerCare.text = "care@homefinch.com"
        txtCallCustomerCare.text = "+971 600 566663"
        
        txtWebsite.placeholder = "Visit Us"
        txtWebsite.text = "www.homefinch.com"
        
        txtCallCustomerCare.titleFont = UIFont.roboto (size: 12)!
        txtEmailCustomerCare.titleFont = UIFont.roboto(size: 12)!
        
        txtEmailCustomerCare.font = UIFont.roboto(size: 14, weight: .Medium)
        txtCallCustomerCare.font = UIFont.roboto(size: 14, weight: .Medium)
        
        txtWebsite.titleFont = UIFont.roboto (size: 12)!
        txtWebsite.font = UIFont.roboto(size: 14, weight: .Medium)


    }
    
    
    override func ImShSetLayout()
    {
        arrServiceOrder = [["title":"#service658485969","noofservice":"2service","status":"Completed"],["title":"Your Service Orders","noofservice":"","status":""]]
        
        arrNeedHelp = [["title":"Help Topic"],["title":"Help Topic"],["title":"Help Topic"]]
        
        
        tblNeedHelp.register(delegate: self, dataSource: self, cellNibWithReuseId: HelpCell.className)
        
        tblServiceOdr.register(delegate: self, dataSource: self, cellNibWithReuseId: HelpCell.className)
        
        
        contblServiceOrderHeight.constant = 0// CGFloat(arrServiceOrder.count * 60)
        self.tblServiceOdr.needsUpdateConstraints()
        self.tblServiceOdr.layoutIfNeeded()
        
        
        contblNeedhelpHeight.constant = 0 //CGFloat(arrNeedHelp.count * 60)
        self.tblNeedHelp.needsUpdateConstraints()
        self.tblNeedHelp.layoutIfNeeded()
    }
    
    //    MARK: Button Methods
   
    @IBAction func btnEmailClick(_ sender: Any)
    {
        let mail = String(format: "mailto:care@homefinch.com?subject=&body=")
        if let url = URL(string: mail.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    @IBAction func btnCallClick(_ sender: Any)
    {
        let customerPhn = "+971600566663"
        if let url = URL(string: "tel://\(customerPhn)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnWebsiteClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if let url = URL(string: "https://www.homefinch.com") {
            UIApplication.shared.open(url)
        }
    }
    
}
extension HELP: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblServiceOdr
        {
            return arrServiceOrder.count
        }
        else
        {
            return arrNeedHelp.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpCell.className, for: indexPath) as! HelpCell
        
        if tableView == tblServiceOdr
        {
            let dict = arrServiceOrder[indexPath.row]
            cell.lblTitle.text = dict["title"] as? String
            cell.lblNoofService.text = dict["noofservice"] as? String
            if dict["status"]as! String != ""
            {
                cell.lblStatus.text = dict["status"] as? String
                cell.imgRightSide.isHidden = true
            }
            else
            {
                cell.lblStatus.text = ""
                cell.imgRightSide.isHidden = false
            }
            
        }
        else
        {
            let dict = arrNeedHelp[indexPath.row]
            cell.lblTitle.text = String(format: "%@ %d",dict["title"] as? String ?? "" , indexPath.row + 1)
            cell.lblNoofService.isHidden = true
            cell.lblStatus.isHidden = true
            cell.imgRightSide.isHidden = false
        }

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
