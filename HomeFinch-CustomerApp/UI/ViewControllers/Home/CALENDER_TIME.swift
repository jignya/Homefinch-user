//
//  CALENDER_TIME.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 15/12/20.
//

import UIKit
import FSCalendar

class CALENDER_TIME: UIViewController, FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
    static func create(issueList: [Jobrequestitem] ,proprtydata:PropertyList? = nil,customername:String,customerMobile:String) -> CALENDER_TIME {
        
        let calender = CALENDER_TIME.instantiate(fromImShStoryboard: .Home)
        calender.propertyInfo = proprtydata
        calender.arrSelRequestItem = issueList
        calender.customerName = customername
        calender.customerMobile = customerMobile
        
        return calender
    }
    
    //MARK:Outlets
    
    @IBOutlet weak var viewCalendar: FSCalendar!
    @IBOutlet weak var conviewCalendarHeight: NSLayoutConstraint!
    @IBOutlet weak var tblTimeSlot: UITableView!
    @IBOutlet weak var conviewTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lbltimeSlot: UILabel!
    @IBOutlet weak var conButtonViewBottom: NSLayoutConstraint!
    @IBOutlet weak var conViewsafeAreaHeight: NSLayoutConstraint!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnFixNow: UIButton!

    @IBOutlet weak var lblNotimeSlot: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var viewNoSlot: UIView!
    
    @IBOutlet weak var viewMonth: UIView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!

    

    var bottomPadding : CGFloat = 0
    
    //MARK: Private
    private let timeSlothandler = TimeSlotTableHandler()
    var propertyInfo : PropertyList?
    var slotInfo : TimeSlot?
    var arrSelRequestItem = [Jobrequestitem]()
    
    var arrDays = [String]()
    var strMonth : String = ""

    var strSeldate : String = ""

    var customerName : String = ""
    var customerMobile : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.customSetting()
        
        setlayout()
        setLabel()
        
        let dateF = DateFormatter()
        dateF.dateFormat = "MM"
        
        let strMonth = dateF.string(from: Date())
        self.getavailableDays(Month: Int(strMonth) ?? 00)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.view.backgroundColor = UIColor.white
        
    }
    
    func setLabel()
    {
        lbltimeSlot.text = "Time slots"
        lblNotimeSlot.text = "Sorry! No Time Slots Available"
        lblInfo.text = "No time slot available with selected date. Please select other date to book a slot."
        lblOr.text = "OR"
        btnConfirm.setTitle("CONFIRM & DONE", for: .normal)
        btnFixNow.setTitle(("Fix Now").uppercased(), for: .normal)

    }
    
    override func viewWillLayoutSubviews()
    {
        // shadow effect bottom view
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.viewButton.frame.size.width + shadowSize,
                                                   height: self.viewButton.frame.size.height + shadowSize))
        self.viewButton.layer.masksToBounds = false
        self.viewButton.layer.shadowColor = UIColor.init(hex: "#F1F2F8").cgColor
        self.viewButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewButton.layer.shadowOpacity = 3
        self.viewButton.layer.shadowRadius = 3
        self.viewButton.layer.shadowPath = shadowPath.cgPath
        
        //------------------------
        
        if let aSize = btnConfirm.titleLabel?.font?.pointSize
        {
            btnConfirm.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        if let aSize = btnFixNow.titleLabel?.font?.pointSize
        {
            btnFixNow.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        nxtBtn.imageView?.contentMode = .scaleAspectFit
        preBtn.imageView?.contentMode = .scaleAspectFit
    }
    
    
    func setlayout()
    {
        self.viewNoSlot.alpha = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
        }

//        self.conViewsafeAreaHeight.constant = bottomPadding + 10
        self.conButtonViewBottom.constant = -(80 + bottomPadding)
        self.tblTimeSlot.setUpTable(delegate: timeSlothandler, dataSource: timeSlothandler, cellNibWithReuseId: TimeCell.className)
        
        self.conviewTableHeight.constant = 240 // self.tblTimeSlot.contentSize.height + 50
        self.tblTimeSlot.updateConstraintsIfNeeded()
        self.tblTimeSlot.layoutIfNeeded()
        
        
        /// Handling actions
        
        timeSlothandler.didSelect = {(indexpath) in
            
            self.slotInfo = self.timeSlothandler.TimeSlots[indexpath.row]
            
            UIView.animate(withDuration: 0.5) {
                self.conButtonViewBottom.constant = 0
//                self.viewButton.superview?.layoutIfNeeded()
            }
        }
        
        
    }
    
    
    //MARK: Calendar Methods
    
    func customSetting()
    {
        viewCalendar.delegate = self
        viewCalendar.dataSource = self
        
        viewCalendar.appearance.caseOptions = .weekdayUsesUpperCase
        viewCalendar.appearance.headerTitleAlignment = .right
        
        viewCalendar.scrollDirection = .vertical
        viewCalendar.allowsMultipleSelection = false
        viewCalendar.appearance.headerTitleFont = UIFont.roboto(size: 20.0, weight: .Bold)
        viewCalendar.appearance.headerMinimumDissolvedAlpha = 0
        viewCalendar.appearance.weekdayFont = UIFont.roboto(size: 12.0, weight: .Medium)
        viewCalendar.appearance.titleFont = UIFont.roboto(size: 14.0, weight: .Regular)
        
        viewCalendar.appearance.titlePlaceholderColor = UIColor.darkGray.withAlphaComponent(0.6)
        viewCalendar.headerHeight = 0
        viewCalendar.scrollEnabled = false
        viewCalendar.pagingEnabled = false
        viewCalendar.rowHeight = 50
        viewCalendar.scope = .month
        viewCalendar.placeholderType = .fillHeadTail
        
        viewCalendar.adjustsBoundingRectWhenChangingMonths = true
        
        
    /*    let stackview = UIStackView(frame: CGRect(x: viewCalendar.frame.size.width - 30, y: 0, width: 25 , height: 50))
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.alignment = .center
        stackview.spacing = 5.0
        stackview.backgroundColor = .red
        
        nxtBtn = UIButton(type: .custom)
        //        let nxtBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25 , height: 25))
        nxtBtn.backgroundColor = UIColor.clear
        nxtBtn.setImage(UIImage(named: "Up"), for: .normal)
        nxtBtn.addTarget(self, action: #selector(btnNxtClick(_:)), for: .touchUpInside)
        nxtBtn.translatesAutoresizingMaskIntoConstraints = false
        
        preBtn = UIButton(type: .custom)
        //        preBtn = UIButton(frame: CGRect(x: 0, y: 25, width: 25, height: 25))
        preBtn.backgroundColor = UIColor.clear
        preBtn.setImage(UIImage(named: "Down"), for: .normal)
        preBtn.addTarget(self, action: #selector(btnPreviousClick(_:)), for: .touchUpInside)
        preBtn.translatesAutoresizingMaskIntoConstraints = false
        
        stackview.addArrangedSubview(nxtBtn)
        stackview.addArrangedSubview(preBtn)
        viewCalendar.addSubview(stackview) */
        preBtn.isHidden = true
        
        //------------------- initial set date for tomorrow for slot data ----------------------
        self.setInitialDate()
    }
    
    func setInitialDate()
    {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "yyyy-MM-dd"
        strSeldate  = dateFormatt.string(from: Date().addingTimeInterval((TimeInterval(1*24*60*60))))
        
        self.viewCalendar.today = Date().addingTimeInterval((TimeInterval(1*24*60*60)))
        self.viewCalendar.select(Date().addingTimeInterval((TimeInterval(1*24*60*60))))
        
        //--------------- getting timeslot dynamically --------------------------
        
        self.getTimeSlots(selectedDate: strSeldate)
        
        let todate = dateFormatt.date(from: strSeldate)
        dateFormatt.dateFormat = "MMM, yyyy"
        lblMonth.text = dateFormatt.string(from: todate!)

    }
    
    @IBAction func btnPreviousClick(_ sender: Any)
    {
        let current = viewCalendar.currentPage
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: current)
        viewCalendar.setCurrentPage(previousMonth!, animated: true)
        
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = "MM/yyyy"
        
        if (dateFormat1.string(from: Date().addingTimeInterval((TimeInterval(1*24*60*60))))) == (dateFormat1.string(from: previousMonth!))
        {
            preBtn.isHidden = true
        }
        else
        {
            preBtn.isHidden = false
        }
        
        let dateF = DateFormatter()
        dateF.dateFormat = "MM"
        
        strMonth = dateF.string(from: previousMonth!)
        self.getavailableDays(Month: Int(strMonth) ?? 00)
        
        dateF.dateFormat = "MMM, yyyy"
        lblMonth.text = dateF.string(from: previousMonth!)
    }
    
    @IBAction func btnNxtClick(_ sender: Any)
    {
        let current = viewCalendar.currentPage
        let nextmonth = Calendar.current.date(byAdding: .month, value: 1, to: current)
        viewCalendar.setCurrentPage(nextmonth!, animated: true)
        preBtn.isHidden = false
        
        let dateF = DateFormatter()
        dateF.dateFormat = "MM"

        strMonth = dateF.string(from: nextmonth!)
        self.getavailableDays(Month: Int(strMonth) ?? 00)
        
        dateF.dateFormat = "MMM, yyyy"
        lblMonth.text = dateF.string(from: nextmonth!)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        print(date)
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "yyyy-MM-dd"
        strSeldate  = dateFormatt.string(from: date)
        self.slotInfo = nil
        
        //--------------- getting timeslot dynamically -------------------------- //
        
        self.getTimeSlots(selectedDate: strSeldate)

//        UIView.animate(withDuration: 0.5) {
//            self.conButtonViewBottom.constant = -(80 + self.bottomPadding)
//            self.viewButton.superview?.layoutIfNeeded()
//        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd/MM/yyyy"
        
        let strselectedDate = dateFormatt.string(from: date)
        let strToDate = dateFormatt.string(from: Date())
        
        dateFormatt.dateFormat = "dd/MM/yyyy"
        
        let selectedDate = dateFormatt.date(from: strselectedDate)
        let ToDate = dateFormatt.date(from: strToDate)
        
        if selectedDate!.compare(ToDate!) == .orderedDescending || selectedDate!.compare(ToDate!) == .orderedSame
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.conviewCalendarHeight.constant = bounds.height
        viewCalendar.updateConstraints()
    }
    
    
    
    func minimumDate(for calendar: FSCalendar) -> Date
    {
        return Date().addingTimeInterval((TimeInterval(1*24*60*60)))
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage?
    {
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "yyyy-MM-dd"
        
        let strDate = dateFormatt.string(from: date)
        
        let strToDate = dateFormatt.string(from: Date())
        
        let selectedDate = dateFormatt.date(from: strDate)
        let ToDate = dateFormatt.date(from: strToDate)
        
        if selectedDate!.compare(ToDate!) == .orderedDescending
        {
            if arrDays.contains(strDate)
            {
                return UIImage(named: "Price_down") //"Price_up"
            }
        }
        
        return nil
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        <#code#>
//    }
    
    //MARK: Button Methods
    
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnconfirmClick(_ sender: Any)
    {
        if let slotData = slotInfo
        {
            let listConfirm = SERVICE_LIST.createwithnormalFlow(issueList: self.arrSelRequestItem, comeFrom: "calendar" , slotData: slotData , proprtydata: self.propertyInfo)
            self.navigationController?.pushViewController(listConfirm, animated: true)

            
//            ServerRequest.shared.BlockUnblockTimeSlot(slotId: slotData.id, blocked: "1", delegate: self) { (success) in
//
//                if success
//                {
//                    let listConfirm = SERVICE_LIST.createwithnormalFlow(comeFrom: "calendar" , slotData: slotData , proprtydata: self.propertyInfo)
//                    self.navigationController?.pushViewController(listConfirm, animated: true)
//                }
//                else
//                {
//                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Slot full", aStrMessage: "Please select another slot.", aOKBtnTitle: "OK") { (index, title) in
//
//                    }
//                }
//
//            } failure: { (errMsg) in
//
//                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
//
//                }
//            }
            
        }
        
    }
    
    @IBAction func btnfixNowClick(_ sender: Any)
    {
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
    
    func CreateFixNowJR(fixnow:Servicelist)
    {
        self.isLoading(loading: true)
        ServerRequest.shared.checkforConfiguration(delegate: nil) { response in
            
            if !response.isEmpty
            {
                let skipLink = response["skip_generate_payment_link"] as? String ?? "0"
//                let skipslot = response["enable_select_slot_skip"] as? String ?? "0"
                
                let arrSubmitServices = self.arrSelRequestItem.filter{$0.isSelected == 1}
                
                let dictServiceReq = AddService.init()
                dictServiceReq.customerId = Int(UserSettings.shared.getCustomerId())
                dictServiceReq.propertyId = self.propertyInfo?.id
                
                let dictUser = UserSettings.shared.getUserCredential()
                let title = dictUser["title"] as? String ?? ""

                if title == ""
                {
                    dictServiceReq.customerName = self.customerName
                }
                else
                {
                    dictServiceReq.customerName = String(format: "%@ %@", title , self.customerName)
                }
                
                dictServiceReq.customerMobile = self.customerMobile
                dictServiceReq.distributionChannel = "fixnow"
                dictServiceReq.additinalComment = ""
                dictServiceReq.status = 1  // requested
                dictServiceReq.subStatus = 2  // Awaiting Service Unit Assignment
                dictServiceReq.slotid = "corporate"
                dictServiceReq.slottime = "10:00 - 11:00"
                dictServiceReq.slotdate = self.strSeldate
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
    
    
    //MARK: FetchTimeslots
    
    func getavailableDays(Month:Int)
    {
                
        var arrcatId = [String]()
        for dict in self.arrSelRequestItem
        {
            let categoryId = String(format: "%d", dict.categoryId)
            arrcatId.append(categoryId)
        }
        
        let catId = String(format: "[%@]", arrcatId.joined(separator: ","))

        var sapIds = [String:Any]()
        for i in 0..<self.arrSelRequestItem.count
        {
           let dict = self.arrSelRequestItem[i]
           sapIds["service_id_sap[\(i)]"] = dict.jobservice.serviceIdSap
        }
        
        ServerRequest.shared.GetcalendaerDaysSlotavailability(geoRadarid: propertyInfo?.geofenceRadarId ?? "", month: Month, categoryId: catId,sapId: sapIds, delegate: self) { (response) in
            
            self.arrDays = response
            self.viewCalendar.reloadData()
            
        } failure: { (errMsg) in
            
        }
    }
    
    func getTimeSlots(selectedDate:String)
    {
//        UIView.animate(withDuration: 0.5) {
            self.conButtonViewBottom.constant = -(80 + self.bottomPadding)
//            self.viewButton.superview?.layoutIfNeeded()
//        }
        
        var arrcatId = [String]()
        for dict in self.arrSelRequestItem
        {
            let categoryId = String(format: "%d", dict.categoryId)
            arrcatId.append(categoryId)
        }

        
        let catId = String(format: "[%@]", arrcatId.joined(separator: ","))

        var sapIds = [String:String]()
        for i in 0..<self.arrSelRequestItem.count
        {
           let dict = self.arrSelRequestItem[i]
           sapIds["service_id_sap[\(i)]"] = dict.jobservice.serviceIdSap
        }

        ServerRequest.shared.GetTimeSlot(geoRadarid: propertyInfo?.geofenceRadarId ?? "", date: selectedDate, categoryId: catId,sapId: sapIds, delegate: self) { (response) in
            
            self.timeSlothandler.TimeSlots = response.data
            
            if self.timeSlothandler.TimeSlots.count == 0
            {
                /// view No slot hidden
                self.conviewTableHeight.constant = 300 // fixed as view height
                self.tblTimeSlot.updateConstraintsIfNeeded()
                self.tblTimeSlot.layoutIfNeeded()
                self.conButtonViewBottom.constant = -(80 + self.bottomPadding)

                UIView.animate(withDuration: 0.5) {
                    
                    self.viewNoSlot.alpha = 1
                }
            }
            else
            {
                self.tblTimeSlot.reloadData()
                self.conviewTableHeight.constant = self.tblTimeSlot.contentSize.height + 20
                self.tblTimeSlot.updateConstraintsIfNeeded()
                self.tblTimeSlot.layoutIfNeeded()
                self.conviewTableHeight.constant = self.tblTimeSlot.contentSize.height + 20

                
                UIView.animate(withDuration: 0.5) {
                    
                    self.viewNoSlot.alpha = 0
                }
            }

            
            
        } failure: { (errMsg) in
            
            self.conviewTableHeight.constant = 300 // fixed as view height
            self.tblTimeSlot.updateConstraintsIfNeeded()
            self.tblTimeSlot.layoutIfNeeded()
            self.conButtonViewBottom.constant = -(80 + self.bottomPadding)

            UIView.animate(withDuration: 0.5) {
                
                self.viewNoSlot.alpha = 1
            }
        }
    }
}
extension CALENDER_TIME : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}

