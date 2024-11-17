//
//  SERVICE_LIST.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 11/12/20.
//

import UIKit
import Amplitude_iOS

class SERVICE_LIST: UIViewController,updateCustomerDelegate
{
    static func createwithnormalFlow(issueList: [Jobrequestitem],comeFrom:String,slotData:TimeSlot? = nil, proprtydata:PropertyList? = nil) -> SERVICE_LIST
    {
        let list = SERVICE_LIST.instantiate(fromImShStoryboard: .Home)
        list.strComeFrom = comeFrom
        list.propertyInfo = proprtydata
        list.slotInfo = slotData
        list.arrSelRequestItem = issueList
        return list
    }
    
    static func create(comeFrom:String,issueList: [Jobrequestitem]? = nil) -> UINavigationController? {
        let navc = ImShStoryboards.Profile.initialViewController() as? UINavigationController
        let list = SERVICE_LIST.instantiate(fromImShStoryboard: .Home)
        list.strComeFrom = comeFrom
        list.arrAllRequestItem = issueList ?? []
        navc?.setViewControllers([list], animated: true)
        return navc
    }


    
    //MARK: Outlets
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!


    @IBOutlet weak var viewCustomerInfo: UIView!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerPhone: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    
    @IBOutlet weak var imgArw1: UIImageView!
    @IBOutlet weak var imgArw2: UIImageView!

    
    @IBOutlet weak var viewpropertyInfo: UIView!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var lblProperty: UILabel!
    @IBOutlet weak var btnChangeProperty: UIButton!
    @IBOutlet weak var lblSelectService: UILabel!
    @IBOutlet weak var lblSelectAll: UILabel!
    @IBOutlet weak var viewSelectAll: UIView!
    @IBOutlet weak var btnSelectAll: UIButton!

    
    @IBOutlet weak var btnSchedule: UIButton!
    @IBOutlet weak var btnFixNow: UIButton!
    @IBOutlet weak var viewButtons: UIView!

    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var conTblServiceHeight: NSLayoutConstraint!
    
    
    
    // When coming from calendar selection
    @IBOutlet weak var viewBackHeader: UIView!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblserviceOn: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    // When no property has added or set default
    @IBOutlet weak var viewAddProperty: UIView!
    @IBOutlet weak var btnAddProperty: UIButton!
    
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var conviewTimerHeight: NSLayoutConstraint!

    var arrAllRequestItem = [Jobrequestitem]()
    var arrSelRequestItem = [Jobrequestitem]()


    // MARK: PRIVATE
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 60
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")


    private var navController : UINavigationController? = nil
    private let servicelisthandler = ServerServiceListTableHandler()
    var strComeFrom : String?
    var propertyId : Int?
    var propertyInfo : PropertyList?
    var slotInfo : TimeSlot!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        self.ImShSetLayout()
        self.setLabel()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        // Do any additio nal setup after loading the view.
        
        if arrAllRequestItem.count == 0 && strComeFrom != "calendar"
        {
            ServerRequest.shared.getJobListData(delegate: self) { response in
                
                self.arrAllRequestItem = response.data
                self.setdatainArray(issueList: self.arrAllRequestItem)
                
            } failure: { (errorMsg) in
                
            }
        }
        else
        {
            self.setdatainArray(issueList: self.arrAllRequestItem)
        }
        
    }
    
    func setdatainArray(issueList : [Jobrequestitem])
    {
        if strComeFrom == "calendar"
        {
            servicelisthandler.arrServices = self.arrSelRequestItem
        }
        else
        {
            servicelisthandler.arrServices = issueList
        }
        
        self.tblServices.estimatedRowHeight = 70
        self.tblServices.rowHeight = UITableView.automaticDimension
        
        self.tblServices.setUpTable(delegate: servicelisthandler, dataSource: servicelisthandler, cellNibWithReuseId: ServiceListCell.className)
        
        self.tblServices.reloadData()

        DispatchQueue.main.async {
            
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height
            self.tblServices.updateConstraints()
            self.tblServices.layoutIfNeeded()
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height

        }
        
        /// Handling actions
       
        servicelisthandler.SelectIssueClick = {(indexpath) in
            
            let arrFilter = self.servicelisthandler.arrServices.filter {$0.isSelected == 0}
            self.btnSelectAll.isSelected = (arrFilter.count == 0)
            
        }
        
        servicelisthandler.didSelect = {(indexpath) in
            
            self.tblServices.beginUpdates()
            self.tblServices.reloadData()
            self.tblServices.endUpdates()

            self.tblServices.updateConstraintsIfNeeded()
            self.tblServices.layoutIfNeeded()
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height

        }
        
        servicelisthandler.deleteTapped = {(indexpath) in
            
            let itemdata = self.servicelisthandler.arrServices[indexpath.row]
            
            ServerRequest.shared.removeJobitem(itemId: itemdata.id.toString(), delegate: self) {
                
                ServerRequest.shared.getJobListData(delegate: self) { response in
                    
                    self.arrAllRequestItem = response.data
                    if response.data.count == 0
                    {
                        self.dismiss(animated: true) {
                            let controller = UIApplication.topViewController()
                            if controller is HOME
                            {
                                let vc = controller as! HOME
                                vc.setData()
                                vc.bottomSheetShow(issueList: self.arrAllRequestItem)
                            }
                        }
                    }
                    else
                    {
                        self.setdatainArray(issueList: self.arrAllRequestItem)
                    }
                    
                } failure: { (errorMsg) in }
                
            } failure: { (errMsg) in
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
                                   
                }
            }

            
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setData()
    {
        let dict = UserSettings.shared.getUserCredential()
        
        let dict1 = UserSettings.shared.getContactUserCredential()
        
        if dict1["name"] as? String == ""
        {
            self.lblCustomerName.text = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
            self.lblCustomerPhone.text = String(format: "%@", dict["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
        }
        else
        {
            self.lblCustomerName.text = String(format: "%@", dict1["name"] as? String ?? "")
            self.lblCustomerPhone.text = String(format: "%@", dict1["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
        }

        
    }
    
    override func ImShSetLayout()
    {
        
        viewBackHeader.isHidden = true
        btnSubmit.isHidden = true
        servicelisthandler.strComeFrom = "list"
        self.conviewTimerHeight.constant = 0
        
        if strComeFrom == "calendar"
        {
//            self.callTimer()
//            self.conviewTimerHeight.constant = 90
            self.view.backgroundColor = UIColor.white
            viewBackHeader.isHidden = false
            btnSubmit.isHidden = false
            btnSchedule.isHidden = true
            btnFixNow.isHidden = true
            viewSelectAll.isHidden = true
            servicelisthandler.strComeFrom = ""
            btnChange.isHidden = true
            btnChangeProperty.isHidden = true
            imgArw1.isHidden = true
            imgArw2.isHidden = true
            
            // selected property
            
            if let info = propertyInfo
            {
                self.propertyId = info.id
                
                self.attributedAddress(strTitle: String(format: "%@\n", info.propertyName), strAddress: info.fullAddress)

                viewAddProperty.isHidden = true
            }
            
            let dateformat = DateFormatter()
            let strsheduleDate = String(format: "%@ %@", slotInfo.slotDate , slotInfo.slotTimeStart)
            dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let sheduleDate = dateformat.date(from: strsheduleDate)
            {
                dateformat.dateFormat = "d MMM yyyy, h:mm a"
                self.lbldate.text = dateformat.string(from: sheduleDate)
            }
            else
            {
                self.lbldate.text = String(format: "%@ %@", slotInfo.slotDate , slotInfo.slotTimeStart)
            }
            
        }
        else
        {
            
            let arrProprty = UserSettings.shared.arrPropertyList.filter{$0.isDefault == 1}
            if arrProprty.count > 0
            {
                self.propertyInfo = arrProprty[0]
                if let info = propertyInfo , info.geofenceRadarId != ""
                {
                    self.propertyId = info.id
                    self.attributedAddress(strTitle: String(format: "%@\n", info.propertyName), strAddress: info.fullAddress)
                    viewAddProperty.isHidden = true
                }
            }
        }
        
    }
    
    func setLabel()
    {
        lblProperty.text = "Property"
        lblTitle.text = "Issue List"
        btnChange.setTitle("CHANGE", for: .normal)
        btnChangeProperty.setTitle("CHANGE", for: .normal)
        lblSelectAll.text = "Select All"
        lblSelectService.text = (strComeFrom == "calendar") ? "Selected Issues" : "Select Issue"
        
        btnSchedule.setTitle("SCHEDULE", for: .normal)
        btnFixNow.setTitle(("Fix Now").uppercased(), for: .normal)
        
        
        lblserviceOn.text = "Schedule on"
        btnSubmit.setTitle("SUBMIT REQUEST", for: .normal)


    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnSchedule.titleLabel?.font?.pointSize
        {
            btnSchedule.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnFixNow.titleLabel?.font?.pointSize
        {
            btnFixNow.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnSubmit.titleLabel?.font?.pointSize
        {
            btnSubmit.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        if let aSize = btnChange.titleLabel?.font?.pointSize
        {
            btnChange.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        
        if let aSize = btnAddProperty.titleLabel?.font?.pointSize
        {
            btnAddProperty.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        
        if let aSize = btnChangeProperty.titleLabel?.font?.pointSize
        {
            btnChangeProperty.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: viewButtons.frame.size.width + shadowSize,
                                                   height: viewButtons.frame.size.height))
        viewButtons.layer.masksToBounds = false
        viewButtons.layer.shadowColor = UIColor.init(hex: "#F1F2F8").cgColor
        viewButtons.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewButtons.layer.shadowOpacity = 3
        viewButtons.layer.shadowRadius = 3
        viewButtons.layer.shadowPath = shadowPath.cgPath
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if strComeFrom == "calendar"
        {
            timer.invalidate()
        }
        
    }
    
    //MARK: customer delegate Methods
    
    func updateCustomerInfo(name: String, mobile: String) {
        
        self.lblCustomerName.text = name
        self.lblCustomerPhone.text = mobile
        
        UserSettings.shared.setContactUserCredential(strname: name, strMobile: mobile)
    }
    
    //MARK: Buttton Methods
    
    @IBAction func btnChangeCustomerClick(_ sender: Any) {
        
//        let signup = SIGNUP.create(strPhnNumber: "", isVerified: true, strCountryvalue: "", strFrom: "list")
//        self.navigationController?.pushViewController(signup, animated: true)
        
        let update = UPDATE_CUSTOMER_DATA.create(delegate: self)
        self.navigationController?.pushViewController(update, animated: true)

    }
    
    @IBAction func btnChangePropertyClick(_ sender: Any) {
        
        print("tapped")

        let propertyList = PROPERTY_LIST.create(strComeFrom: "list",delegate: self)
        self.navigationController?.pushViewController(propertyList, animated: true)
    }
    
    @IBAction func btnSelectAllClick(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected
        {
            var arrService1 =  servicelisthandler.arrServices
            
            for i in 0..<arrService1.count
            {
                let dict = arrService1[i]
                dict.isSelected = 1
                arrService1[i] = dict
            }
            
            servicelisthandler.arrServices = arrService1
            tblServices.reloadData()

        }
        else
        {
            var arrService1 =  servicelisthandler.arrServices
            
            for i in 0..<arrService1.count
            {
                let dict = arrService1[i]
                dict.isSelected = 0
                arrService1[i] = dict
            }
            
            servicelisthandler.arrServices = arrService1
            tblServices.reloadData()

        }

    }
    
    @IBAction func btnScheduleClick(_ sender: Any) {
        
        let arrSubmitServices = servicelisthandler.arrServices.filter{$0.isSelected == 1}

        if !viewAddProperty.isHidden
        {
            SnackBar.make(in: self.view, message: "Please add your property", duration: .lengthShort).show()
            return
        }
        else if arrSubmitServices.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select atlease one issue to proceed", duration: .lengthShort).show()
            return

        }
        
//        CommonFunction.shared.SaveArrayDatainTextFile(fileName: LocalFileName.service_sel.rawValue, arrData: arrSubmitServices)

        let schedule = CALENDER_TIME.create(issueList: arrSubmitServices, proprtydata: propertyInfo,customername: (self.lblCustomerName.text ?? ""),customerMobile: (self.lblCustomerPhone.text ?? ""))
        self.navigationController?.pushViewController(schedule, animated: true)

    }
    
    @IBAction func btnFixNowClick(_ sender: Any)
    {
        let arrSubmitServices = servicelisthandler.arrServices.filter{$0.isSelected == 1}

        if !viewAddProperty.isHidden
        {
            SnackBar.make(in: self.view, message: "Please add your property", duration: .lengthShort).show()
            return
        }
        else if arrSubmitServices.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select atlease one issue to proceed", duration: .lengthShort).show()
            return

        }
        
        ServerRequest.shared.GetServiceList(dictPara: [:], delegate: self) { (response) in
            
            let arrOtherServices = response.data.filter{$0.sapId == "S_OT0003"}
            
            if arrOtherServices.count > 0
            {
                let dictservice = arrOtherServices[0]
                let price = String(format: "%d", dictservice.price)

                let strmsg = String(format: "%@\n\n%@", "Are you sure you want to proceed with job request? This slot will add extra fix now charge in your job request." ,  "Fix Now Charges : AED \(price)")
                
                AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "Fix Now", aStrMessage: strmsg, aCancelBtnTitle: "No", aOtherBtnTitle: "Yes") { (index, title) in
                    
                    if title == "Yes"
                    {
                        self.CreateFixNowJR(fixnow: dictservice)
                    }
                }
            }
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
        
    }
        
    @IBAction func btnAddpropertyClick(_ sender: Any)
    {
        let propertyList = PROPERTY_LIST.create(strComeFrom: "list",delegate: self)
        self.navigationController?.pushViewController(propertyList, animated: true)
    }
    
    //MARK: list page, issue seelction
    @IBAction func btnCloseClick(_ sender: Any) {
        
        self.dismiss(animated: true) {
            let controller = UIApplication.topViewController()
            if controller is HOME
            {
                let vc = controller as! HOME
                vc.setData()
                vc.bottomSheetShow(issueList: self.arrAllRequestItem)
            }
        }
    }
    
    //MARK: confirmation page , from calendar screen
    
//    func SetBlockUnblockTimeslot(blocked : String)
//    {
//        if isSubmitted
//        {
//            return
//        }
//
//        ServerRequest.shared.BlockUnblockTimeSlot(slotId: slotInfo.id, blocked: blocked, delegate: self) { (success) in
//
//        } failure: { (errMsg) in
//
//            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
//
//            }
//        }
//
//    }

    
    @IBAction func btnBackClick(_ sender: Any) {
        
        self.navigationController?.pop()
        
        let controllers = self.navigationController?.viewControllers ?? []
        for viewCntrl  in controllers
        {
            if viewCntrl is CALENDER_TIME
            {
                let vc = viewCntrl as! CALENDER_TIME
                vc.getTimeSlots(selectedDate: vc.strSeldate)
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    @IBAction func btnSubmitClick(_ sender: Any)
    {
        let arrSubmitServices = self.arrSelRequestItem.filter{$0.isSelected == 1}
        
        var sapIds = [String:String]()
        for i in 0..<arrSubmitServices.count
        {
            let services = arrSubmitServices[i]
            sapIds["service_id_sap[\(i)]"] = services.jobservice.serviceIdSap
        }
        
        ServerRequest.shared.checkSlotAvailability(slot: slotInfo,sapId: sapIds, delegate:nil) { (response) in
            
//            if response.blockedByCustomer < response.availableEmployee
//            {
                if response.highDemandUtilization == true
                {
                    ServerRequest.shared.addOnServiceHighDemand(delegate: self) { (response1) in
                        
                        let strHighdemand = String(format: "High demand charges : %@ %@", response1.currencyCode, response1.price)

                        let strMsg = String(format: "%@\n\n%@", "Are you sure you want to proceed with selected slot on the job request? This slot will add extra high demand charge in your job request." , strHighdemand)
                        
                        AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "", aStrMessage:strMsg , aCancelBtnTitle: "CANCEL", aOtherBtnTitle: "CONFIRM") { (index, title) in
                            
                            if index == 1 // Confirm
                            {
                                self.checkConfiguration(highDemand: response1)
                            }
                            else
                            {
                                let controllers = self.navigationController?.viewControllers ?? []
                                for viewCntrl  in controllers
                                {
                                    if viewCntrl is CALENDER_TIME
                                    {
                                        let vc = viewCntrl as! CALENDER_TIME
                                        vc.getTimeSlots(selectedDate: vc.strSeldate)
                                        self.navigationController?.popToViewController(vc, animated: true)
                                        break
                                    }
                                }

                            }
                            
                        }

                    } failure: { (errorMsg) in
                        
                    }

                }
                else
                {
                    self.checkConfiguration(highDemand: Jobservice.init())
                }
                            
//            }
//
//            else
//            {
//                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Due to high demand , Slot is being full.", aOKBtnTitle: "OK") { (index, title) in
//                }
//            }
            
        } failure: { (errMsg) in
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
                
            }
        }
    }
   
    //MARK: Webservice Calling
    
    func checkConfiguration(highDemand: Jobservice)
    {
        ServerRequest.shared.checkforConfiguration(delegate: nil) { response in
            
            if !response.isEmpty
            {
                let skipLink = response["skip_generate_payment_link"] as? String ?? "0"
                let skipslot = response["enable_select_slot_skip"] as? String ?? "0"
                
                self.createJobRequest(skipPayment: skipLink, skipSlot: skipslot, highDemand: highDemand)
            }
            
        } failure: { (ErrMsg) in
            
        }
    }
    
    func createJobRequest(skipPayment : String , skipSlot : String,highDemand: Jobservice) // schedule job reuqest
    {
                
        let arrSubmitServices = servicelisthandler.arrServices.filter{$0.isSelected == 1}
        
        
        let dictServiceReq = AddService.init()
        dictServiceReq.customerId = Int(UserSettings.shared.getCustomerId())
        dictServiceReq.propertyId = propertyInfo?.id
        
        let dictUser = UserSettings.shared.getUserCredential()
        let title = dictUser["title"] as? String ?? ""

        if title == ""
        {
            dictServiceReq.customerName = self.lblCustomerName.text
        }
        else
        {
            dictServiceReq.customerName = String(format: "%@ %@", title , (self.lblCustomerName.text ?? ""))
        }
        
        dictServiceReq.customerMobile = self.lblCustomerPhone.text
        dictServiceReq.distributionChannel = "scheduled"
        dictServiceReq.additinalComment = ""
        dictServiceReq.status = 1  // requested
        dictServiceReq.subStatus = 2  // Awaiting Service Unit Assignment
        dictServiceReq.slotid = slotInfo.id.toString()
        dictServiceReq.slottime = slotInfo.slotTime
        dictServiceReq.slotdate = slotInfo.slotDate
        dictServiceReq.subsequentslotId = slotInfo.subsequentSlotId
        dictServiceReq.skipSlot = skipSlot
        dictServiceReq.skipPayment = skipPayment
        
        
        var dictIssueIds = [String:String]()

        for i in 0..<arrSubmitServices.count
        {
            let dict = arrSubmitServices[i]
            dictIssueIds["clone_issue_id[\(i)]"] = dict.id.toString()
        }
        
        print(dictIssueIds)
        print(dictServiceReq.toDictionary())
        
        ServerRequest.shared.CreateJobRequest(dictPara: dictServiceReq, dictIssueIds: dictIssueIds, delegate: self) { (response) in
            
            
            //------------------- log event ------------------
            
            let arrSubmitServices = self.arrSelRequestItem.filter{$0.isSelected == 1}
            let issuecategory = arrSubmitServices.map { String($0.items) }
            let issuecategoryIds = arrSubmitServices.map { String($0.jobcategory.name) }
            let issueCount = response.issueCount
            
            let issuecatIds = issuecategoryIds.joined(separator: ",")
            let issueTitles = issuecategory.joined(separator: ",")

            let dictPara = ["Job ID":response.id,
                            "Issue Count":issueCount,
                            "Issue Category":issuecatIds,
                            "Issue Title":issueTitles,
                            "Property ID":response.propertyId,
                            "Property Map Location":(self.propertyInfo?.gLocation ?? "") ,
                            "Property Geofence Location":(self.propertyInfo?.gLocation ?? "") ,
                            "Customer ID":UserSettings.shared.getCustomerId() ,
                            "Customer Property Count":"",
                            "App User ID":UserSettings.shared.getCustomerId(),
                            "Contact ID":"",
                            "Contact Type":""] as [String : Any]
            
            Amplitude.instance().logEvent("Job Request - submitted", withEventProperties: dictPara)
            //------------------------------------------------

            
            UserSettings.shared.removeSubmittedLocalStoredServices()

            if self.slotInfo.highDemandUtilization
            {
                self.addOnserviceFlow(jobreq: response,addOnservice : highDemand) // add on high demand service flow
            }
            else
            {
                let success = SERVICE_SUCESS.create(jobdata: response, fixNow: false)
                self.navigationController?.pushViewController(success, animated: true)
            }
            
        } failure: { (errMsg) in
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
                               
            }
        }
        
    }
    
    func CreateFixNowJR(fixnow:Servicelist)
    {
        self.isLoading(loading: true)
        ServerRequest.shared.checkforConfiguration(delegate: nil) { response in
            
            if !response.isEmpty
            {
                let skipLink = response["skip_generate_payment_link"] as? String ?? "0"
//                let skipslot = response["enable_select_slot_skip"] as? String ?? "0"
                
                let arrSubmitServices = self.servicelisthandler.arrServices.filter{$0.isSelected == 1}
                
                let dateFormat = DateFormatter()
                let todate = Date()
                dateFormat.dateFormat = "yyyy-MM-dd"
                let StrToday = dateFormat.string(from: todate)

                
                let dictServiceReq = AddService.init()
                dictServiceReq.customerId = Int(UserSettings.shared.getCustomerId())
                dictServiceReq.propertyId = self.propertyInfo?.id
                
                let dictUser = UserSettings.shared.getUserCredential()
                let title = dictUser["title"] as? String ?? ""

                if title == ""
                {
                    dictServiceReq.customerName = self.lblCustomerName.text
                }
                else
                {
                    dictServiceReq.customerName = String(format: "%@ %@", title , (self.lblCustomerName.text ?? ""))
                }
                
                dictServiceReq.customerMobile = self.lblCustomerPhone.text
                dictServiceReq.distributionChannel = "fixnow"
                dictServiceReq.additinalComment = ""
                dictServiceReq.status = 1  // requested
                dictServiceReq.subStatus = 2  // Awaiting Service Unit Assignment
                dictServiceReq.slotid = "corporate"
                dictServiceReq.slottime = "10:00 - 11:00"
                dictServiceReq.slotdate = StrToday
        //        dictServiceReq.subsequentslotId = slotInfo.subsequentSlotId
                dictServiceReq.skipSlot = "1"
                dictServiceReq.skipPayment = skipLink
                dictServiceReq.skipSlotFix = "1"
                
                var dictIssueIds = [String:String]()

                for i in 0..<arrSubmitServices.count
                {
                    let dict = arrSubmitServices[i]
                    dictIssueIds["clone_issue_id[\(i)]"] = dict.id.toString()
                }
                
                print(dictIssueIds)
                print(dictServiceReq.toDictionary())
                
                ServerRequest.shared.CreateJobRequest(dictPara: dictServiceReq, dictIssueIds: dictIssueIds, delegate: nil) { (response) in
                    
                    UserSettings.shared.removeSubmittedLocalStoredServices()
                    
                    self.addOnserviceFixNow(jobreq: response, addOnservice: fixnow)

                    
                } failure: { (errMsg) in
                    
                    self.isLoading(loading: true)

                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
                                       
                    }
                }
            }
            else
            {
                self.isLoading(loading: true)

            }
            
        } failure: { (ErrMsg) in
            
            self.isLoading(loading: true)

        }
    }
    
    func addOnserviceFlow(jobreq : JobIssueList,addOnservice: Jobservice)
    {
        print("kkkkkkkkkkkkkk \(jobreq.id.toString())")
        
        var dictPara = [String:String]()
        dictPara["job_request_id"] = jobreq.id.toString()
        dictPara["sap_id"] = addOnservice.serviceIdSap
        dictPara["service_id"] = addOnservice.id.toString()
        dictPara["service_name"] = addOnservice.serviceDescription
        dictPara["service_price"] = addOnservice.price
        dictPara["currency_code"] = addOnservice.currencyCode
        dictPara["service_quantity"] = "1"
        dictPara["created_by"] = UserSettings.shared.getCustomerId()
        dictPara["updated_by"] = UserSettings.shared.getCustomerId()
        
        print(dictPara)
        
        ServerRequest.shared.storeaddOnServices(dictPara: dictPara, service: "store-high-demand-service", delegate: self) {
            
            let success = SERVICE_SUCESS.create(jobdata: jobreq, fixNow: false)
            self.navigationController?.pushViewController(success, animated: true)
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
    }
    
    func addOnserviceFixNow(jobreq : JobIssueList,addOnservice: Servicelist)
    {
        print("kkkkkkkkkkkkkk \(jobreq.id.toString())")
        
        var dictPara = [String:String]()
        dictPara["job_request_id"] = jobreq.id.toString()
        dictPara["sap_id"] = addOnservice.sapId
        dictPara["service_id"] = addOnservice.id.toString()
        dictPara["service_name"] = addOnservice.name
        dictPara["service_price"] = addOnservice.price.toString()
        dictPara["currency_code"] = addOnservice.currencyCode
        dictPara["service_quantity"] = "1"
        dictPara["created_by"] = UserSettings.shared.getCustomerId()
        dictPara["updated_by"] = UserSettings.shared.getCustomerId()
        
        print(dictPara)
        
        ServerRequest.shared.storeaddOnServices(dictPara: dictPara, service: "store-fix-now-service", delegate: self) {

            DispatchQueue.main.async {
                
                self.isLoading(loading: true)

                let success = SERVICE_SUCESS.create(jobdata: jobreq, fixNow: true)
                self.navigationController?.pushViewController(success, animated: true)

            }
            
        } failure: { (errorMsg) in
            
            self.isLoading(loading: true)

            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
    }
    
    //MARK: Timer
    
    func callTimer()
    {
        drawBgShape()
        drawTimeLeftShape()
//         here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = 60
//         add the animation to your timeLeftShapeLayer
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
//         define the future end time by adding the timeLeft to now Date()
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: 20 , y: 20), radius:
            10, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.white.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        viewTimer.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: 20 , y: 20), radius:
            10, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UserSettings.shared.themeColor().cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 20
        viewTimer.layer.addSublayer(timeLeftShapeLayer)
    }
   
    @objc func updateTime()
    {
        if timeLeft > 0
        {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            lblTimer.text = timeLeft.time
        }
        else
        {
            lblTimer.text = "00"
            lblTimer.isHidden = true
            viewTimer.isHidden = true
            timer.invalidate()
            conviewTimerHeight.constant = 0
        }
    }
}
//extension TimeInterval {
//    var time: String {
//        return String(format:"%02d",  Int(ceil(truncatingRemainder(dividingBy: 60))) )
//    }
//}
extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}


extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

//MARK: Property select delegate
extension SERVICE_LIST : selectPropertyDelegate
{
    func dataSelected(dict: PropertyList) {
        
        if dict.geofenceRadarId == ""
        {
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Sorry, our services are currently unavailable in your location. We shall notify you when we start providing services there.", aOKBtnTitle: "OK") { (index, title) in
            }
            
            return
        }
        
        self.propertyInfo = dict
        self.propertyId = dict.id
        
        self.attributedAddress(strTitle: String(format: "%@\n", dict.propertyName), strAddress: dict.fullAddress)
        
        self.viewAddProperty.isHidden = true
    }
    
    
    func attributedAddress(strTitle : String , strAddress : String)
    {
        
        let yourAttributes = [
            NSAttributedString.Key.font: UIFont.roboto(size: 14, weight: .Regular)]
        
        let yourOtherAttributes = [
            NSAttributedString.Key.font: UIFont.roboto(size: 12, weight: .Bold)]
        
        let partOne = NSMutableAttributedString(string: strAddress, attributes: yourAttributes as [NSAttributedString.Key : Any])
        let partTwo = NSMutableAttributedString(string: strTitle, attributes: yourOtherAttributes as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        
        combination.append(partTwo)
        combination.append(partOne)
        
        lbladdress.attributedText = combination
    }
    
}
extension SERVICE_LIST : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
