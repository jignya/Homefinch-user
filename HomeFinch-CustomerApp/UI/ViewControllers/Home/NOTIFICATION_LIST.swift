//
//  NOTIFICATION_LIST.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 10/12/20.
//

import UIKit

class NOTIFICATION_LIST: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static func create() -> UINavigationController? {
        let navc = ImShStoryboards.Home.initialViewController() as? UINavigationController
        let list = NOTIFICATION_LIST.instantiate(fromImShStoryboard: .Home)
        navc?.modalPresentationStyle = .fullScreen
        navc?.navigationBar.isHidden = true
        navc?.setViewControllers([list], animated: true)
        return navc
    }
       
    //MARK: - Outlets

    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var lblNodata1: UILabel!
    
    var arrList = [NotificationList]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        tblList.estimatedRowHeight = 100
        tblList.rowHeight = UITableView.automaticDimension
        
        tblList.register(delegate: self, dataSource: self, cellNibWithReuseId: NotificationCell.className)

        viewEmpty.isHidden = true
        lblNodata1.isHidden = true
        btnClear.isHidden = true
        
        setLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.GetNotiifcationList()

    }
    
    func setLabel()
    {
        lblTitle.text = "Notifications"
    }
    
    //MARK: - Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        cell.viewTitle.isHidden = true
        cell.imgArw.isHidden = false

        cell.lblName.textColor = UserSettings.shared.themeColor2()

        cell.lblName.text = self.arrList[indexPath.row].messageContent.descriptionField
        
        if  self.arrList[indexPath.row].messageContent.redirectUrlId == "" && self.arrList[indexPath.row].messageContent.subStatus == ""
        {
            cell.imgArw.isHidden = true
        }
        
        if self.arrList[indexPath.row].isRead == 2
        {
            cell.lblName.font = UIFont.roboto(size: 14, weight: .Regular)
        }
        else
        {
            cell.lblName.font = UIFont.roboto(size: 14, weight: .Medium)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = self.arrList[indexPath.row].messageContent
        
        let dict1 = self.arrList[indexPath.row]
        
        if dict1.isRead != 2
        {
            let dictData = ["receiver_id":UserSettings.shared.getCustomerId(),"user_type":"1","is_read":"2","ids[0]" : dict1.id.toString()] as [String : String]
            ServerRequest.shared.updateNotificationReadStatus(dictPara: dictData, delegate: self) {
                
                
            } failure: { (errorMsg) in
            }
        }
        
        if dict?.redirectUrlId != "" && dict?.subStatus != ""
        {
            let jobId = dict?.redirectUrlId ?? ""
//            let status = dict?.subStatus ?? ""
            let JRId = Int(jobId) ?? 0
            
            ServerRequest.shared.getJobRequestStatus(jobId: JRId, delegate: self) { response in
                
                let dict = response["data"] as? [String:Any] ?? [:]
                let JRstatus = dict["sub_status"] as? Int ?? 0
                if JRstatus <= 14
                {
                    let detail = JOB_UPCOMING_DETAIL.create(data: nil, comeFrom: "pushnot", jobId: JRId)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
                else
                {
                    let detail = JOB_PAST_DETAIL.create(data: nil, comeFrom: "pushnot", iscancelService: false, jobId: JRId)
                    self.navigationController?.pushViewController(detail, animated: true)
                }

                
            } failure: { (errorMsg) in
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    //MARK: -Button Methods
   
    @IBAction func btnClearClick(_ sender: Any) {
        AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "", aStrMessage: "Are you sure you want to clear notification?", aCancelBtnTitle: "NO", aOtherBtnTitle: "YES", completion: { (index, title) in
            
            if index == 1
            {
                ServerRequest.shared.ClearNotificationList(delegate: self) {
                    
                    self.GetNotiifcationList()

                } failure: { (errorMsg) in
                }
            }
        })
    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -web service
    
    func GetNotiifcationList()
    {
        ServerRequest.shared.GetNotificationList(delegate: self) { (response) in
            self.btnClear.isHidden = true

            self.arrList = response.list
            if self.arrList.count > 0
            {
                self.tblList.isHidden = false
                self.viewEmpty.isHidden = true
                self.btnClear.isHidden = false
                self.tblList.reloadData()
            }
            else
            {
                self.tblList.isHidden = true
                self.viewEmpty.isHidden = false
            }
            
        } failure: { (errorMsg) in
            self.tblList.isHidden = true
            self.viewEmpty.isHidden = false
        }
    }
}
extension NOTIFICATION_LIST : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
