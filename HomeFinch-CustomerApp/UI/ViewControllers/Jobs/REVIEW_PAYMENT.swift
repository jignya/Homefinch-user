//
//  REVIEW_PAYMENT.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/01/21.
//

import UIKit
import PaymentSDK
import Amplitude_iOS

class REVIEW_PAYMENT: UIViewController {
    
    static func create(jobData:JobIssueList? = nil , jobId : Int = 0,comeFrom:String = "") -> REVIEW_PAYMENT {
        let list = REVIEW_PAYMENT.instantiate(fromImShStoryboard: .Jobs)
        list.jobRequestData = jobData
        list.jobId = jobId
        list.comeFrom = comeFrom
        return list
    }
   
    //MARK:Outlets
    
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnSelectWallet: UIButton!

    
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var conTblserviceHeight: NSLayoutConstraint!
    @IBOutlet weak var viewButton: UIView!
    
    
    @IBOutlet weak var lblServiceSubTotal: UILabel!
    @IBOutlet weak var lblServiceSubTotalValue: UILabel!
    
    @IBOutlet weak var lblVatTax: UILabel!
    @IBOutlet weak var lblVatTaxValue: UILabel!

    
    @IBOutlet weak var lblUseYour: UILabel!
    @IBOutlet weak var lblWalletBalance: UILabel!
    
    @IBOutlet weak var txtPromocode: UITextField!
    @IBOutlet weak var viewPromoCode: UIView!
    
    @IBOutlet weak var viewTotals: UIView!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblWalletBalUsed: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPromoCode: UILabel!
    
    @IBOutlet weak var lblSubTotalValue: UILabel!
    @IBOutlet weak var lblWalletAmountUsed: UILabel!
    @IBOutlet weak var lblDiscountAmount: UILabel!
    @IBOutlet weak var lblPromocodeAmount: UILabel!
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblGrandTotalValue: UILabel!
    
    @IBOutlet weak var lblReportInfo: UILabel!
    
    @IBOutlet weak var lblCardValue: UILabel!
    @IBOutlet weak var lblPayUsing: UILabel!
    
    @IBOutlet weak var btnPaymentMethod: UIButton!
    @IBOutlet weak var viewCompletionReport: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: PRIVATE

    private let servicelisthandler = ReviewListTableHandler()
    var jobRequestData : JobIssueList!

    // PayTabs sdk settings
    var billingDetails: PaymentSDKBillingDetails!
    var shippingDetails: PaymentSDKShippingDetails!
    var isNewPayment : Bool!
    var total : Double = 0
    var isCancelled : Bool = false
    var jobId : Int!
    var comeFrom : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.setLabel()
        self.ImShSetLayout()
        
        if self.jobRequestData != nil
        {
            self.setData(response: jobRequestData)
        }
        else
        {
            self.fetchJobRequestDetail()
        }
        
        
        if #available(iOS 15.0, *) {
            self.tblServices.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func ImShSetLayout() {
        
        self.tblServices.setUpTable(delegate: servicelisthandler, dataSource: servicelisthandler, cellNibWithReuseId: ReviewCell.className)
        
        let cardArr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
        
        self.lblCardValue.isHidden = true
        if cardArr.count > 0
        {
            let dict = cardArr[0]
            let cardNum = String(format: "%@", (dict["last4"] as? String ?? ""))
            self.lblCardValue.text = String(format: "Card(xx-%@)", String(cardNum.suffix(4)))
            self.lblCardValue.isHidden = false
        }
    }
    
    func setLabel()
    {
        lblTitle.text = "Review & Payment"
        lblServiceSubTotal.text = "Sub Total"
        lblUseYour.text = "Use Your"
        txtPromocode.placeholder = "Promo Code"
        
        lblSubTotal.text = "Sub Total"
        lblWalletBalUsed.text = "Wallet Balance"
        lblDiscount.text = "Discount"
        lblPromoCode.text = "Promo Code"
        
        lblGrandTotal.text = "Grand Total"
        lblReportInfo.text = "Please tap below button to see/download Work Completion Report"

        lblPayUsing.text = "PAY USING"

        
        btnConfirm.setTitle("PAYMENT", for: .normal)
        btnReport.setTitle("WORK COMPLETION REPORT", for: .normal)
        btnApply.setTitle("APPLY", for: .normal)

    }
    override func viewWillLayoutSubviews() {
        
        // shadow effect bottom view
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.viewButton.frame.size.width + shadowSize,
                                                   height: self.viewButton.frame.size.height + shadowSize))
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
        if let aSize = btnApply.titleLabel?.font?.pointSize
        {
            btnApply.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnReport.titleLabel?.font?.pointSize
        {
            btnReport.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
    }
    
    func setData(response : JobIssueList)
    {
        //----------  service/part listing
        var subtotal : Double = 0
        
        var arrServicesList = [ServiceData]()
        var arrMaterialList = [JobIssueList]()
        

        var arrServicesList1 = [JobserviceFilterData]()
        var arrMaterialList1 = [JobIssueListFilterData]()


        for dict in response.jobQuotationData
        {
            if dict.jobRequestItemData.status == 15 // condition once complete service then total will be calculate
            {
                subtotal = Double(dict.sum) + subtotal
                
                if dict.serviceData.count > 0
                {
                    arrServicesList.append(contentsOf:dict.serviceData)
                    
                }
                
                for dictservicedata in dict.serviceData
                {
//                    let arrM = dictservicedata.data.filter({$0.type == 1 || $0.isExtra == 1})
                    let arrM = dictservicedata.data.filter({$0.type == 1})
                    
                    arrMaterialList.append(contentsOf:arrM)
                }
                
            }
            
        }
        
        // remove duplicate services / materials
        
        let groupByCompany = Dictionary(grouping: arrServicesList) { $0.serviceData.serviceIdSap }
        
        print(groupByCompany)
        
        for item in arrServicesList
        {
            let service = JobserviceFilterData.init()
            service.serviceDescription = item.serviceData.serviceDescription
            service.price = item.serviceData.price
            service.serviceIdSap = item.serviceData.serviceIdSap
            service.isAdditionalHours = item.serviceData.isAdditionalHours
            service.data = item.data
            service.currencyCode = item.serviceData.currencyCode
            
            if arrServicesList1.contains(where: {$0.serviceIdSap == item.serviceData.serviceIdSap})
            {
                var price : Double = 0
                var quantity : Float = 0

                let arrRR = arrServicesList1.filter{$0.serviceIdSap == item.serviceData.serviceIdSap}
                
                if item.serviceData.isAdditionalHours == 1 && item.data.count == 1
                {
                    quantity = Float(item.data[0].materialQuantity) ?? 0
                    price = Double(item.data[0].materialTotalPrice) ?? 0
                    for data1 in arrRR
                    {
                        price = (Double(data1.data[0].materialTotalPrice) ?? 0) + price
                        quantity = quantity + (Float(data1.data[0].materialQuantity) ?? 0)
                    }
                    
                }
                else
                {
                    quantity = Float(item.serviceData.serviceQty)
                    price = Double(item.serviceData.price) ?? 0
                    for data1 in arrRR
                    {
                        price = (Double(data1.price) ?? 0) + price
                        quantity = quantity + data1.serviceQty
                    }
                    
                    
                }
                
                arrServicesList1.removeAll(where:{$0.serviceIdSap == item.serviceData.serviceIdSap})
                service.price =  String(format: "%.2f", price)
                service.serviceQty = quantity
                arrServicesList1.append(service)

            }
            else
            {
                
                if item.serviceData.isAdditionalHours == 1 && item.data.count == 1
                {
                    service.price = item.data[0].materialTotalPrice
                    service.serviceQty = (Float(item.data[0].materialQuantity) ?? 0)
                }
               
                arrServicesList1.append(service)
            }
            

        }
        
        for item in arrMaterialList
        {
            let material = JobIssueListFilterData.init()
            material.materialName = item.materialName
            material.materialQuantity = item.materialQuantity
            material.materialTotalPrice = item.materialTotalPrice
            material.currencyCode = item.currencyCode
            material.referenceId = item.referenceId
            
            if arrMaterialList1.contains(where: {$0.referenceId == item.referenceId})
            {
                var price : Double = 0
                var qty : Int = (Int(item.materialQuantity) ?? 0)

                let arrRR = arrMaterialList1.filter{$0.referenceId == item.referenceId}
                
                price = (Double(item.materialTotalPrice) ?? 0)
                for data1 in arrRR
                {
                    qty = (Int(data1.materialQuantity) ?? 0) + qty
                    price = (Double(data1.materialTotalPrice) ?? 0) + price
                }
                
                arrMaterialList1.removeAll(where:{$0.referenceId == item.referenceId})
                material.materialTotalPrice =  String(format: "%.2f", price)
                material.materialQuantity =  String(format: "%d", qty)
                arrMaterialList1.append(material)
            }
            else
            {
                arrMaterialList1.append(material)
            }

        }
        
        let otherServiceArr = response.jobotherservices ?? [] //response.jobotherservices.filter{$0.sapId == "S_OT0002"}  // high demand charges
        
        for dict in otherServiceArr
        {
            subtotal = (Double(dict.serviceTotalPrice) ?? 0.0) + subtotal
        }


        //---------------------------------------------------------
        
        if subtotal == 0
        {
            self.lblGrandTotalValue.text = String(format: "%@ %d", response.currencyCode != "" ? response.currencyCode : "AED" ,subtotal)
        }
        else
        {
//            self.viewSubTotal.isHidden = false
//            self.viewVatTax.isHidden = false
            
            var vatTaxValue : Double = 0.0
            var vatTax : Int = 0
            if response.jobquote != nil
            {
                vatTax = response.jobquote.vatPercentage
                vatTaxValue = (subtotal * Double(response.jobquote.vatPercentage))/100
            }
            else
            {
                vatTax = response.vatPercentage
                vatTaxValue = (subtotal * Double(response.vatPercentage))/100
            }

            total = subtotal + vatTaxValue

            self.lblVatTax.text = String(format: "Value Added Tax (%d%@)", vatTax,"%")
            self.lblVatTaxValue.text = String(format: "%@ %.2f", response.currencyCode != "" ? response.currencyCode : "AED" ,vatTaxValue)


            self.lblServiceSubTotal.text = "Sub Total"
            self.lblServiceSubTotalValue.text = String(format: "%@ %.2f", response.currencyCode != "" ? response.currencyCode : "AED" ,subtotal)
            self.lblSubTotalValue.text = String(format: "%@ %.2f", response.currencyCode != "" ? response.currencyCode : "AED" ,subtotal)


            self.lblGrandTotalValue.text = String(format: "%@ %.2f", response.currencyCode != "" ? response.currencyCode : "AED" ,total)

        }
        
        self.lblDiscountAmount.text = String(format: "AED %d", 0)
        self.lblWalletAmountUsed.text = String(format: "AED %d", 0)
        self.lblPromocodeAmount.text = String(format: "AED %d", 0)

       
        //------------  Table data assigning for service/parts and table height calculation
        
        servicelisthandler.arrMaterialList = arrMaterialList1
        servicelisthandler.arrServicesList = arrServicesList1
        
        servicelisthandler.arrOtherServiceList = otherServiceArr

        self.tblServices.reloadData()
        self.tblServices.updateConstraintsIfNeeded()
        self.tblServices.layoutIfNeeded()
        self.conTblserviceHeight.constant = CGFloat(arrMaterialList1.count * 30) + CGFloat(arrServicesList1.count * 30) + CGFloat(otherServiceArr.count * 30) + (((servicelisthandler.arrServicesList.count == 0) && (otherServiceArr.count == 0)) ? 0 :30) + ((servicelisthandler.arrMaterialList.count == 0) ? 0 :30)

        
        self.viewCompletionReport.isHidden = false
        
        if UserSettings.shared.isQuotationRejected(jobRequestData: response)
        {
            let arrPayInfo = response.paymenttransaction.filter{$0.statusCode == "A"}
            if response.jobotherservices.count > 0 && arrPayInfo.count == 0
            {
                isCancelled = true
                self.viewCompletionReport.isHidden = true
            }
        }

    }
    
    
    //MARK: Web service
    
    func fetchJobRequestDetail()
    {
        ServerRequest.shared.GetJobRequestDetail(requestId: jobId, delegate: self) { (response) in
            DispatchQueue.main.async {
                self.jobRequestData = response
                self.setData(response: response)
            }
            
        } failure: { (errMsg) in
            
        }

    }
    
    
    //MARK: Buttton Methods
    
    @IBAction func btnConfirmClick(_ sender: Any) {
        
        self.paymentSettings()
        
//        let payment =  PAYMENT_VIEW.create(strAmount: "100", isNew: true , dict: [:], comeFrom: "review")
//        self.navigationController?.pushViewController(payment, animated: false)

    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        if comeFrom == "list"
        {
            let storyboard = UIStoryboard.init(name: "Jobs", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            AppDelegate.shared.window?.rootViewController = navigationController
            AppDelegate.shared.window?.makeKeyAndVisible()
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }

    }
   
    @IBAction func btnReportClick(_ sender: Any) {
        self.DownloadPDfUrl()
    }
    
    func DownloadPDfUrl()
    {
        if let jobId  = self.jobRequestData.id
        {
            self.isLoading(loading: true)
            
            let urlString = String(format: "%@/job/%d/report",ApiConfig.shared.baseUrl1, jobId)
//            let url = URL(string: urlString)
            let fileName = String(format: "homefinch-job-request-report-%d", jobId) //String((url!.lastPathComponent)) as NSString
            // Create destination URL
            guard let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName).pdf")
            //Create URL to the source file you want to download
            let fileURL = URL(string: urlString)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = URLRequest(url:fileURL!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    
                    self.isLoading(loading: false)
                    
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                    }
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        
                        //                        DispatchQueue.main.async{
                        //
                        //                            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Downloaded successfully on your phone", aOKBtnTitle: "OK") { (index, title) in
                        //                            }
                        //                        }
                        
                        
                        DispatchQueue.main.async{
                            
                            do {
                                //Show UIActivityViewController to save the downloaded file
                                let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                                for indexx in 0..<contents.count {
                                    if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                        let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                        self.present(activityViewController, animated: true, completion: nil)
                                    }
                                }
                                
                            }
                            catch (let err) {
                                print("error: \(err)")
                            }
                            
                        }
                        
                        
                    } catch (let writeError) {
                        
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        if writeError.localizedDescription.contains("already exists")
                        {
                            do
                            {
                                try FileManager.default.removeItem(at: destinationFileUrl)
                                
                                try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                                
                                DispatchQueue.main.async{
                                    
                                    do {
                                        //Show UIActivityViewController to save the downloaded file
                                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                                        for indexx in 0..<contents.count {
                                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                                self.present(activityViewController, animated: true, completion: nil)
                                            }
                                        }
                                        
                                    }
                                    catch (let err) {
                                        print("error: \(err)")
                                    }
                                    
                                }
                                
                            }catch (let writeError) {
                                
                            }
                        }
                    }
                } else {
                    print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
                    DispatchQueue.main.async{
                        SnackBar.make(in: self.view, message: "Error took place while downloading a file", duration: .lengthShort).show()
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func btnPayUsingClick(_ sender: Any) {

        if let selectionnavvc = PAYMENT_SELECTION.create(jobData: self.jobRequestData,total: self.total) {
            selectionnavvc.modalPresentationStyle = .overCurrentContext
            self.present(selectionnavvc, animated: true, completion: nil)
        }
    }

    @IBAction func btnApplyPromocodeClick(_ sender: Any) {

    }
    @IBAction func btnSelectWalletClick(_ sender: Any) {

        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
    }
    
    //MARK: Paytabs Methods and settings
    
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
        theme.logoImage = UIImage(named: "Paytab-logo")
        
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
                                            amount: Double(total),
                                            cartDescription: "Invoice Data",
                                            merchantCountryCode: "AE", // ISO alpha 2
                                            showBillingInfo: false,
                                            screenTitle: "Pay with Card",
                                            hideCardScanner: true,
                                            billingDetails: billingDetails)

        configuration1.theme = theme
        configuration1.tokeniseType = .userOptinoal
        configuration1.tokenFormat = .digit16
        
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
        
        let strMsg = success ? "Payment has been done successfully" : "Payment transaction has been failed. Please try again"
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
                        
                        if self.comeFrom == "list"
                        {
                            let storyboard = UIStoryboard.init(name: "Jobs", bundle: nil)
                            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                            AppDelegate.shared.window?.rootViewController = navigationController
                            AppDelegate.shared.window?.makeKeyAndVisible()
                        }
                        else
                        {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
            }
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
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
extension REVIEW_PAYMENT: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
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
            


//            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
//            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
//            print("Status: " + (transactionDetails.paymentResult?.responseStatus ?? ""))
//            print("Token: " + (transactionDetails.token ?? ""))
//            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
//            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
//            print("Card: " + (transactionDetails.cartDescription ?? "" ))
            
            
        } else if let error = error {
            showAlert(message: error.localizedDescription, type: "")
        }
    }
    
    func paymentManager(didCancelPayment error: Error?) {
//        self.navigationController?.popViewController(animated: false)
    }
}
extension REVIEW_PAYMENT : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
