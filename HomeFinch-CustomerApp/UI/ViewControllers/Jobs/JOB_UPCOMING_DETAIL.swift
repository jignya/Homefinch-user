//
//  JOB_UPCOMING_DETAIL.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 28/12/20.
//

import UIKit
import RadarSDK
import Amplitude_iOS

class JOB_UPCOMING_DETAIL: UIViewController ,UIPopoverPresentationControllerDelegate {

    static func create(data:JobIssueList? = nil ,comeFrom:String = "",jobId:Int? = nil) -> JOB_UPCOMING_DETAIL {
        let detail = JOB_UPCOMING_DETAIL.instantiate(fromImShStoryboard: .Jobs)
        detail.jobRequestData = data
        detail.strComeFrom = comeFrom
        detail.jobId = jobId ?? 0
        return detail
    }
    
    //    Header outlet
    @IBOutlet weak var lblserviceNum: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblFixNow: UILabel!
    @IBOutlet weak var viewFixNow: UIView!
    
    // Step animation outlet
    
    @IBOutlet weak var scrl: UIScrollView!

    @IBOutlet weak var viewDotLine: UIView!
    @IBOutlet weak var viewActiveDotLine: UIView!

    @IBOutlet weak var step1: UIButton!
    @IBOutlet weak var step2: UIButton!
    @IBOutlet weak var step3: UIButton!
    @IBOutlet weak var step4: UIButton!
    @IBOutlet weak var step5: UIButton!
    @IBOutlet weak var conImgViewLeading: NSLayoutConstraint!
    @IBOutlet weak var conActiveViewWidth: NSLayoutConstraint!

    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var imgStep: UIImageView!
    
    @IBOutlet weak var lblserviceStatus: UILabel!
    @IBOutlet weak var lblInitials: UILabel!

    
    // quotation outlet

    @IBOutlet weak var lblGoQuotationMsg: UILabel!
    @IBOutlet weak var viewGoQuotation: UIView!
    @IBOutlet weak var btnGoQuotation: UIButton!
    
    // Review , pay Outlet

    @IBOutlet weak var lblReviewMsg: UILabel!
    @IBOutlet weak var viewReviewPay: UIView!
    @IBOutlet weak var btnReviewPay: UIButton!

    // Technician Detail

    @IBOutlet weak var viewTechnicianDetail: UIView!

    @IBOutlet weak var lblTechnicianDetail: UILabel!
    @IBOutlet weak var lblTechnicianDetailMsg: UILabel!
    @IBOutlet weak var lblTechnicianName: UILabel!
    @IBOutlet weak var imgTechnician: UIImageView!
    @IBOutlet weak var lblarrival: UILabel!
    @IBOutlet weak var lblJobDate: UILabel!
    @IBOutlet weak var lblJRStatus: UILabel!

    @IBOutlet weak var viewbtnMap: UIView!

    @IBOutlet weak var btnCall: UIView!
    @IBOutlet weak var btnMsg: UIButton!
    @IBOutlet weak var btnviewOnMap: UIButton!
    @IBOutlet weak var viewTechnicianInfo: UIView!
    
    // service list

    @IBOutlet weak var lblServiceList: UILabel!
    @IBOutlet weak var viewService: UIView!
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var conTblServiceHeight: NSLayoutConstraint!

    // Customer Info Outlet
    
    @IBOutlet weak var viewCustomer: UIView!
    @IBOutlet weak var viewProperty: UIView!

    
    @IBOutlet weak var lblProperty: UILabel!
    @IBOutlet weak var lblProertyAddress: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerContact: UILabel!

    @IBOutlet weak var viewCustomerInfo: UIView!
    @IBOutlet weak var btnChangeProperty: UIButton!
    @IBOutlet weak var btnChangeCustomerInfo: UIButton!


    private let servicelisthandler = UpcomingServiceListTableHandler()
    var jobRequestData : JobIssueList!

    let refreshControl = UIRefreshControl()
    var strComeFrom : String = ""
    var jobId : Int!

    
    
    //MARK: View Methods

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        refreshControl.tintColor = UserSettings.shared.themeColor()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.scrl.addSubview(refreshControl) 

        
        step1.isUserInteractionEnabled = false
        step2.isUserInteractionEnabled = false
        step3.isUserInteractionEnabled = false
        step4.isUserInteractionEnabled = false
        step5.isUserInteractionEnabled = false

                
        btnChangeProperty.isHidden = true
        btnChangeCustomerInfo.isHidden = false

        self.ImShSetLayout()
        self.setLabel()
        self.updateViewVisibility(step: 1)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.imgStep.isUserInteractionEnabled = true
        self.imgStep.addGestureRecognizer(tapGesture)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.viewbtnMap.isHidden = true
        self.fetchJobRequestDetail()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white

    }

    override func viewWillLayoutSubviews() {
        
        viewCustomer.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        viewProperty.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        viewService.roundCorners(corners: [.topLeft, .topRight], radius: 15)

        
        if let aSize = btnReviewPay.titleLabel?.font?.pointSize
        {
            btnReviewPay.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnGoQuotation.titleLabel?.font?.pointSize
        {
            btnGoQuotation.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnviewOnMap.titleLabel?.font?.pointSize
        {
            btnviewOnMap.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnChangeProperty.titleLabel?.font?.pointSize
        {
            btnChangeProperty.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnChangeCustomerInfo.titleLabel?.font?.pointSize
        {
            btnChangeCustomerInfo.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
    }
    
    override func ImShSetLayout()
    {
        servicelisthandler.strComeFrom = "jobdetail"
        self.tblServices.rowHeight = UITableView.automaticDimension
        self.tblServices.estimatedRowHeight = 70

        self.tblServices.setUpTable(delegate: servicelisthandler, dataSource: servicelisthandler, cellNibWithReuseId: ServiceListCell.className)
        
        /// Handling actions
        servicelisthandler.EditIssueClick = {(indexpath) in
            
            let jobrequestItem = self.servicelisthandler.arrServices[indexpath.row]
            let detail = SERVICE_DETAIL.create(jobrequestData: self.jobRequestData, item: jobrequestItem, strcomeFrom: "jobdetail")
            self.navigationController?.pushViewController(detail, animated: true)

        }
        
        servicelisthandler.CancelIssueClick = {(indexpath) in
            
            let items = self.servicelisthandler.arrServices[indexpath.row]
            let strMsg = String(format: "Are you sure want to cancel %@ ?", items.items)
            AJAlertController.initialization1().showAlert(isBottomShow: true, aStrTitle: "Cancel Issue", aStrMessage: strMsg, aCancelBtnTitle: "NO", aOtherBtnTitle: "YES", completion: { (index, title) in
                
                if index == 1
                {
                    let arrData = UserSettings.shared.initialData.reasonForAbandon.filter({$0.name == "Customer Request"})
                    
                    if arrData.count > 0
                    {
                        let arrReasonType = UserSettings.shared.initialData.reasonForAbandonWithType.filter{$0.id == arrData[0].id}

                        let abandonId = String(format: "%d", arrData[0].id)
                        
                        if arrReasonType.count > 0
                        {
                            let abandonedTypeid = String(format: "%@", arrReasonType[0].name)

                            // update job issue status , status - issue Abandoned

                            let dictPara2  = ["status":"8","reason_for_abandon_type_id":abandonedTypeid, "reason_for_abandon_id" :abandonId] as [String : String]
                            ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: items.id, dictPara: dictPara2, delegate: nil) {
                                
                                ServerRequest.shared.updateJobReqEstimation(jobRequestId: self.jobRequestData.id, delegate: self) {
                                    
                                    DispatchQueue.main.async {
                                        self.saveIssueToJobList(issueId: items.id) // added in job list
                                        self.fetchJobRequestDetail()
                                    }
                                    
                                } failure: { (errorMsg) in
                                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                                }

                            } failure: { (errorMsg) in
                                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                            }
                        }
                        
                       
                    }
                    
                }
                
            })
        }
        
        servicelisthandler.didSelect = {(indexpath) in
            
            self.tblServices.beginUpdates()
            self.tblServices.reloadData()
            self.tblServices.endUpdates()

            self.tblServices.updateConstraintsIfNeeded()
            self.tblServices.layoutIfNeeded()
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height

        }

    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblServiceList.text = ""
        lblProperty.text = "Property"
        btnChangeProperty.setTitle("CHANGE", for: .normal)
        btnChangeCustomerInfo.setTitle("CHANGE", for: .normal)
        
        lblserviceStatus.text = ""
        lblTechnicianDetail.text = "Technician Details"
        lblTechnicianDetailMsg.text = "Please wait for sometime system is finding Technician for your job request."
        
        lblarrival.text = ""
        btnviewOnMap.setTitle("View on Map", for: .normal)

        lblGoQuotationMsg.text = "Technician's inspection is done please check and accept quotation"
        btnGoQuotation.setTitle("GO TO QUOTATION", for: .normal)
        
        lblReviewMsg.text = "Your job request is completed successfully. Please make payment and rate the service."
        btnReviewPay.setTitle("REVIEW & PAY", for: .normal)


    }

    
    //MARK: Web service calling
    
    func getUserRadarData()
    {
        self.lblarrival.text = ""
        
        ServerRequest.shared.GetUser(performerid: self.jobRequestData.employeeId.toString(), delegate: self) { response in
            
//            self.getUserTripData()
            
            let userData = response["users"] as? [[String:Any]] ?? []
            
            for userDict in userData
            {
                if userDict["userId"] as? String == self.jobRequestData.employeeId.toString()
                {
    //                let userDict = response["user"] as? [String:Any]
                    let userLocation = userDict["location"] as? [String:Any]
                    let performerLocation = userLocation?["coordinates"] as? [Double]
                    
                    let performerLat = performerLocation?[1]
                    let performerLong = performerLocation?[0]

                    let destlatitude1 = self.jobRequestData.propertyData.latitude ?? ""
                    let destlongitude1 = self.jobRequestData.propertyData.longitude ?? ""

                    if destlatitude1 != "" && destlongitude1 != ""
                    {
        //                let coordinate0 = CLLocation(latitude: (performerLat ?? 0), longitude: (performerLong ?? 0))
        //                let coordinate1 = CLLocation(latitude: Double(destlatitude1)!, longitude: Double(destlongitude1)!)

        //                let distanceInMeters = coordinate1.distance(from: coordinate0)
        //                self.lblarrival.text = String(format: "Distance : %.01f km",distanceInMeters/1000 )
                        
                        ServerRequest.shared.GetUserDistance(current0: String(format: "%f", performerLat as! CVarArg), current1: String(format: "%f", performerLong as! CVarArg), dest0: destlatitude1, dest1: destlongitude1, delegate: nil) { response in
                            
                            if response.isEmpty == false
                            {
                                self.viewbtnMap.isHidden = false

                                let routes = response["routes"] as? [String:Any]
                                let values = routes?["car"] as? [String:Any]
                                let duration = values?["duration"] as? [String:Any]
                                if duration?["text"] as? String == "0"
                                {
                                    self.lblarrival.text = "Arrived"
                                }
                                else
                                {
                                    self.lblarrival.text = String(format: "Arriving in %@", duration?["text"] as? String ?? "")
                                }
                            }

                        } failure: { (errorMsg) in
                            
                        }
                    }
                    
                    break
                }
            }
            
        } failure: { (errorMsg) in
            
        }

    }
    
    func getUserTripData()
    {
        ServerRequest.shared.GetPerformerOnmapHistory(extrtnalId: self.jobRequestData.propertyData.geofenceRadarId, geofenceTag: "", delegate: self) { response in
            
        } failure: { (errorMsg) in
            
        }
    }
    
    
    func fetchJobRequestDetail()
    {
        let jobId : Int!
        
        if self.jobId != 0
        {
            jobId = self.jobId
        }
        else
        {
            jobId = jobRequestData.id
        }
        
        ServerRequest.shared.GetJobRequestDetail(requestId: jobId, delegate: self) { (response) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.jobRequestData = response
                self.setData(response: response)
            }
            
        } failure: { (errMsg) in
            
        }

    }
    
    func saveIssueToJobList(issueId : Int)  // add issue data to the server
    {
        let dictServiceReq = AddService.init()
        dictServiceReq.customerId = self.jobRequestData.customerId
        dictServiceReq.customerName = self.jobRequestData.customerName
        dictServiceReq.customerMobile = self.jobRequestData.customerMobile
        dictServiceReq.createdBy = UserSettings.shared.getCustomerId()
        dictServiceReq.issueId = issueId
        dictServiceReq.jobReqId = self.jobRequestData.id
        
        print(dictServiceReq.toJobListDictionary())
        
        ServerRequest.shared.CreateJobList(isCloneItem: "1", customerId: self.jobRequestData.customerId.toString(), dictPara: dictServiceReq, delegate: self) {_ in

            self.dismiss(animated: true) {
            }

        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
    }
    
    //MARK: Data parsing
    
    func setData(response : JobIssueList)
    {
        let arrAbandon = response.jobrequestitems.filter{$0.status == 8}
        if arrAbandon.count == response.jobrequestitems.count && response.status == 1// && response.jobotherservices.count == 0
            //&& response.status >= 8
        {
            ServerRequest.shared.cancelJobRequest(jobRequestId: self.jobRequestData.id, status: self.jobRequestData.status, delegate: nil) {
                
                let jobId = String(format: "%d", self.jobRequestData.id)
                
                let serverUrl = ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["record-job-with-slot",jobId,"cancel"]).absoluteString
                
                // update job status - status - canceled , sub_status - Customer
                let dict  = ["status":"6","sub_status":"18","request_info":[:],"request_url":serverUrl] as [String : Any]
                
                ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobRequestData.id, dictPara: dict, delegate: self) {
                    
                    let detail = JOB_PAST_DETAIL.create(data: response,iscancelService: true)
                    self.navigationController?.pushViewController(detail, animated: true)

                } failure: { (errorMsg) in
                }
                
                

                //-------------------------------
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }
            
            return

        }
       
        
        self.lblServiceList.text = "Issue(s)" //String(format: "Job %d", response.id)
        self.lblserviceNum.text = String(format: "Job %d", response.id)
        self.viewFixNow.isHidden = true

        if response.distributionChannel == "fixnow"
        {
            self.viewFixNow.isHidden = false
        }
        
        self.lblCustomerName.text = response.customerName
        self.lblCustomerContact.text = response.customerMobile
        
        self.lblProertyAddress.text = ""
        if let propertyData = response.propertyData
        {
            self.attributedAddress(strTitle: String(format: "%@\n", propertyData.propertyName), strAddress: propertyData.fullAddress)

//            self.lblProertyAddress.text = propertyData.propertyName + "\n" + response.propertyData.fullAddress
        }
        
        self.lblJobDate.text = ""
        
        if let strStartDate = response.startDate
        {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let serviceDate = dateformatter.date(from: strStartDate)
            {
                dateformatter.dateFormat = "E, d MMM yyyy"
                self.lblJobDate.text = String(format: "%@ | %@",  dateformatter.string(from: serviceDate), UserSettings.shared.string24To12String(time: response.jobrequestadditionalinfo.slotTime))
            }
        }
        
//        let propertyId = response.propertyId
//        let arrProprty = UserSettings.shared.arrPropertyList.filter{$0.id == propertyId}
//        if arrProprty.count > 0
//        {
//            self.lblProertyAddress.text = String(format: "%@\n%@", arrProprty[0].propertyName,arrProprty[0].fullAddress)
//        }
        
        // Service Listing
        self.servicelisthandler.isEditable = ""
        self.servicelisthandler.arrServices = response.jobrequestitems
        self.tblServices.reloadData()
        self.tblServices.updateConstraintsIfNeeded()
        self.tblServices.layoutIfNeeded()
        self.conTblServiceHeight.constant = self.tblServices.contentSize.height
        // ---------------------------------
        
        let jobStatus = response.status
        let arrStatus = UserSettings.shared.initialData.jobRequestStatus.filter { $0.id == jobStatus}
        if arrStatus.count > 0
        {
            self.lblJRStatus.text = "" //arrStatus[0].name
            self.lblserviceStatus.text = arrStatus[0].name
        }
        
//        let jobsubStatus = response.subStatus
//        let arrsubStatus = UserSettings.shared.initialData.jobRequetSubStatus.filter { $0.id == jobsubStatus}
//        if arrsubStatus.count > 0
//        {
//            self.lblserviceStatus.text = arrsubStatus[0].name
//        }

        
        if let employeedata = response.employeeData
        {
            self.lblTechnicianName.text = employeedata.fullName
            
            let initials = self.lblTechnicianName.text?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            self.lblInitials.text = initials?.uppercased()
            self.imgTechnician.isHidden = true
            self.imgTechnician.backgroundColor = UIColor.clear
            
            if let imageTec = employeedata.avatar
            {
                self.imgTechnician.setImage(url: imageTec.getURL, placeholder: nil)
                self.imgTechnician.isHidden = false
                self.imgTechnician.contentMode = .scaleAspectFill
            }

        }
        

        if (response.status == 1 && response.subStatus == 1) || (response.status == 1 && response.subStatus == 2) || (response.status == 1 && response.subStatus == 3) // requested - Draft , awaiting to assign service Unit , Technician assign
        {
            self.servicelisthandler.isEditable = "2"
            self.btnstep1Click(self.step1 as Any)
            
            if response.subStatus == 3
            {
                lblTechnicianDetailMsg.isHidden = true
                self.viewTechnicianInfo.isHidden = false
                self.viewbtnMap.isHidden = true
                
                //------------------- log event ------------------
                
//                let issuecategory = response.jobrequestitems.map { $0.items }
//                let issuecategoryIds = response.jobrequestitems.map { $0.categoryId }
//                let issueCount = response.issueCount
//                let employeeOtherSkills = response.employeeData.employeeSkill.map { $0.primarySkill }
//
//                let issuecatIds = issuecategoryIds.description
//                let issueTitles = issuecategory.description
//                let employeeOtherSkill = employeeOtherSkills.description
//
//                let dictPara = ["Job ID":response.id,
//                                "Issue Count":issueCount,
//                                "Issue Category":issuecatIds,
//                                "Issue Title":issueTitles,
//                                "Property ID":response.propertyId,
//                                "Property Map Location":(response.propertyData.gLocation ?? ""),
//                                "Property Geofence Location":(response.propertyData.gLocation ?? ""),
//                                "Customer ID":UserSettings.shared.getCustomerId(),
//                                "Customer Category":"",
//                                "Customer Property Count":"",
//                                "App User ID":"",
//                                "Contact ID":"",
//                                "Contact Type":"",
//                                "Performer ID":response.employeeId,
//                                "Performer Primary Skill":response.employeeData.employeeServiceUnitSkill ,
//                                "Performer Other Skill":employeeOtherSkill,
//                                "Service Unit ID":response.employeeData.sapId,
//                                "Service Unit Location":"",
//                                "Performer Count":""] as [String : Any]
//
//                Amplitude.instance().logEvent("Assigned to Performer", withEventProperties: dictPara)
                //------------------------------------------------
                
            }
        }
        else if (response.status == 2 && response.subStatus == 4) || (response.status == 2 && response.subStatus == 5)  //  out for services , arrived
        {
            self.servicelisthandler.isEditable = "0"
            self.servicelisthandler.isEditable = "1"
            
            if response.subStatus == 4
            {
                self.getUserRadarData()
            }
            else if response.subStatus == 5
            {
                //------------------- log event ------------------
                
//                let issuecategory = response.jobrequestitems.map { $0.items }
//                let issuecategoryIds = response.jobrequestitems.map { $0.categoryId }
//                let issueCount = response.issueCount
//                let employeeOtherSkills = response.employeeData.employeeSkill.map { $0.primarySkill }
//
//                let issuecatIds = issuecategoryIds.description
//                let issueTitles = issuecategory.description
//                let employeeOtherSkill = employeeOtherSkills.description
//
//
//                let dictPara = ["Job ID":response.id,
//                                "Issue Count":issueCount,
//                                "Issue Category":issuecatIds,
//                                "Issue Title":issueTitles,
//                                "Property ID":response.propertyId,
//                                "Property Map Location":(response.propertyData.gLocation ?? ""),
//                                "Property Geofence Location":(response.propertyData.gLocation ?? ""),
//                                "Customer ID":UserSettings.shared.getCustomerId(),
//                                "Customer Category":"",
//                                "Customer Property Count":"",
//                                "App User ID":"",
//                                "Contact ID":"",
//                                "Contact Type":"",
//                                "Performer ID":response.employeeId,
//                                "Performer Primary Skill":response.employeeData.employeeServiceUnitSkill ,
//                                "Performer Other Skill":employeeOtherSkill,
//                                "Service Unit ID":response.employeeData.sapId,
//                                "Service Unit Location":"",
//                                "Performer Count":""] as [String : Any]
//
//                Amplitude.instance().logEvent("Performer Arrived", withEventProperties: dictPara)
                //------------------------------------------------
            }

            self.btnstep2Click(self.step2 as Any)
        }
        else if (response.status == 3 && response.subStatus == 8) || (response.status == 3 && response.subStatus == 6) || (response.status == 3 && response.subStatus == 7) // inspection started , inspection completed , Quotation Submitted
        {
            if response.subStatus == 6
            {
                //------------------- log event ------------------
                
//                let issuecategory = response.jobrequestitems.map { $0.items }
//                let issuecategoryIds = response.jobrequestitems.map { $0.categoryId }
//                let issueCount = response.issueCount
//                let employeeOtherSkills = response.employeeData.employeeSkill.map { $0.primarySkill }
//
//                let issuecatIds = issuecategoryIds.description
//                let issueTitles = issuecategory.description
//                let employeeOtherSkill = employeeOtherSkills.description
//
//
//                let dictPara = ["Job ID":response.id,
//                                "Issue Count":issueCount,
//                                "Issue Category":issuecatIds,
//                                "Issue Title":issueTitles,
//                                "Property ID":response.propertyId,
//                                "Property Map Location":(response.propertyData.gLocation ?? ""),
//                                "Property Geofence Location":(response.propertyData.gLocation ?? ""),
//                                "Customer ID":UserSettings.shared.getCustomerId(),
//                                "Customer Category":"",
//                                "Customer Property Count":"",
//                                "App User ID":"",
//                                "Contact ID":"",
//                                "Contact Type":"",
//                                "Performer ID":response.employeeId,
//                                "Performer Primary Skill":response.employeeData.employeeServiceUnitSkill ,
//                                "Performer Other Skill":employeeOtherSkill,
//                                "Service Unit ID":response.employeeData.sapId,
//                                "Service Unit Location":"",
//                                "Performer Count":""] as [String : Any]
//
//                Amplitude.instance().logEvent("Inspection Started", withEventProperties: dictPara)
                //------------------------------------------------

            }
            else if response.subStatus == 8
            {
                //------------------- log event ------------------
                
//                let issuecategory = response.jobrequestitems.map { $0.items }
//                let issuecategoryIds = response.jobrequestitems.map { $0.categoryId }
//                let issueCount = response.issueCount
//                let employeeOtherSkills = response.employeeData.employeeSkill.map { $0.primarySkill }
//                let servicedata1 = response.jobQuotationData.map { $0.serviceData }
//
//                var idSaps = [String]()
//                var serviceAmt = [Int]()
//
//                for servicedata in servicedata1
//                {
//                    let service = servicedata?.map { $0.serviceData.serviceIdSap }
//                    let amount = servicedata?.map { $0.sum }
//
//                    print(service,amount)
//
//                }
//
//
//                let issuecatIds = issuecategoryIds.description
//                let issueTitles = issuecategory.description
//                let employeeOtherSkill = employeeOtherSkills.description
//
//                let dictPara = ["Job ID":response.id,
//                                "Issue Count":issueCount,
//                                "Issue Category":issuecatIds,
//                                "Issue Title":issueTitles,
//                                "Property ID":response.propertyId,
//                                "Property Map Location":(response.propertyData.gLocation ?? ""),
//                                "Property Geofence Location":(response.propertyData.gLocation ?? ""),
//                                "Customer ID":UserSettings.shared.getCustomerId(),
//                                "Customer Category":"",
//                                "Customer Property Count":"",
//                                "App User ID":"",
//                                "Contact ID":"",
//                                "Contact Type":"",
//                                "Performer ID":response.employeeId,
//                                "Performer Primary Skill":response.employeeData.employeeServiceUnitSkill,
//                                "Performer Other Skill":employeeOtherSkill,
//                                "Service Unit ID":response.employeeData.sapId,
//                                "Service Unit Location":"",
//                                "Performer Count":"",
//                                "Performer Issue Category":"",
//                                "Performer Issue Title":"",
//                                "Service Category":"",
//                                "Service Name":"",
//                                "Service Value":"",
//                                "Material Category":"",
//                                "Material Name":"",
//                                "Material Value":""] as [String : Any]
//
//                Amplitude.instance().logEvent("Quotation Submitted", withEventProperties: dictPara)
                //------------------------------------------------
            }
            
            self.btnstep3Click(self.step3 as Any)
        }
        else if (response.status == 3 && response.subStatus == 9) || (response.status == 3 && response.subStatus == 10) || (response.status == 3 && response.subStatus == 11) || (response.status == 4 && response.subStatus == 12) || (response.status == 4 && response.subStatus == 13) // Quotation Approved , partially approved , Execusion started - completed
        {
            self.btnstep4Click(self.step4 as Any)
        }
        else if response.status == 5 && response.subStatus == 14 // invoice generated
        {
            self.btnstep5Click(self.step5 as Any)
        }
        else if response.status == 5 && response.subStatus == 15 // payment success
        {
            let detail = JOB_PAST_DETAIL.create(data: self.jobRequestData ,iscancelService: false)
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    //MARK: Referesh Data
    @objc func refresh(_ sender: AnyObject) {
        
        self.fetchJobRequestDetail()
    }

   
    //MARK: Twilio call methods
//    func fetchAccessToken() -> String? {
//        let endpointWithIdentity = String(format: "%@?identity=%@", accessTokenEndpoint, identity)
//
//        guard let accessTokenURL = URL(string: baseURLString + endpointWithIdentity) else { return nil }
//
//        return try? String(contentsOf: accessTokenURL, encoding: .utf8)
//    }
    
    //MARK: Step manage based on status

    func updateViewVisibility(step:Int)
    {
        if step == 1
        {
            viewTechnicianInfo.isHidden = true
            viewGoQuotation.isHidden = true
            viewReviewPay.isHidden = true

        }
        else if step == 2
        {
            viewTechnicianInfo.isHidden = false
            lblTechnicianDetailMsg.isHidden = true
            step1.isUserInteractionEnabled = false
        }
        else if step == 3
        {
            viewTechnicianInfo.isHidden = false
            lblTechnicianDetailMsg.isHidden = true

            viewGoQuotation.isHidden = !(self.jobRequestData.status == 3 && self.jobRequestData.subStatus == 8)
            viewbtnMap.isHidden = true
            step2.isUserInteractionEnabled = false


        }
        else if step == 4
        {
            viewTechnicianInfo.isHidden = false
            lblTechnicianDetailMsg.isHidden = true

            btnGoQuotation.superview?.isHidden = true
            if jobRequestData.subStatus == 11
            {
                lblGoQuotationMsg.text = ""
                lblGoQuotationMsg.isHidden = true
                viewGoQuotation.isHidden = true
            }
            else
            {
                lblGoQuotationMsg.text = "You have approved Quotation. Technician is started working on your job request."
                lblGoQuotationMsg.isHidden = false
                viewGoQuotation.isHidden = false

            }
            step3.isUserInteractionEnabled = false


        }
        else if step == 5
        {
            viewTechnicianInfo.isHidden = false
            lblTechnicianDetailMsg.isHidden = true

            viewGoQuotation.isHidden = true
            viewReviewPay.isHidden = false
            step4.isUserInteractionEnabled = false
        }
    }
    
    
    //MARK: Button methods
    
    @IBAction func btnGoQuotationClick(_ sender: Any) {
        
        let quotation = QUOTATIONVIEW.create(jobrequestData: self.jobRequestData)
        self.navigationController?.pushViewController(quotation, animated: true)
    }
    
    @IBAction func btnRevirePayClick(_ sender: Any) {
        let review = REVIEW_PAYMENT.create(jobData: self.jobRequestData)
        self.navigationController?.pushViewController(review, animated: true)
    }
    
    @IBAction func btnCallnClick(_ sender: Any) {
        
        let customerPhn = self.jobRequestData.employeeData.workPhone.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(customerPhn)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

        
//        ServerRequest.shared.CreateSession(sessionName: "session123", delegate: self) { (sid) in
//
//            ServerRequest.shared.getMaskedNumber(friendlyName: "Namrata", sessionSID : sid ,phoneNumber: "+917383340571", phoneNumberProxy: "+14403458636", delegate: self) { (number) in
//
//            }
//
//            ServerRequest.shared.getMaskedNumber(friendlyName: "Jignya", sessionSID : sid ,phoneNumber: "+918866181256", phoneNumberProxy: "+14403458636", delegate: self) { (number) in
//
//                if number != ""
//                {
//                    if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
//                        if #available(iOS 10, *) {
//                            UIApplication.shared.open(url)
//                        } else {
//                            UIApplication.shared.openURL(url)
//                        }
//                    }
//                }
//            }
//
//
//
//        }
        
        
    }
    
//    func checkRecordPermission(completion: @escaping (_ permissionGranted: Bool) -> Void) {
//        let permissionStatus = AVAudioSession.sharedInstance().recordPermission
//
//        switch permissionStatus {
//        case .granted:
//            // Record permission already granted.
//            completion(true)
//        case .denied:
//            // Record permission denied.
//            completion(false)
//        case .undetermined:
//            // Requesting record permission.
//            // Optional: pop up app dialog to let the users know if they want to request.
//            AVAudioSession.sharedInstance().requestRecordPermission { granted in completion(granted) }
//        default:
//            completion(false)
//        }
//    }
    
    @IBAction func btnMsgClick(_ sender: Any) {
        
        let chat = CHATVIEW.create(title: "", jobData: self.jobRequestData)
        self.navigationController?.pushViewController(chat, animated: true)

    }
    
    @IBAction func btnViewMapClick(_ sender: Any) {
        
        let updates = TECHICIAN_ON_MAP.create(jobData: self.jobRequestData)
        self.navigationController?.pushViewController(updates, animated: true)
    }
    
    @IBAction func btnChangePropertyClick(_ sender: Any) {
    }
    
    @IBAction func btnChangeCustomerInfoClick(_ sender: Any) {
        
        let update = UPDATE_CUSTOMER_DATA.create(delegate: self, jobreqData: self.jobRequestData)
        self.navigationController?.pushViewController(update, animated: true)
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        if strComeFrom == "pushnot"
        {
            self.navigationController?.popViewController(animated: true)
        }
        else if strComeFrom == "push"
        {
            let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            AppDelegate.shared.window?.rootViewController = navigationController
            AppDelegate.shared.window?.makeKeyAndVisible()
            
        }
        else
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    @IBAction func btnstep1Click(_ sender: Any) {
        imgStep.alpha = 0
        lblserviceStatus.alpha = 0
//        lblserviceStatus.text = "Service Placed"

        imgStep.image = UIImage(named: "step1")
//        UIView.animate(withDuration: 0.3) {
            self.imgStep.alpha = 1
            self.lblserviceStatus.alpha = 1
            self.conImgViewLeading.constant = -5
            self.conActiveViewWidth.constant = 0
            
            self.updateViewVisibility(step: 1)
//            self.viewImg.superview?.layoutIfNeeded()
//        }
        
        
    }
    
    @IBAction func btnstep2Click(_ sender: Any) {
       
        imgStep.alpha = 0
        lblserviceStatus.alpha = 0

        imgStep.image = UIImage(named: "step2")
//        UIView.animate(withDuration: 0.3) {
            self.imgStep.alpha = 1
            self.lblserviceStatus.alpha = 1
            self.conImgViewLeading.constant = self.step2.frame.origin.x
            self.conActiveViewWidth.constant = self.step2.frame.origin.x + 15
            
            self.updateViewVisibility(step: 2)
            self.viewImg.superview?.layoutIfNeeded()
//        }
        
    }
    
    @IBAction func btnstep3Click(_ sender: Any) {
        
        imgStep.alpha = 0
        lblserviceStatus.alpha = 0
        imgStep.image = UIImage(named: "step3")
//        UIView.animate(withDuration: 0.3) {
            self.imgStep.alpha = 1
            self.lblserviceStatus.alpha = 1
            self.conImgViewLeading.constant = self.step3.frame.origin.x
            self.conActiveViewWidth.constant = self.step3.frame.origin.x + 15
            
            self.updateViewVisibility(step: 3)
            self.viewImg.superview?.layoutIfNeeded()
//        }
    }
    
    @IBAction func btnstep4Click(_ sender: Any) {
        imgStep.alpha = 0
        lblserviceStatus.alpha = 0

        imgStep.image = UIImage(named: "step4")
//        UIView.animate(withDuration: 0.3) {
            self.imgStep.alpha = 1
            self.lblserviceStatus.alpha = 1
            self.conImgViewLeading.constant = self.step4.frame.origin.x
            self.conActiveViewWidth.constant = self.step4.frame.origin.x + 15
            
            self.updateViewVisibility(step: 4)
            self.viewImg.superview?.layoutIfNeeded()
//        }
    }
    
    @IBAction func btnstep5Click(_ sender: Any)
    {
        imgStep.alpha = 0
        lblserviceStatus.alpha = 0
//        lblserviceStatus.text = "Jobs Completed"

        imgStep.image = UIImage(named: "step5")
//        UIView.animate(withDuration: 0.3) {
            self.imgStep.alpha = 1
            self.lblserviceStatus.alpha = 1
            self.conImgViewLeading.constant = self.step5.frame.origin.x
            self.conActiveViewWidth.constant = self.step5.frame.origin.x + 15
            
            self.updateViewVisibility(step: 5)
            self.viewImg.superview?.layoutIfNeeded()
//        }
    }
    
    //MARK: ToolTip On status label
    
    @objc func tapGesture(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let jobsubStatus = self.jobRequestData.subStatus
            let arrsubStatus = UserSettings.shared.initialData.jobRequetSubStatus.filter { $0.id == jobsubStatus}
            if arrsubStatus.count > 0
            {
                let pop = PopOverView.create(status: arrsubStatus[0].name, sender: img)
                
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
        return UIModalPresentationStyle.none
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
        
        lblProertyAddress.attributedText = combination
    }
    
}

// MARK: - AVAudioPlayerDelegate

//extension JOB_UPCOMING_DETAIL: AVAudioPlayerDelegate {
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        if flag {
//            NSLog("Audio player finished playing successfully");
//        } else {
//            NSLog("Audio player finished playing with some error");
//        }
//    }
//
//    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
//        if let error = error {
//            NSLog("Decode error occurred: \(error.localizedDescription)")
//        }
//    }
//}

extension JOB_UPCOMING_DETAIL : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}

//MARK: customer delegate Methods
extension JOB_UPCOMING_DETAIL : updateCustomerDelegate
{
    func updateCustomerInfo(name: String, mobile: String) {
        
        let params = ["customer_name":name , "customer_mobile":mobile , "job_request_id" : self.jobRequestData.id] as [String : Any]
        
        ServerRequest.shared.updateCustomerContactInfo(JobReqId: self.jobRequestData.id.toString(), dictPara: params, delegate: self) { response in
            
            self.fetchJobRequestDetail()
            
        } failure: { (errMsg) in
            
        }

    }
}



