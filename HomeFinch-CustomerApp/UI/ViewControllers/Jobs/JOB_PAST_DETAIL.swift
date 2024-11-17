//
//  JOB_PAST_DETAIL.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 30/12/20.
//

import UIKit
import PDFKit

class JOB_PAST_DETAIL: UIViewController {
    
    static func create(data:JobIssueList? = nil ,comeFrom:String = "",iscancelService:Bool,jobId:Int? = nil) -> JOB_PAST_DETAIL {
        let detail = JOB_PAST_DETAIL.instantiate(fromImShStoryboard: .Jobs)
        detail.jobRequestData = data
        detail.isCancelledReq = iscancelService
        detail.strComeFrom = comeFrom
        detail.jobId = jobId ?? 0
        return detail
    }
    
    //    Header outlet
    @IBOutlet weak var lblserviceNum: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblFixNow: UILabel!
    @IBOutlet weak var viewFixNow: UIView!
    @IBOutlet weak var lblserviceStatus: UILabel!


    // Technician Detail

    @IBOutlet weak var viewTechnicianDetail: UIView!

    @IBOutlet weak var lblTechnicianDetail: UILabel!
    @IBOutlet weak var lblTechnicianName: UILabel!
    @IBOutlet weak var imgTechnician: UIImageView!

    @IBOutlet weak var viewRateService: UIView!
    @IBOutlet weak var lblRateService: UILabel!
//    @IBOutlet weak var viewApplyRating: FloatRatingView!
    @IBOutlet weak var btnRateService: UIButton!
    
    @IBOutlet weak var viewApplyRating: SmileyRateView!
    @IBOutlet weak var conimgArwRatewidth: NSLayoutConstraint!


    @IBOutlet weak var btnCall: UIView!
    @IBOutlet weak var btnMsg: UIButton!
    
    // service list

    @IBOutlet weak var lblServiceList: UILabel!
    @IBOutlet weak var viewService: UIView!
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var conTblServiceHeight: NSLayoutConstraint!

    // Customer Info Outlet
    
    @IBOutlet weak var lblProperty: UILabel!
    @IBOutlet weak var lblProertyAddress: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblCustomerContact: UILabel!

    @IBOutlet weak var viewCustomerInfo: UIView!
    
    @IBOutlet weak var viewSignature: UIView!
    @IBOutlet weak var conviewSignatureHeight: NSLayoutConstraint!

    @IBOutlet weak var viewPropertyInfo: UIView!
    @IBOutlet weak var viewContactInfo: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewPaymentInfo: UIView!

    @IBOutlet weak var viewReport: UIView!

    @IBOutlet weak var btnViewSignature: UIButton!
    @IBOutlet weak var lblRequestDetail: UILabel!
    @IBOutlet weak var lblContactPerson: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDateValue: UILabel!

    @IBOutlet weak var lblPayMode: UILabel!
    @IBOutlet weak var lblPayMethod: UILabel!
    
    @IBOutlet weak var lblCard: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblWallet: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!

    @IBOutlet weak var lblInitials: UILabel!


    private let servicelisthandler = PastServiceListTableHandler()
    var jobRequestData : JobIssueList!

    var isCancelledReq : Bool = false
    var strComeFrom : String = ""
    var jobId : Int!

    //MARK: View Methods

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

//        btnMsg.isHidden = false
        self.ImShSetLayout()
        self.setLabel()
        
        if isCancelledReq
        {
            self.viewPaymentInfo.isHidden = true
//            self.viewRateService.isHidden = true
            self.viewSignature.isHidden = true
            self.conviewSignatureHeight.constant = 0
            self.viewReport.isHidden = true
        }
        
        
        self.lblserviceStatus.textColor = UserSettings.shared.themeColor2()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.fetchJobRequestDetail()
    }
    
    override func viewWillLayoutSubviews() {
        
        viewService.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        
        if let aSize = btnViewSignature.titleLabel?.font?.pointSize
        {
            btnViewSignature.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
    }
    
    override func ImShSetLayout()
    {
        servicelisthandler.iscancelled = isCancelledReq
        servicelisthandler.strComeFrom = "jobdetail"
        self.tblServices.rowHeight = UITableView.automaticDimension
        self.tblServices.estimatedRowHeight = 70

        self.tblServices.setUpTable(delegate: servicelisthandler, dataSource: servicelisthandler, cellNibWithReuseId: ServiceListCell.className)

        //Handling actions - Follow up request
        servicelisthandler.EditIssueClick = {(indexpath) in
            
            let jobReqItem = self.servicelisthandler.arrServices[indexpath.row]
            self.CreateFollowUpRequest(jobItemId: jobReqItem.id, jobRequestId: self.jobRequestData.id)
        }
    
        
        servicelisthandler.didSelect = {(indexpath) in
            self.tblServices.beginUpdates()
            self.tblServices.reloadData()
            self.tblServices.endUpdates()

//            self.conTblServiceHeight.constant = self.tblServices.contentSize.height
            self.tblServices.updateConstraintsIfNeeded()
            self.tblServices.layoutIfNeeded()
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height

        }

    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblserviceStatus.text = ""
        lblServiceList.text = ""
        lblProperty.text = "Property"
        btnViewSignature.setTitle("VIEW SIGNATURE", for: .normal)
        lblTechnicianDetail.text = "Technician Details"
        self.lblRateService.text = ""
    }

    
    //MARK: Web service calling
    
    func CreateFollowUpRequest(jobItemId: Int, jobRequestId: Int)
    {
        let param = ["issue[0]" : String(format: "%d", jobItemId)]
        ServerRequest.shared.createFollowupJobRequset(dictPara: param, jobRequestId: jobRequestId, delegate: self) { response in
            
            self.navigationController?.popViewController(animated: true)
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                
            }
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
            
            self.jobRequestData = response
            self.setData(response: response)
            
        } failure: { (errMsg) in
            
        }

    }
   
    func setData(response:JobIssueList)
    {
        self.lblServiceList.text = "Issue(s)" // String(format: "Job %d", response.id)
        self.lblserviceNum.text = String(format: "Job %d", response.id)
        
        self.lblDateValue.text = ""
        self.viewFixNow.isHidden = true

        if response.distributionChannel == "fixnow"
        {
            self.viewFixNow.isHidden = false
        }
        
        if let strStartDate = response.startDate
        {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let serviceDate = dateformatter.date(from: strStartDate)
            {
                dateformatter.dateFormat = "E, d MMM yyyy"
                self.lblDateValue.text = String(format: "%@ | %@",  dateformatter.string(from: serviceDate), UserSettings.shared.string24To12String(time: response.jobrequestadditionalinfo.slotTime))
            }
        }

        self.lblCustomerName.text = response.customerName
        self.lblCustomerContact.text = response.customerMobile
        
        self.lblProertyAddress.text = ""
        if let propertyData = response.propertyData
        {
            self.attributedAddress(strTitle: String(format: "%@\n", propertyData.propertyName), strAddress: propertyData.fullAddress)
        }
        
        
        let jobStatus = response.subStatus
//        if jobStatus == 19
//        {
//            self.servicelisthandler.isclosed = true
//        }
        
        let arrStatus = UserSettings.shared.initialData.jobRequetSubStatus.filter { $0.id == jobStatus}
        if arrStatus.count > 0
        {
            self.lblserviceStatus.text = arrStatus[0].name
        }

        self.servicelisthandler.arrServices = response.jobrequestitems
        
        let arrAbandon = self.servicelisthandler.arrServices.filter{$0.status == 8}
        if arrAbandon.count == self.servicelisthandler.arrServices.count
        {
            self.viewReport.isHidden = true
        }
        
        self.tblServices.reloadData()
//        self.conTblServiceHeight.constant = self.tblServices.contentSize.height
        self.tblServices.updateConstraintsIfNeeded()
        self.tblServices.layoutIfNeeded()
        self.conTblServiceHeight.constant = self.tblServices.contentSize.height
        
        if response.employeeData == nil
        {
            self.viewTechnicianDetail.isHidden = true
        }
        else
        {
            self.viewTechnicianDetail.isHidden = false
            self.lblTechnicianName.text = response.employeeData.fullName
            
            let initials = self.lblTechnicianName.text?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            self.lblInitials.text = initials?.uppercased()
            self.imgTechnician.isHidden = true
            self.imgTechnician.backgroundColor = UIColor.clear

            if let imageTec = response.employeeData.avatar
            {
                self.imgTechnician.setImage(url: imageTec.getURL, placeholder: nil)
                self.imgTechnician.isHidden = false
                self.imgTechnician.contentMode = .scaleAspectFill
            }

        }

        self.viewApplyRating.dataPassed = "yes"
        self.viewApplyRating.commonInit()
        self.viewApplyRating.currentCount = 0

        if response.jobrequestadditionalinfo.overallRatingByCustomer == ""
        {
            self.lblRateService.text = "RATE OUR SERVICE"
            self.btnRateService.isEnabled = true
            self.conimgArwRatewidth.constant = 10
        }
        else
        {
            self.lblRateService.text = "You have rated"
            self.viewApplyRating.currentCount = Int(response.jobrequestadditionalinfo.overallRatingByCustomer) ?? 0
            self.btnRateService.isEnabled = false
            
        }
        
        let arrPayInfo = response.paymenttransaction.filter{$0.statusCode == "A" && ($0.paymentMode == "2" || $0.paymentMode == "1")}
        let arrPayInfo1 = response.paymenttransaction.filter{$0.paymentMode == "3"}

        if arrPayInfo.count > 0
        {
            self.viewPaymentInfo.isHidden = false
            self.lblPayMode.text = "(Paid using card)"

            let payData = arrPayInfo[0]
            let paymentStr = payData.paymentTransactionDetails ?? ""
            if let dictPayment = convertToDictionary(text: paymentStr)
            {
                print(dictPayment)
                if let dictPaymentDetails = dictPayment["paymentInfo"] as? [String:Any]
                {
                    self.lblCard.text = dictPaymentDetails["paymentDescription"] as? String
                    self.lblAmount.text = String(format: "%@ %@",dictPayment["cartCurrency"] as? String ?? "", dictPayment["cartAmount"] as? String ?? "")
                    
                    self.lblWallet.text = "Wallet Balance"
                    self.lblWalletAmount.text = "N.A."
                }
                else if let dictPaymentDetails = dictPayment["payment_info"] as? [String:Any]
                {
                    self.lblCard.text = dictPaymentDetails["payment_description"] as? String
                    self.lblAmount.text = String(format: "%@ %@",dictPayment["cart_currency"] as? String ?? "", dictPayment["cart_amount"] as? String ?? "")
                    
                    self.lblWallet.text = "Wallet Balance"
                    self.lblWalletAmount.text = "N.A."
                }
                
            }
        }
        else if arrPayInfo1.count > 0
        {
            self.lblPayMode.text = "(Using cash)"
            self.viewPaymentInfo.isHidden = false
            
            let payData = arrPayInfo1[0]
            let paymentStr = payData.paymentRequestDetails ?? ""
            if let dictPayment = convertToDictionary(text: paymentStr)
            {
                print(dictPayment)
//                if let dictPaymentDetails = dictPayment["paymentInfo"] as? [String:Any]
//                {
                    self.lblCard.text = "Cash"
                    self.lblAmount.text = String(format: "%@ %.2f",dictPayment["cart_currency"] as? String ?? "", dictPayment["cart_amount"] as? Double ?? "0.00")
                    
                    self.lblWallet.text = "Wallet Balance"
                    self.lblWalletAmount.text = "N.A."
//                }
            }
        }
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

    
    //MARK: Button methods
    @IBAction func btnCallnClick(_ sender: Any) {
    }
    
    @IBAction func btnMsgClick(_ sender: Any) {
        let chat = CHATVIEW.create(title: "", jobData: self.jobRequestData)
        self.navigationController?.pushViewController(chat, animated: true)

    }
    
    @IBAction func btnViewSignatureClick(_ sender: Any) {
        
        let signature = SIGNATURE_VIEW.create(image: self.jobRequestData.jobrequestadditionalinfo.signature)
        self.present(signature, animated: true, completion: nil)

    }
    
    @IBAction func btnRateServiceClick(_ sender: Any) {
        let review = REVIEW_SERVICE.create(data: jobRequestData, isCancelled: isCancelledReq)
        self.present(review, animated: true, completion: nil)

    }
    
    @IBAction func btnDownLoadPdfClick(_ sender: Any) {
//        guard let url = URL(string: "http://www.orimi.com/pdf-test.pdf")else {return}
//         let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//         let downloadTask = urlSession.downloadTask(with: url)
//         downloadTask.resume()
//        if let jobId  = self.jobRequestData.id
//        {
//            let urlString = String(format: "https://staging.homefinch.com/job/%d/report", jobId)
//            let url = URL(string: urlString)
//
//            let pdfView = PDFViewController()
//            pdfView.pdfURL = url
//            present(pdfView, animated: true, completion: nil)
//        }
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
extension JOB_PAST_DETAIL : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
extension JOB_PAST_DETAIL : URLSessionDownloadDelegate {
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            print("downloadLocation:", location)
            // create destination URL with the original pdf name
            guard let url = downloadTask.originalRequest?.url else { return }
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
            // delete original copy
            try? FileManager.default.removeItem(at: destinationURL)
            // copy from temp to Document
            do {
                try FileManager.default.copyItem(at: location, to: destinationURL)
                let pdfURL = destinationURL
                
                DispatchQueue.main.async
                {
                    if FileManager.default.fileExists(atPath: documentsPath.absoluteString){
                        let documento = NSData(contentsOfFile: documentsPath.absoluteString)
                        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
                        activityViewController.popoverPresentationController?.sourceView=self.view
                        self.present(activityViewController, animated: true, completion: nil)
                    }
                    else {
                        print("document was not found")
                    }
                    
//                    let pdfViewController = PDFViewController()
//                    pdfViewController.pdfURL = pdfURL
//                    self.present(pdfViewController, animated: false, completion: nil)
                }
                

            } catch let error {
                print("Copy Error: \(error.localizedDescription)")
            }
        }
    }
