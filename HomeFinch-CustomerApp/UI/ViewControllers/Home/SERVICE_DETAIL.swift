//
//  SERVICE_DETAIL.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/12/20.
//

import UIKit
import SkyFloatingLabelTextField
import Amplitude_iOS

class SERVICE_DETAIL: UIViewController, UITextViewDelegate {

    static func create(jobrequestData:JobIssueList? = nil , issueData: CategoryIssueList? = nil ,item: Jobrequestitem? = nil , strcomeFrom : String = "" ) -> SERVICE_DETAIL {
        let detail = SERVICE_DETAIL.instantiate(fromImShStoryboard: .Home)
        detail.issueData = issueData
        detail.strcomeFrom = strcomeFrom
        detail.jobRequestItem = item
        detail.jobrequesData = jobrequestData

        return detail
    }
    
    //MARK: Outlets

    @IBOutlet weak var txtIssue: SkyFloatingLabelTextField!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var viewIssues: UIView!
    @IBOutlet weak var imgIssue: UIImageView!
    
    @IBOutlet weak var viewImages: UIView!
    
    @IBOutlet weak var collImages: UICollectionView!
    @IBOutlet weak var viewupload: UIView!
    
    @IBOutlet weak var lblcapture: UILabel!
    @IBOutlet weak var lblCapture1: UILabel!
    
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var txtComments: UITextView!
    
    @IBOutlet weak var btnAddmore: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var btnSelectIssue: UIButton!
    @IBOutlet weak var viewSelectIssue: UIView!

    @IBOutlet weak var imgSelectArw: UIImageView!

    
    // MARK: PRIVATE

    private let previewHandler = PreviewImagesCollectionHandler()
    var issueData : CategoryIssueList!
    var jobRequestItem : Jobrequestitem!
    var jobrequesData : JobIssueList!

    var strcomeFrom : String!
    var isAdded : Bool = false
    var categoryId : Int!

    var arrAddedImages = [String:Any]()
    
    var issueId : Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        txtComments.delegate = self
        self.txtIssue.isUserInteractionEnabled = false

        self.setLabel()
        self.ImShSetLayout()

    }
    
    func setLabel()
    {
        
        txtIssue.placeholder = "Issue"
        txtIssue.titleFont = UIFont.roboto(size: 12)!
        txtIssue.font = UIFont.roboto(size: 20, weight: .Bold)

        lblcapture.text = "Capture / Upload"
        lblCapture1.text = "Capture / Upload"
        lblComments.text = " Additional Comments"
        txtComments.placeholder1 = "Let us know about the issue"

        if let data = issueData
        {
            txtIssue.text = data.issueDescription
            if data.issueIdSap == nil
            {
                self.btnChange.isHidden = true
                self.imgSelectArw.isHidden = true
            }
        }

        btnAddmore.setTitle("ADD MORE", for: .normal)
        btnContinue.setTitle("CONTINUE", for: .normal)
        btnSelectIssue.setTitle("Select Issue", for: .normal)


    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnAddmore.titleLabel?.font?.pointSize
        {
            btnAddmore.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnContinue.titleLabel?.font?.pointSize
        {
            btnContinue.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnSelectIssue.titleLabel?.font?.pointSize
        {
            btnSelectIssue.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        if let aSize = btnChange.titleLabel?.font?.pointSize
        {
            btnChange.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        viewSelectIssue.isHidden = (txtIssue.text?.count ?? 0 > 0)

        
        if txtComments.text.count > 0
        {
            self.txtComments.placeholder1 = ""
        }
        else
        {
            txtComments.placeholder1 = "Let us know about the issue"
        }
        
        if txtIssue.text?.count ?? 0 > 0 && previewHandler.images.count > 0
        {
            btnAddmore.isHidden = (strcomeFrom == "jobdetail")
            btnContinue.isHidden = false
        }
        else
        {
            btnAddmore.isHidden = true
            btnContinue.isHidden = true
        }
    }
    override func ImShSetLayout()
    {
       /* let cancelbutton = UIButton(frame: CGRect(x: 0, y: 50, width: 30, height: 30))
        cancelbutton.setImage(UIImage(named: "Cross_gray"), for: .normal)
        cancelbutton.imageView?.contentMode = .scaleAspectFit
       
        cancelbutton.addTarget(self, action: #selector(btnCloseClick(_:)), for: .touchUpInside)
        cancelbutton.sizeToFit()
        let rightBarButton = UIBarButtonItem(customView: cancelbutton)
        self.navigationItem.setRightBarButton(rightBarButton, animated: true) */
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.collImages.setUp(delegate: previewHandler, dataSource: previewHandler, cellNibWithReuseId: "MainCategoriesImageCell")
        
        previewHandler.isRemoveVisible = false

        if strcomeFrom == "jobdetail"
        {
            self.btnAddmore.isHidden = true
            btnContinue.setTitle("UPDATE", for: .normal)
            
            btnChange.isHidden = true
            imgSelectArw.isHidden = true
            
            self.txtIssue.text = jobRequestItem.items
            self.txtComments.text = jobRequestItem.descriptionField
            self.categoryId =  jobRequestItem.categoryId
            previewHandler.images.removeAll()
            viewImages.isHidden = true

            for attachment in jobRequestItem.jobitemsattachments
            {
                var dictimage = [String:Any]()
                dictimage["id"] = attachment.id
                dictimage["path"] = attachment.path
                dictimage["job_request_id"] = attachment.jobRequestId
                
                viewImages.isHidden = false
                previewHandler.strComeFrom = "detail"
                previewHandler.images.append(dictimage)
                self.collImages.reloadData()
            }
        }
        else
        {
            if UserSettings.shared.images.count == 0
            {
                viewImages.isHidden = true
            }
            else
            {
                viewImages.isHidden = false
                previewHandler.strComeFrom = "detail"
                previewHandler.images = UserSettings.shared.images
                self.collImages.reloadData()

            }

        }
        
        /// Handling delete
        previewHandler.deleteTapped = { (indexPath) in
            
            let dict = self.previewHandler.images[indexPath.row]

            if let path =  dict["path"] as? String
            {
                let imageId = String(format: "%d", dict["id"] as? Int ?? 0)
                ServerRequest.shared.removeImageAttachment(imageId: imageId, delegate: self) {
                    
                    self.previewHandler.images.remove(at: indexPath.row)
                    self.collImages.reloadData()
                    
                    if self.previewHandler.images.count == 0
                    {
                        self.viewImages.isHidden = true
                    }
                    else
                    {
                        self.viewImages.isHidden = false
                    }
                    
                } failure: { (errorMsg) in
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                }

            }
            else
            {
                if dict["videoname"] as? String == ""
                {
                    CommonFunction.shared.clearFilesFromDirectory(filename: dict["imagename"] as! String)
                    
                    UserSettings.shared.images.removeAll{$0["imagename"] as? String == dict["imagename"] as? String}

                }
                else
                {
                    CommonFunction.shared.clearFilesFromDirectory(filename: dict["videoname"] as! String)
                    
                    UserSettings.shared.images.removeAll{$0["videoname"] as? String == dict["videoname"] as? String}
                }
                
                self.previewHandler.images.remove(at: indexPath.row)
                self.collImages.reloadData()
                
                if self.previewHandler.images.count == 0
                {
                    self.viewImages.isHidden = true
                }
                else
                {
                    self.viewImages.isHidden = false
                }
            }
        }
        
        previewHandler.didSelectForImagePreview = { (indexPath) in
            
            let storyboard = UIStoryboard.init(name: "Other", bundle: nil)
            let image = storyboard.instantiateViewController(withIdentifier: "ImagePreviewVC") as! ImagePreviewVC
            image.arrrimages = NSMutableArray(array: self.previewHandler.images)
            image.index = indexPath
            image.strcome = self.strcomeFrom
            image.modalPresentationStyle = .overFullScreen
            self.present(image, animated: false, completion: nil)
//            self.navigationController?.pushViewController(image, animated: false)
        }
       
    }
    
    func refreshCollection()
    {
        previewHandler.images.removeAll()
        if UserSettings.shared.images.count == 0
        {
            viewImages.isHidden = true
        }
        else
        {
            viewImages.isHidden = false
        }
        
        
        previewHandler.strComeFrom = "detail"
        if strcomeFrom == "jobdetail"
        {
            for attachment in jobRequestItem.jobitemsattachments
            {
                var dictimage = [String:Any]()
                dictimage["id"] = attachment.id
                dictimage["path"] = attachment.path
                dictimage["job_request_id"] = attachment.jobRequestId
                
                previewHandler.images.append(dictimage)
            }
            previewHandler.images.append(contentsOf: UserSettings.shared.images)
        }
        else
        {
            previewHandler.images = UserSettings.shared.images
        }
        self.collImages.reloadData()
        
        if txtIssue.text?.count ?? 0 > 0 && previewHandler.images.count > 0
        {
            btnAddmore.isHidden = (strcomeFrom == "jobdetail")
            btnContinue.isHidden = false
        }
        else
        {
            btnAddmore.isHidden = true
            btnContinue.isHidden = true
        }
    }
    
//    func refreshCollection()
//    {
//        if strcomeFrom == "jobdetail"
//        {
//            if UserSettings.shared.images.count == 0
//            {
//                viewImages.isHidden = true
//            }
//            else
//            {
//                viewImages.isHidden = false
//            }
//
//            previewHandler.isRemoveVisible = false
//            previewHandler.strComeFrom = "detail"
//            previewHandler.images.append(contentsOf: UserSettings.shared.images)
//            self.collImages.reloadData()
//
//        }
//        else
//        {
//            previewHandler.isRemoveVisible = true
//            viewImages.isHidden = false
//            previewHandler.strComeFrom = "detail"
//            previewHandler.images = UserSettings.shared.images
//            self.collImages.reloadData()
//        }
//
//    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    
    //MARK: Button methods
    
    @IBAction func btnAddMoreClick(_ sender: Any)
    {
        view.endEditing(true)
        
        if txtIssue.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter issue name", duration: .lengthShort).show()
            return

        }
        else if previewHandler.images.count == 0
        {
            SnackBar.make(in: self.view, message: "Please upload atleast one image", duration: .lengthShort).show()
            return
        }
        else
        {
            self.saveIssueToJobList(isFromContinue: false)  // dynamic server store issue
        }
        
    }
    
    @IBAction func btnContinueClick(_ sender: Any)
    {
        view.endEditing(true)
        if txtIssue.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter issue name", duration: .lengthShort).show()
            return

        }
        else
        {
            
            if strcomeFrom == "jobdetail"  // come from job-upcoming job detail
            {
                // update job request
                self.updateJobRequest()
            }
            else
            {
//                self.saveServicesLocally(isContinue: true)

                if issueId == 0
                {
                    self.saveIssueToJobList(isFromContinue: true)
                }
                else
                {
                    if let listnavvc = SERVICE_LIST.create(comeFrom: "list") {
                        listnavvc.modalPresentationStyle = .overCurrentContext
                        self.present(listnavvc, animated: true, completion: nil)
                    }

                }
            }
        }
    }
        
    @IBAction func btnChangeClick(_ sender: Any)
    {
        view.endEditing(true)
        
        let searchvc = SEARCH.create(strComeFrom: "detail",delegate: self)
        self.navigationController?.pushViewController(searchvc, animated: true)

    }
    
    @IBAction func btnUploadPicClick(_ sender: Any) {
        
        view.endEditing(true)
        
        if previewHandler.images.count >= 5
        {
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Only 5 media files can be selected", aOKBtnTitle: "OK") { (index, title) in
            }
            
            return
        }
        
        let selectionVc = self.storyboard?.instantiateViewController(withIdentifier: "CAMERAVIEW") as! CAMERAVIEW
        selectionVc.strCome = "detail"
        selectionVc.ImgSelectCount = previewHandler.images.count
        self.navigationController?.pushViewController(selectionVc, animated: false)
    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        
        view.endEditing(true)
        
        if strcomeFrom == "jobdetail"
        {
            if txtIssue.text?.count == 0 && UserSettings.shared.images.count == 0 && txtComments.text?.count == 0
            {
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "Discard Service Issue", aStrMessage: "Are you sure you want to discard editing?", aCancelBtnTitle: "DISCARD", aOtherBtnTitle: "CONTINUE") { (index, title) in
                    
                    if index == 0 // Discard List
                    {
                        self.removeLocalsavedImages()
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                
            }
            
            return
        }
        
        if txtIssue.text?.count == 0 && UserSettings.shared.images.count == 0 && txtComments.text?.count == 0
        {
            self.navigationController?.popToRootViewController(animated: true)
        }
        else
        {
            AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "Discard Service Issue", aStrMessage: "Are you sure you want to discard service issue?", aCancelBtnTitle: "DISCARD ISSUE", aOtherBtnTitle: "SAVE AS DRAFT") { (index, title) in
                
                if index == 0 // Discard List
                {
                    self.discartIssues()
                }
                else if index == 1 // Add Draft
                {
                    self.saveAsDraftIssue()
                }

            }
            
        }
    }
    
    //MARK: save-remove functions
    
    func saveServicesLocally(isContinue :Bool)
    {
        var arrservice = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service.rawValue)
        
        var dict = [String:Any]()
        
        dict["catId"] = ""
        
        if issueData != nil
        {
            dict["catId"] = issueData.categoryId
        }
        
        dict["issueName"] = self.txtIssue.text
        dict["images"] = UserSettings.shared.images
        dict["comments"] = self.txtComments.text
        dict["isSelected"] = "0"
        dict["isExpand"] = "0"
        dict["issueId"] = issueData.id
        dict["serviceSapId"] = issueData.service.serviceIdSap
        
        if !isContinue {
            UserSettings.shared.images.removeAll()
        }

        if isAdded ==  false
        {
            isAdded = true
            arrservice.append(dict)
            CommonFunction.shared.SaveArrayDatainTextFile(fileName: LocalFileName.service.rawValue, arrData: arrservice)
        }
        
    }
    
    func discartIssues()
    {
        self.removeLocalsavedImages()
        
//        var allService = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service.rawValue)
//
//        allService.removeAll(where: {$0["issueId"] as? Int ==  issueData.id})
//
//        CommonFunction.shared.SaveArrayDatainTextFile(fileName: LocalFileName.service.rawValue , arrData: allService)
//
//        if allService.count == 0
//        {
//            UserSettings.shared.removeAllLocalStoredServices()
//        }
        
        
        if issueId != 0
        {
            let itemIssueId = String(format: "%d", self.issueId)
            ServerRequest.shared.removeJobIssue(JobItemId: itemIssueId, delegate: self) { response in
                self.issueId = 0
                self.navigationController?.popToRootViewController(animated: true)
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }

        }
        else
        {
            self.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    func removeLocalsavedImages()
    {
        for dict in UserSettings.shared.images
        {
            if dict["videoname"] as? String != ""
            {
                CommonFunction.shared.clearFilesFromDirectory(filename: (dict["videoname"] as? String)!)
            }
            else
            {
                CommonFunction.shared.clearFilesFromDirectory(filename: (dict["imagename"] as? String)!)
            }
        }
        UserSettings.shared.images.removeAll()

    }
    
    //MARK: Webservice Calling
    func saveAsDraftIssue()
    {
        view.endEditing(true)
        if txtIssue.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter issue name", duration: .lengthShort).show()
            return

        }

        var propertyId : Int = 0
        let arrProprty = UserSettings.shared.arrPropertyList.filter{$0.isDefault == 1}
        if arrProprty.count > 0
        {
            propertyId = arrProprty[0].id
        }
        
        let userData = UserSettings.shared.getUserCredential()
        
        var arrCurrentIssue = [[String:Any]]()
        var dict = [String:Any]()
        
        dict["catId"] = ""
        
        if self.issueData != nil
        {
            dict["catId"] = self.issueData.categoryId
        }
        
        dict["issueName"] = self.txtIssue.text
        dict["images"] = UserSettings.shared.images
        dict["comments"] = self.txtComments.text
        dict["isSelected"] = "0"
        dict["isExpand"] = "0"
        dict["issueId"] = self.issueData.id
        
        arrCurrentIssue.append(dict)

        let dateFormat = DateFormatter()
        let todate = Date()
        dateFormat.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let StrToday = dateFormat.string(from: todate)
        
        let dictServiceReq = AddService.init()
        dictServiceReq.customerId = Int(UserSettings.shared.getCustomerId())
        dictServiceReq.propertyId = propertyId
        dictServiceReq.customerName = String(format: "%@ %@", userData["firstname"] as? String ?? "" ,userData["lastname"] as? String ?? "")
        dictServiceReq.customerMobile = userData["mobile"] as? String
        dictServiceReq.distributionChannel = ""
        dictServiceReq.additinalComment = ""
        dictServiceReq.startDate = StrToday
        dictServiceReq.status = 1 // Requested
        dictServiceReq.subStatus = 1 // Draft

        dictServiceReq.issueItem = [IssueItem]()
        
        
        for i in 0..<arrCurrentIssue.count
        {
            let dict = arrCurrentIssue[i]
            let issueList = IssueItem.init()
            issueList.categoryId =  dict["catId"] as? Int
            issueList.issueId = dict["issueId"] as? Int
            issueList.items = dict["issueName"] as? String
            issueList.descriptionField = dict["comments"] as? String
            issueList.images = [String]()
            
            let images = dict["images"] as? [[String:Any]] ?? []
            for dict in images
            {
                if dict["videoname"] as? String != ""
                {
                    issueList.images.append(dict["videoname"] as! String)
                }
                else
                {
                    issueList.images.append(dict["imagename"] as! String)
                }
                
            }
            
            dictServiceReq.issueItem.append(issueList)

        }
        
        print(dictServiceReq)
        ServerRequest.shared.CreateJobRequestOld(dictPara: dictServiceReq, delegate: self) { response in
            
            
            //------------------- log event ------------------
            let dictPara = ["Job ID":response.id,
                            "Issue Count":"1",
                            "Issue Category":self.issueData.category.name,
                            "Issue Title":self.txtIssue.text,
                            "Customer ID": UserSettings.shared.getCustomerId(),
                            "App User ID": UserSettings.shared.getCustomerId()] as [String : Any]
            
            Amplitude.instance().logEvent("Job Request - Draft", withEventProperties: dictPara)
            //------------------------------------------------
            
            UserSettings.shared.images.removeAll()
            CommonFunction.shared.clearFilesFromDirectory(filename: LocalFileName.service.rawValue)
            self.navigationController?.popToRootViewController(animated: true)
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
    }
    
    func updateJobRequest()  // Edit issue from job_upcoming_detail
    {
        var dictIssueDetail = [String:Any]()
        
        dictIssueDetail["job_request_id"] = String(format: "%d", jobrequesData.id)
        dictIssueDetail["job_request_item_id"] = String(format: "%d", jobRequestItem.id )
        dictIssueDetail["issue_id"] = String(format: "%d", jobRequestItem.issueId )
        dictIssueDetail["description"] = self.txtComments.text
        dictIssueDetail["items"] = self.txtIssue.text
        
        if self.issueData == nil
        {
            dictIssueDetail["category_id"] = String(format: "%d", self.categoryId )
        }
        else
        {
            dictIssueDetail["category_id"] = String(format: "%d", issueData.categoryId )

        }

        var images = [String]()
        
        for dict in UserSettings.shared.images
        {
            if dict["videoname"] as? String != ""
            {
                images.append(dict["videoname"] as! String)
            }
            else
            {
                images.append(dict["imagename"] as! String)
            }
            
        }
        
        ServerRequest.shared.updateIssueDetailsJobRequest(dictPara: dictIssueDetail, images: images, delegate: self) {
            
            self.removeLocalsavedImages()
            self.navigationController?.popViewController(animated: true)

            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
    }
    
    func saveIssueToJobList(isFromContinue : Bool)  // add issue data to the server
    {
        let userData = UserSettings.shared.getUserCredential()

        var arrCurrentIssue = [[String:Any]]()
        var dict = [String:Any]()

        dict["catId"] = ""

        if self.issueData != nil
        {
            dict["catId"] = self.issueData.categoryId
        }

        dict["issueName"] = self.txtIssue.text
        dict["images"] = UserSettings.shared.images
        dict["comments"] = self.txtComments.text
        dict["isSelected"] = "0"
        dict["isExpand"] = "0"
        dict["issueId"] = self.issueData.id

        arrCurrentIssue.append(dict)

        let dictServiceReq = AddService.init()
        dictServiceReq.customerId = Int(UserSettings.shared.getCustomerId())
        dictServiceReq.customerName = String(format: "%@ %@", userData["firstname"] as? String ?? "" ,userData["lastname"] as? String ?? "")
        dictServiceReq.customerMobile = userData["mobile"] as? String
        dictServiceReq.createdBy = UserSettings.shared.getCustomerId()
        dictServiceReq.issueItem = [IssueItem]()

        for i in 0..<arrCurrentIssue.count
        {
            let dict = arrCurrentIssue[i]
            let issueList = IssueItem.init()
            issueList.categoryId =  dict["catId"] as? Int
            issueList.issueId = dict["issueId"] as? Int
            issueList.items = dict["issueName"] as? String
            issueList.descriptionField = dict["comments"] as? String
            issueList.images = [String]()

            let images = dict["images"] as? [[String:Any]] ?? []
            for dict in images
            {
                if dict["videoname"] as? String != ""
                {
                    issueList.images.append(dict["videoname"] as! String)
                }
                else
                {
                    issueList.images.append(dict["imagename"] as! String)
                }

            }

            dictServiceReq.issueItem.append(issueList)

        }

        ServerRequest.shared.CreateJobList(isCloneItem: "0", customerId: UserSettings.shared.getCustomerId(), dictPara: dictServiceReq, delegate: self) { response in

            //------------------- log event ------------------
            let dictPara = ["Issue Count":"1",
                            "Issue Category":self.issueData.category.name,
                            "Issue Title":self.txtIssue.text,
                            "Customer ID": UserSettings.shared.getCustomerId(),
                            "App User ID": UserSettings.shared.getCustomerId()] as [String : Any]
            Amplitude.instance().logEvent("Job List", withEventProperties: dictPara)
            //------------------------------------------------

            UserSettings.shared.images.removeAll()
            CommonFunction.shared.clearFilesFromDirectory(filename: LocalFileName.service.rawValue)
            
            if isFromContinue
            {
                self.viewImages.isHidden = true
                self.previewHandler.images.removeAll()
                self.collImages.reloadData()
                self.issueData = nil
                self.txtIssue.text = ""
                self.txtComments.text = ""
                self.txtComments.placeholder1 = "Let us know about the issue"
                
                self.issueId = response.id
                if let listnavvc = SERVICE_LIST.create(comeFrom: "list") {
                    listnavvc.modalPresentationStyle = .overCurrentContext
                    self.present(listnavvc, animated: true, completion: nil)
                }
            }
            else
            {
                self.viewImages.isHidden = true
                self.previewHandler.images.removeAll()
                self.collImages.reloadData()
                self.issueData = nil
                self.txtIssue.text = ""
                self.txtComments.text = ""
                self.txtComments.placeholder1 = "Let us know about the issue"
            }


        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }
        
    }
   
}
extension UITextView :UITextViewDelegate
{

    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }

    /// The UITextView placeholder text
    public var placeholder1: String? {
        get {
            var placeholderText: String?

            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }

            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }

    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = textView.text.count > 0
        }
        
        return true
    }

    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }

    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()

        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()

        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100

        placeholderLabel.isHidden = self.text.count > 0

        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}
extension SERVICE_DETAIL : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
extension SERVICE_DETAIL : selectIssueDelegate
{
    func issueSelected(dict: CategoryIssueList) {
        self.issueData = dict
        self.txtIssue.text = dict.issueDescription
    }
    
    
}
