//
//  PAYMENT_SELECTION.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 05/01/21.
//

import UIKit
import PaymentSDK
import Amplitude_iOS

class PAYMENT_SELECTION: UIViewController {
        
    static func create(jobData:JobIssueList,total : Double = 0) -> UINavigationController? {
        let navc = ImShStoryboards.Jobs.initialViewController() as? UINavigationController
        let selection = PAYMENT_SELECTION.instantiate(fromImShStoryboard: .Jobs)
        selection.jobRequestData = jobData
        selection.total = total
        navc?.navigationBar.isHidden = true
        navc?.setViewControllers([selection], animated: true)
        return navc
    }

   
    //MARK:Outlets
    
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var btnDown: UIButton!

    @IBOutlet weak var tblPayment: UITableView!
    @IBOutlet weak var tblCards: UITableView!

    @IBOutlet weak var lblPayUsing: UILabel!
    
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var btnAddNewPayment: UIButton!
    
    @IBOutlet weak var conTblcardHeight: NSLayoutConstraint!


    // PayTabs sdk settings
    var billingDetails: PaymentSDKBillingDetails!
    var shippingDetails: PaymentSDKShippingDetails!
    var isNewPayment : Bool!
    var jobRequestData : JobIssueList!
    var total : Double = 0
    var isCancelled : Bool = false
    var isCash : Bool = false

    
    // MARK: PRIVATE

    private let selectionthandler = PaymentSelectionTableHandler()
    private let cardhandler = CardListTableHandler()
    private var isNormalFlow : Bool = false

    var cardDict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPayment.isEnabled = false
        btnPayment.alpha = 0.5


        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.setLabel()
        self.ImShSetLayout()
        
    }
    
    override func ImShSetLayout() {
        
        if UserSettings.shared.isQuotationRejected(jobRequestData: self.jobRequestData)
        {
            let arrPayInfo = self.jobRequestData.paymenttransaction.filter{$0.statusCode == "A"}
            if self.jobRequestData.jobotherservices.count > 0 && arrPayInfo.count == 0
            {
                isCancelled = true
            }
        }

        self.tblCards.isHidden = true
        self.footerView.isHidden = true

        self.tblPayment.estimatedRowHeight = 50
        self.tblPayment.rowHeight = UITableView.automaticDimension
        
        selectionthandler.arrMethods = [["name":"Cash","isSelected":"0"], ["name":"Debit/Credit Card","isSelected":"0"]]
        self.tblPayment.setUpTable(delegate: selectionthandler, dataSource: selectionthandler, cellNibWithReuseId: PaymentSelectionCell.className)
        
        cardhandler.strcomeFrom = "selection"
        cardhandler.cardArr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
        // UserDefaults.standard.value(forKey: "cards") as? [[String : Any]] ?? []
        self.tblCards.setUpTable(delegate: cardhandler, dataSource: cardhandler, cellNibWithReuseId: CardCell.className)

        self.conTblcardHeight.constant =  CGFloat(cardhandler.cardArr.count * 100)
        self.tblCards.updateConstraintsIfNeeded()
        self.tblCards.layoutIfNeeded()
        
        /// Handling actions
        
        selectionthandler.SelectMethodClick = {(indexpath , isSelected) in
            
            for i in 0..<self.selectionthandler.arrMethods.count
            {
                var dict = self.selectionthandler.arrMethods[i]
                if i == indexpath.row
                {
                   dict["isSelected"] = "1"
                }
                else
                {
                   dict["isSelected"] = "0"
                }
                
                self.selectionthandler.arrMethods[i] = dict
            }
            self.tblPayment.reloadData()
            self.cardDict.removeAll()
            
            if indexpath.row == 0
            {
                self.isCash = true
                self.tblCards.isHidden = true
                self.footerView.isHidden = true
                self.btnPayment.isEnabled = true
                self.btnPayment.alpha = 1
            }
            else
            {
                self.isCash = false
                self.tblCards.isHidden = false
                self.footerView.isHidden = false
                
                for i in 0..<self.cardhandler.cardArr.count
                {
                    var dict1 = self.cardhandler.cardArr[i]
                    dict1["isSelected"] = "0"
                    self.cardhandler.cardArr[i] = dict1
                }
                
                self.tblCards.reloadData()
                self.btnPayment.isEnabled = false
                self.btnPayment.alpha = 0.5

            }
        }

        cardhandler.SelectMethodClick = {(indexpath , dict) in
            if !dict.isEmpty
            {
                self.cardDict.removeAll()
                self.cardDict = dict
                self.btnPayment.isEnabled = true
                self.btnPayment.alpha = 1
            }
            else
            {
                self.cardDict.removeAll()
                self.btnPayment.isEnabled = false
                self.btnPayment.alpha = 0.5

            }
        
        }
        
        cardhandler.deleteTapped = { (indexPath) in
            self.cardhandler.cardArr.remove(at: indexPath.row)
            self.tblCards.deleteRows(at: [indexPath], with: .left)
            self.tblCards.reloadData()
            self.conTblcardHeight.constant =  CGFloat(self.cardhandler.cardArr.count * 100)
            self.tblCards.updateConstraintsIfNeeded()
            self.tblCards.layoutIfNeeded()
        }

    }
    
    func setLabel()
    {
        lblPayUsing.text = "PAY USING"
        btnPayment.setTitle("CONTINUE", for: .normal)

    }
    override func viewWillLayoutSubviews() {
        
        viewInfo.roundCorners(corners: [.topLeft,.topRight] , radius: 25.0)

        if let aSize = btnPayment.titleLabel?.font?.pointSize
        {
            btnPayment.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
      
    }
    
    //MARK: Buttton Methods
    
    @IBAction func btnPaymentClick(_ sender: Any) {
        
        if isCash == true
        {
            let todate = Date()
            let dateF = DateFormatter()
            dateF.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let strDate = dateF.string(from: todate)
            
            let Paydata =  ["tran_type": "Sale", "cart_description": "invoice data", "cart_id": self.jobRequestData.id,  "cart_currency": "AED", "customer_id": UserSettings.shared.getCustomerId(), "performer_id": self.jobRequestData.employeeId, "cart_amount": self.total, "job_request_id": self.jobRequestData.id, "payment_mode": 3,"payment_at":strDate] as [String : Any]
            
            ServerRequest.shared.StoreTransactionApi(dict: Paydata, delegate: nil) { (response) in
                
                DispatchQueue.main.async
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Awaiting for the technician's confirmation.", aOKBtnTitle: "OK") { (index, title) in
                        
                        let storyboard = UIStoryboard.init(name: "Jobs", bundle: nil)
                        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                        AppDelegate.shared.window?.rootViewController = navigationController
                        AppDelegate.shared.window?.makeKeyAndVisible()
                    }
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }

        }
        else
        {
            self.isNewPayment = false
            self.paymentSettings()

        }
        

        
    }
    
    @IBAction func btnNewPaymentClick(_ sender: Any) {

        self.isNewPayment = true
        self.paymentSettings()
    }
    
    @IBAction func btnDownClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    //MARK: PayTabs Methods
    
    func paymentSettings()
    {
        billingDetails = PaymentSDKBillingDetails(name: jobRequestData.customerName,
                                                  email: jobRequestData.customerData.email,
                                                  phone: jobRequestData.customerData.mobile,
                                                  addressLine: jobRequestData.propertyData.fullAddress,
                                                  city: jobRequestData.propertyData.gLocation,
                                                  state: jobRequestData.propertyData.gLocation,
                                                  countryCode: "AE",
                                                  zip: "")
        
        shippingDetails = PaymentSDKShippingDetails(name: jobRequestData.customerName,
                                                    email: jobRequestData.customerData.email,
                                                    phone: jobRequestData.customerData.mobile,
                                                    addressLine: jobRequestData.customerData.address,
                                                    city: jobRequestData.propertyData.gLocation,
                                                    state: jobRequestData.propertyData.gLocation,
                                                    countryCode: "AE",
                                                    zip: "")
       
        paymentForCard()

    }
    

    
    func paymentForCard()
    {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "homefinch-Black")
        
        theme.secondaryColor = UserSettings.shared.themeColor()
        theme.titleFontColor = UserSettings.shared.themeColor()
        theme.buttonColor = UserSettings.shared.themeColor()
        theme.titleFontColor = UserSettings.shared.themeColor2()
        theme.secondaryFontColor = UserSettings.shared.themeColor2()
        
        theme.titleFont = UIFont.roboto(size: 15, weight: .Medium)
        theme.buttonFont = UIFont.roboto(size: 15, weight: .Medium)
        theme.secondaryFont = UIFont.roboto(size: 13, weight: .Medium)

        
        let configuration1 = PaymentSDKConfiguration(profileID: pt_profileID,
                                            serverKey: pt_serverKey,
                                            clientKey: pt_clientKey,
                                            cartID: jobRequestData.id.toString(),
                                            currency: "AED",
                                            amount: total,
                                            cartDescription: "invoice data",
                                            merchantCountryCode: "AE", // ISO alpha 2
                                            showBillingInfo: false,
                                            screenTitle: "Pay with Card",
                                            hideCardScanner: true,
                                            billingDetails: billingDetails)

        configuration1.theme = theme
        configuration1.tokeniseType = .userOptinoal
        configuration1.tokenFormat = .digit16
        
        if !cardDict.isEmpty && self.isNewPayment == false
        {
            configuration1.transactionReference = cardDict["ref"] as? String ?? ""
            configuration1.token = cardDict["token"] as? String ?? ""
        }
        
        PaymentManager.startCardPayment(on: self, configuration: configuration1,
                                 delegate: self)
    }

    private func showAlert(message:String,type:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            let alert = UIAlertController(title: type, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
            self.present(alert, animated: true, completion: nil)
            
        }
       
    }
    
    //MARK: Payment Server APi
    
    func storeTransactionData(dictData:[String:Any], success : Bool)
    {
        let strMsg = success ? "Payment has been done successfully" : "Transaction has been failed."
        let strTitle = success ? "Thank You" : "Ohh Sorry"

        ServerRequest.shared.StoreTransactionApi(dict: dictData, delegate: nil) { (response) in
            
            DispatchQueue.main.async
            {
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: strTitle, aStrMessage: strMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                    if success
                    {
                        if self.isCancelled
                        {
                            // ----------  update job status , status - cancelled , sub-status - Customer
                            print("cancelledddddd Status Update")

                            let serverUrl =  ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store-payment-request"]).absoluteString
                            
                            let dictStatus  = ["status":"6","sub_status":"18","request_info":dictData,"request_url":serverUrl] as [String : Any]
                            ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobRequestData.id, dictPara: dictStatus)
                            
                            
                            //------------------------- Log event --------------------------
                 
                            let parameters = self.logeventPara()
                            Amplitude.instance().logEvent("Cancelled", withEventProperties:parameters)
                            
                            //--------------------------------------------------------------------

                        }
                        
                        let storyboard = UIStoryboard.init(name: "Jobs", bundle: nil)
                        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                        AppDelegate.shared.window?.rootViewController = navigationController
                        AppDelegate.shared.window?.makeKeyAndVisible()
                    }
                    else
                    {
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    
                }
            }
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
    }
    
    func completeJobstatus()
    {
        ServerRequest.shared.jobCompleteupdate(id: jobRequestData.id, delegate: nil, completion: {
            
        }, failure: { (errorMsg) in
            
        })
    }
    
    func logeventPara() -> [String:Any]
    {
        // ------------------- Log event ---------------------------------

        let issuecategory = self.jobRequestData.jobrequestitems.map { String($0.items) }
        let issuecategoryIds = self.jobRequestData.jobrequestitems.map { String($0.jobcategory.name) }
        let issueCount = self.jobRequestData.issueCount
        
        var serviceCat = [String]()
        var serviceName = [String]()
        var serviceValue = [String]()
        
        var materialCat = [String]() //  not getting
        var materialName = [String]()
        var materialValue = [String]()

        
        for quotData in self.jobRequestData.jobQuotationData
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

        let sUdata = self.jobRequestData.employeeData.employeeSlotGroup ?? []
        if sUdata.count > 0
        {
            sULocation = sUdata[0].serviceLocation.location.name
            performerPrimarySkill = sUdata[0].primarySkill.name
            performerOtherSkills = sUdata[0].otherSkill
        }
        

        let dictPara = ["Job ID":self.jobRequestData.id,
                        "Issue Count":issueCount,
                        "Issue Category":issuecatIds,
                        "Issue Title":issueTitles,
                        "Property ID":self.jobRequestData.propertyId,
                        "Property Map Location":(self.jobRequestData.propertyData.gLocation ?? ""),
                        "Property Geofence Location":(self.jobRequestData.propertyData.gLocation ?? ""),
                        "Customer ID":UserSettings.shared.getCustomerId(),
                        "Customer Category":self.jobRequestData.customerData.customerType,
                        "Customer Property Count":self.jobRequestData.customerData.totalProperty,
                        "App User ID":UserSettings.shared.getCustomerId(),
                        "Contact ID":"",
                        "Contact Type":"",
                        "Performer ID":self.jobRequestData.employeeData.sapId,
                        "Performer Primary Skill":performerPrimarySkill,
                        "Performer Other Skill":performerOtherSkills,
                        "Service Unit ID":self.jobRequestData.employeeData.sauSapId,
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
    
}
extension PAYMENT_SELECTION: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            
            
            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            print("Card: " + (transactionDetails.cartDescription ?? "" ))
            

            print(transactionDetails.debugDescription)
            
            guard let encodedData = try? JSONEncoder().encode(transactionDetails) else { return  }
            do {
                
                let jsonString = String(data: encodedData,
                                        encoding: .utf8) ?? ""
                
                let dictDetails = convertToDictionary(text: jsonString)
                // -----------------------  Transaction Api
                
                let reqdata = ["CardId":transactionDetails.cartID,"Currency":transactionDetails.cartCurrency,"Amount":transactionDetails.cartAmount,"CartDescription":transactionDetails.cartDescription,"Countrycode":transactionDetails.billingDetails?.countryCode]
                
                let Paydata =  ["tran_type": "Sale", "cart_description": "invoice data", "cart_id": transactionDetails.cartID,  "cart_currency": "AED", "tran_ref": transactionDetails.transactionReference, "customer_id": UserSettings.shared.getCustomerId(), "performer_id": self.jobRequestData.employeeId, "cart_amount": transactionDetails.cartAmount, "job_request_id": self.jobRequestData.id, "payment_mode": 2, "payment_at":transactionDetails.paymentResult?.transactionTime,"payment_transaction_details":dictDetails,"payment_request_details":reqdata,"status_code":transactionDetails.paymentResult?.responseStatus,"status":transactionDetails.paymentResult?.responseMessage] as [String : Any]

                
                let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store-payment-request"]).absoluteString
                
                if transactionDetails.paymentResult?.responseStatus == "A"
                {
                    if isCancelled
                    {
                        // ----------  update job status , status - payment , sub-status - Success
                        print("cancelledddddddddddddd")
                        let dictStatus  = ["status":"5","sub_status":"15","request_info":Paydata,"request_url":serverUrl] as [String : Any]
                        ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobRequestData.id, dictPara: dictStatus)
                    }
                    else
                    {
                        // ----------  update job status , status - payment , sub-status - Success
                        let dictStatus  = ["status":"5","sub_status":"15","request_info":Paydata,"request_url":serverUrl] as [String : Any]
                        ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobRequestData.id, dictPara: dictStatus)
                    }
                    
                    self.storeTransactionData(dictData: Paydata, success: true)

                }
                else  if transactionDetails.paymentResult?.responseStatus == "D"
                {
                    // -------   update job status , status - payment , sub-status - Failed
                    let dictStatus  = ["status":"5","sub_status":"16","request_info":Paydata,"request_url":serverUrl] as [String : Any]
                    ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.jobRequestData.id, dictPara: dictStatus)
                    
                    self.storeTransactionData(dictData: Paydata, success: false)

                }
                
                //-----------------------------------------------------------
                
                var dict = [String:Any]()
                
                let token = transactionDetails.token ?? ""
                
                if !token.isEmpty
                {
                    let arr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
                    
                    var cardArr = arr
                    if let ref = transactionDetails.transactionReference{
                        dict["ref"] = ref
                    }
                    if let last4 = transactionDetails.paymentInfo?.paymentDescription{
                        dict["last4"] = last4
                    }
                    
                    if let code = transactionDetails.paymentInfo?.cardScheme{
                        dict["code"] = code
                    }
                    
                    if let name = transactionDetails.billingDetails?.name{
                        dict["name"] = name
                    }
                    
                    if let name = transactionDetails.token{
                        dict["token"] = name
                    }
                    
                    if !cardArr.contains(where: {$0["last4"] as? String == dict["last4"] as? String})
                    {
                        cardArr.append(dict)
                    }
                    
                    CommonFunction.shared.SaveArrayDatainTextFile(fileName: "card.txt", arrData: cardArr)

                }




            } catch let error {
                print("Copy Error: \(error.localizedDescription)")
            }
            
        } else if let error = error {
            showAlert(message: error.localizedDescription, type: "")
        }
    }
    
    func paymentManager(didCancelPayment error: Error?) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
extension PAYMENT_SELECTION : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
