//
//  QUOTATIONVIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit
import Amplitude_iOS

class QUOTATIONVIEW: UIViewController,cancelRequestDelegate {
    static func create(jobrequestData: JobIssueList,comeFrom:String = "") -> QUOTATIONVIEW {
        let list = QUOTATIONVIEW.instantiate(fromImShStoryboard: .Jobs)
        list.jobrequestData = jobrequestData
        return list
    }
    
   
    //MARK:Outlets
    
    @IBOutlet weak var lblServiceCount: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnNoThanks: UIButton!
    
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var viewButton: UIView!


    // MARK: PRIVATE
    
    var jobrequestData: JobIssueList!
    var strcomeFrom: String!
    let quotationlisthandler = QuotationMainListTableHandler()
    var arrSelectedServices = [JobQuotationData]()

    //MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ImShSetLayout()
        self.setLabel()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Quotation"
        }

        self.setData(response: jobrequestData)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func ImShSetLayout()
    {
        
        self.tblServices.estimatedRowHeight = 50
        self.tblServices.rowHeight = UITableView.automaticDimension
        
        self.tblServices.setUpTable(delegate: quotationlisthandler, dataSource: quotationlisthandler, cellNibWithReuseId: QuotationCell.className)
        
        
        /// Handling actions
        
        quotationlisthandler.didSelect = {(indexpath) in
            
            self.tblServices.beginUpdates()
            self.tblServices.reloadData()
            self.tblServices.endUpdates()

        }
        
        quotationlisthandler.SelectServiceClick = {(indexpath,isSelected) in
            
            if let cell = self.tblServices.cellForRow(at: IndexPath(row: indexpath.row, section: 0)) as? QuotationCell
            {
                let dict = self.quotationlisthandler.arrServices[indexpath.row]

                if dict.serviceData.count > 0
                {
                    cell.quotationlisthandler.arrServices = dict.serviceData
                    
                    if dict.isSelected == 0
                    {
                        for i in 0..<cell.quotationlisthandler.arrServices.count
                        {
                            let dict1 = cell.quotationlisthandler.arrServices[i]
                            dict1.isSelected = 0
                            cell.quotationlisthandler.arrServices[i] = dict1
                        }
                    }
                    else
                    {
                        for i in 0..<cell.quotationlisthandler.arrServices.count
                        {
                            let dict1 = cell.quotationlisthandler.arrServices[i]
                            dict1.isSelected = 1
                            cell.quotationlisthandler.arrServices[i] = dict1
                        }
                    }
                    
                    self.quotationlisthandler.arrServices[indexpath.row] = dict
                }
                
                self.calculateTotalOfservices(isfisrtTime: false)
            }
        }
    }
    
    func setLabel()
    {
        
        btnConfirm.setTitle("CONFIRM", for: .normal)
        btnNoThanks.setTitle("NO THANKS, I DONT WANT IT", for: .normal)
        

    }
    override func viewWillLayoutSubviews() {
        
        // shadow effect bottom view
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.view.frame.size.width + shadowSize,
                                                   height: self.view.frame.size.height + shadowSize))
        self.viewButton.layer.masksToBounds = false
        self.viewButton.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewButton.layer.shadowOpacity = 0.5
        self.viewButton.layer.shadowRadius = 3
        self.viewButton.layer.shadowPath = shadowPath.cgPath
        
        //------------------------
        
        if let aSize = btnConfirm.titleLabel?.font?.pointSize
        {
            btnConfirm.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnNoThanks.titleLabel?.font?.pointSize
        {
            btnNoThanks.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
    }
    
    func setData(response:JobIssueList)
    {

        quotationlisthandler.arrServices = response.jobQuotationData
        quotationlisthandler.arrOtherServiceList = response.jobotherservices //.filter{$0.sapId == "S_OT0002"} // high demand charges

        self.calculateTotalOfservices(isfisrtTime: true)

    }
    
    func calculateTotalOfservices(isfisrtTime : Bool)
    {
        var total : Double = 0

        for i in 0..<quotationlisthandler.arrServices.count
        {
            let dict = quotationlisthandler.arrServices[i]
            if isfisrtTime
            {
                dict.isExpand = 0
                dict.isSelected = 0

                quotationlisthandler.arrServices[i] = dict
                
                if dict.jobRequestItemData.status != 8
                {
                    dict.isSelected = 1
                    total = Double(dict.sum) + total
                }
            }
            else
            {
                if dict.isSelected == 1
                {
                    for dictDetail in dict.serviceData
                    {
                        if dictDetail.isSelected == 1
                        {
                            total = Double(dictDetail.sum) + total
                        }
                    }
//                    total = Double(dict.sum) + total
                }
            }
            
        }
        
        for dict in quotationlisthandler.arrOtherServiceList
        {
            total = (Double(dict.serviceTotalPrice) ?? 0.0) + total
        }
        
        let arrservices = quotationlisthandler.arrServices.filter{$0.jobRequestItemData.status != 8 && $0.isSelected == 1}
        
        self.lblServiceCount.text = String(format: "%d Services",(arrservices.count + quotationlisthandler.arrOtherServiceList.count))
        self.lblTotal.text = String(format: "AED %.2f", total)

        self.tblServices.reloadData()
    }
    
    //MARK: Buttton Methods
    
    @IBAction func btnConfirmClick(_ sender: Any) {
        
        arrSelectedServices = self.quotationlisthandler.arrServices.filter({$0.isSelected == 1})
        
        if arrSelectedServices.count == 0
        {
            ServerRequest.shared.GetServiceList(dictPara: [:], delegate: self) { (response) in
                
                let arrOtherServices = response.data.filter{$0.sapId == "S_OT0004"}
                
                if arrOtherServices.count > 0
                {
                    let dictservice = arrOtherServices[0]
                    let price = String(format: "%d", dictservice.price)

                    let strmsg = String(format: "%@\n\n%@", "You will be charged for inspection charges." ,  "Inspection Charges : AED \(price)")
                    
                    AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "Quotation Rejection", aStrMessage: strmsg, aCancelBtnTitle: "No", aOtherBtnTitle: "Yes") { (index, title) in
                        
                        if title == "Yes"
                        {
                            self.confirmQuotation()
                        }
                        
                    }
                }
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }
        }
        else
        {
            AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "Quotation Confirmation", aStrMessage: "Are you sure you want to confirm quotation?", aCancelBtnTitle: "No", aOtherBtnTitle: "Yes") { (index, title) in
                
                if title == "Yes"
                {
                    self.confirmQuotation()
                }
            }
        }
    }
    
    @IBAction func btnNoThanksClick(_ sender: Any) {
        
        ServerRequest.shared.GetServiceList(dictPara: [:], delegate: self) { (response) in
            
            let arrOtherServices = response.data.filter{$0.sapId == "S_OT0004"}
            
            if arrOtherServices.count > 0
            {
                let dictservice = arrOtherServices[0]
                let price = String(format: "%d", dictservice.price)

                let strmsg = String(format: "%@\n\n%@", "You will be charged for inspection charges." ,  "Inspection Charges : AED \(price)")
                
                AJAlertController.initialization1().showAlert(isBottomShow: true, aStrTitle: "Quotation Rejection", aStrMessage: strmsg, aCancelBtnTitle: "No", aOtherBtnTitle: "Yes") { (index, title) in
                    
                    if title == "Yes"
                    {
                        for i in 0..<self.quotationlisthandler.arrServices.count
                        {
                            let dict = self.quotationlisthandler.arrServices[i]
                            dict.isSelected = 0
                            self.quotationlisthandler.arrServices[i] = dict
                        }

                        self.arrSelectedServices = self.quotationlisthandler.arrServices.filter({$0.isSelected == 1})
                        self.confirmQuotation()

                    }
                    
                }
            }
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
    }
    
    //MARK: cancel request delegate
    
    func selectReason(reason: String, remark: String) {
        
//        self.cancelQuotation(reason: reason, remark: remark)
    }
    
    
    //MARK: WebService

    func confirmQuotation()
    {
        
        var dictParam = [String:String]()
        dictParam["confirm_by_other_person"] = "2"
        dictParam["status"] = (self.arrSelectedServices.count == 0) ? "3" : "2"
        dictParam["created_by"] = UserSettings.shared.getCustomerId()
        dictParam["currency_code"] = jobrequestData.currencyCode

        var i = 0

        for dictService in quotationlisthandler.arrServices
        {
            if dictService.isSelected == 1
            {
                // update job issue status , status - quotation approved
                let dictPara1  = ["status":"10"] as [String : String]
                ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: dictService.jobRequestItemData.id, dictPara: dictPara1)
                //-------------------------------
                
                for dictServicedata in dictService.serviceData
                {
                    if dictServicedata.isSelected == 1
                    {
                        for dictPartdata in dictServicedata.data
                        {
                            dictParam["confirmed_material_ids[\(i)]"] = String(format: "%d", dictPartdata.id)
                            i = i + 1
                        }
                    }
                }
            }
            else
            {
                if dictService.jobRequestItemData.status != 8
                {
                    // update job issue status , status - quotation Rejected
                    let dictPara1  = ["status":"11"] as [String : String]
                    ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: dictService.jobRequestItemData.id, dictPara: dictPara1)
                    //-------------------------------
                    
                    let arrReason = UserSettings.shared.initialData.reasonForAbandon.filter{$0.name == "Out of Scope"}

                    if arrReason.count > 0
                    {
                        let arrReasonType = UserSettings.shared.initialData.reasonForAbandonWithType.filter{$0.id == arrReason[0].id}
                        let arrReasonTypeNext = UserSettings.shared.initialData.reasonForAbandonNextStep.filter{$0.name == "CS- High Cost"}

                        let abandonedid = String(format: "%d", arrReason[0].id)
                        let abandonedTypeid = String(format: "%@", arrReasonType[0].name)
                        let abandonedTypeNextid = String(format: "%d", arrReasonTypeNext[0].id)

                        // update job issue status , status - issue Abandoned
                        let dictPara2  = ["status":"8","reason_for_abandon_type_id":abandonedTypeid,"reason_for_abandon_id" :abandonedid,"reason_for_abandon_next_step":abandonedTypeNextid] as [String : String]
                        ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: dictService.jobRequestItemData.id, dictPara: dictPara2)
                        //-------------------------------

                    }
                }
            }
        }

        print(dictParam)
        self.isLoading(loading: true)

        ServerRequest.shared.confirmJobQuotation(jobid: jobrequestData.id, dictPara: dictParam, signature: nil, delegate: nil) {
            
            print("selected services ::: \(self.arrSelectedServices.count)")

            DispatchQueue.main.async {
                
                
                let id  = String(format: "%d", self.jobrequestData.id)
                let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [id,"quote-store"]).absoluteString
                
                if self.arrSelectedServices.count == 0  // --- Rejected
                {
                    // update job status - status - inspection , sub_status - quotation rejected
                    let dict  = ["status":"3","sub_status":"11","request_info":dictParam,"request_url":serverUrl] as [String : Any]
                    
                    ServerRequest.shared.UpdateJobstatusApiIntegration1(jobid: self.jobrequestData.id, dictPara: dict, delegate: nil) { response in
                        
                        self.isLoading(loading: false)
                        
                        //------------------------- Log event --------------------------
             
                        let parameters = self.logeventPara()
                        Amplitude.instance().logEvent("Quotation Approved", withEventProperties:parameters)
                        
                        //--------------------------------------------------------------------


                        self.navigationController?.popToRootViewController(animated: true)

                        
                    } failure: { (errorMsg) in
                        
                        self.isLoading(loading: false)

                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                    }
                    

                    //-------------------------------
                }
                else if self.arrSelectedServices.count == self.quotationlisthandler.arrServices.count
                {
                    // update job status - status - inspection , sub_status - quotation approved
                    let dict  = ["status":"3","sub_status":"9","request_info":dictParam,"request_url":serverUrl] as [String : Any]
                    ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobrequestData.id, dictPara: dict, delegate: nil) {
                        
                        self.isLoading(loading: false)
                        
                   //------------------------- Log event --------------------------
        
                        let parameters = self.logeventPara()
                        Amplitude.instance().logEvent("Quotation Approved", withEventProperties:parameters )
                        
                   //--------------------------------------------------------------------

                        

                        self.navigationController?.popViewController(animated: true)

                    } failure: { (msg) in
                        
                        self.isLoading(loading: false)

                    }

                    //-------------------------------

                }
                else if self.arrSelectedServices.count < self.quotationlisthandler.arrServices.count
                {
                    self.isLoading(loading: false)

                    // update job status - status - inspection , sub_status - quotation partially approved
                    let dict  = ["status":"3","sub_status":"10","request_info":dictParam,"request_url":serverUrl] as [String : Any]
                    ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobrequestData.id, dictPara: dict)

                    //------------------------- Log event --------------------------
         
                    let parameters = self.logeventPara()
                    Amplitude.instance().logEvent("Quotation Partially Approved", withEventProperties:parameters)
                    
                    //--------------------------------------------------------------------

                    
                    self.navigationController?.popViewController(animated: true)

                }
            }

        } failure: { (errorMsg) in
            
            self.isLoading(loading: false)

            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }

    }
    
    func logeventPara() -> [String:Any]
    {
        // ------------------- Log event ---------------------------------

        let issuecategory = self.jobrequestData.jobrequestitems.map { String($0.items) }
        let issuecategoryIds = self.jobrequestData.jobrequestitems.map { String($0.jobcategory.name) }
        let issueCount = self.jobrequestData.issueCount
        
        var serviceCat = [String]()
        var serviceName = [String]()
        var serviceValue = [String]()
        
        var materialCat = [String]() //  not getting
        var materialName = [String]()
        var materialValue = [String]()

        
        for quotData in self.jobrequestData.jobQuotationData
        {
            for serviceData in quotData.serviceData
            {
                for detailData in serviceData.data
                {
                    if detailData.type == 1 // material
                    {
                        materialName.append(detailData.materialName)
                        materialValue.append(detailData.materialTotalPrice)
                    }
                    else
                    {
                        serviceCat.append(serviceData.serviceData.categoryId.toString())
                        serviceName.append(detailData.materialName)
                        serviceValue.append(detailData.materialTotalPrice)
                    }
                }
            }
        }
    

        let issuecatIds = issuecategoryIds.joined(separator: ",")
        let issueTitles = issuecategory.joined(separator: ",")
        
        var sULocation = ""
        var performerPrimarySkill = ""
        var performerOtherSkills = ""

        let sUdata = self.jobrequestData.employeeData.employeeSlotGroup ?? []
        if sUdata.count > 0
        {
            sULocation = sUdata[0].serviceLocation.location.name
            performerPrimarySkill = sUdata[0].primarySkill.name
            performerOtherSkills = sUdata[0].otherSkill
        }
        

        let dictPara = ["Job ID":self.jobrequestData.id,
                        "Issue Count":issueCount,
                        "Issue Category":issuecatIds,
                        "Issue Title":issueTitles,
                        "Property ID":self.jobrequestData.propertyId,
                        "Property Map Location":(self.jobrequestData.propertyData.gLocation ?? ""),
                        "Property Geofence Location":(self.jobrequestData.propertyData.gLocation ?? ""),
                        "Customer ID":UserSettings.shared.getCustomerId(),
                        "Customer Category":self.jobrequestData.customerData.customerType,
                        "Customer Property Count":self.jobrequestData.customerData.totalProperty,
                        "App User ID":UserSettings.shared.getCustomerId(),
                        "Contact ID":"",
                        "Contact Type":"",
                        "Performer ID":self.jobrequestData.employeeData.sapId,
                        "Performer Primary Skill":performerPrimarySkill,
                        "Performer Other Skill":performerOtherSkills,
                        "Service Unit ID":self.jobrequestData.employeeData.sauSapId,
                        "Service Unit Location":sULocation,
                        "Performer Count":"",
                        "Performer Issue Category":"",
                        "Performer Issue Title":"",
                        "Service Category":serviceCat.joined(separator: ","),
                        "Service Name":serviceName.joined(separator: ","),
                        "Service Value":serviceValue.joined(separator: ","),
                        "Material Category":materialCat,
                        "Material Name":materialName.joined(separator: ","),
                        "Material Value":materialValue.joined(separator: ",")] as [String : Any]
        
        return dictPara
    }
    
    func setTransactionData(inspectionCharge:Double)
    {
        let vatTaxValue = (inspectionCharge * Double(self.jobrequestData.vatPercentage))/100
        let total = inspectionCharge + vatTaxValue
        
        print(inspectionCharge)
        print(total)

        let dictCustomer = ["name" : jobrequestData.customerName as Any ,"email" : jobrequestData.customerData.email ,"street1" : jobrequestData.propertyData.fullAddress,"city":jobrequestData.propertyData.gLocation] as [String:Any] //,"state":"DU","country":"AE"

        
        let jobId = String(format: "%d", jobrequestData.id)
        let params  = ["profile_id":pt_profileID,"tran_type":"sale","tran_class": "ecom","cart_id":jobId,"cart_currency": "AED","cart_amount": total,"cart_description": "invoice data","paypage_lang": "en","hide_shipping": true,"callback": String(format: "%@/job-request/callback", ApiConfig.shared.baseUrl),"return":String(format: "%@/job-request/return", ApiConfig.shared.baseUrl),"customer_details":dictCustomer] as [String : Any]

        ServerRequest.shared.CreateTransactionApi(dict: params, delegate: nil) { (response) in

            DispatchQueue.main.async
            {
                var dictData = response
                let jobId = String(format: "%d", self.jobrequestData.id)

                dictData["customer_id"] = self.jobrequestData.customerId
                dictData["performer_id"] = self.jobrequestData.employeeId
                dictData["job_request_id"] = jobId
                dictData["payment_mode"] = 1 // link
                dictData["status_code"] = "P"
                dictData["status"] = "Pending"
                dictData["payment_request_details"] = params
                let datef = DateFormatter()
                datef.dateFormat = "dd/MM/yyyy HH:mm:ss"
                dictData["payment_at"] = datef.string(from: Date())
                dictData["payment_transaction_details"] = [:]

                self.storeTransactionData(dictData: dictData)
            }

        } failure: { (errorMsg) in
            
            self.isLoading(loading: false)

            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }


    }
    
    func storeTransactionData(dictData:[String:Any])
    {
        ServerRequest.shared.StoreTransactionApi(dict: dictData, delegate: nil) { (response) in
            
            self.isLoading(loading: false)

            let review = REVIEW_PAYMENT.create(jobData: nil , jobId: self.jobrequestData.id,comeFrom: "list")
            self.navigationController?.pushViewController(review, animated: true)

        } failure: { (errorMsg) in
            
            self.isLoading(loading: false)

            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }


    }
   
//    func cancelQuotation(reason: String, remark: String)
//    {
//        ServerRequest.shared.CancelQuotation(jobRequestId: jobrequestData.id, reason: reason, comment: remark, delegate: self) {
//
//            // update job status - status - inspection , sub_status - quotation rejected
//
//            let requestId = String(format: "%d", self.jobrequestData.id)
//
//            let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [requestId,"additional-update"]).absoluteString
//
//            let params = ["job_request_id":requestId,"cacellation_reason":reason,"cacellation_remarks":remark,"updated_by":UserSettings.shared.getCustomerId()] as [String : Any]
//
//            let dict  = ["status":"3","sub_status":"11","request_info":params,"request_url":serverUrl] as [String : Any]
//            ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobrequestData.id, dictPara: dict)
//            //-------------------------------
//
//            self.navigationController?.popToRootViewController(animated: true)
//
//
//        } failure: { (errorMsg) in
//            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
//        }
//
//    }
    
}
extension QUOTATIONVIEW : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
