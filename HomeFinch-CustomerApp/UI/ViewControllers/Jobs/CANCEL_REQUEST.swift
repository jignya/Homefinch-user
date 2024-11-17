//
//  CANCEL_REQUEST.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 28/12/20.
//

import UIKit

class CANCEL_REQUEST: UIViewController {
    
    static func create(jobrequestData:JobIssueList? = nil ,item: Jobrequestitem? = nil,comeFrom:String = "", delegate : cancelRequestDelegate? = nil) -> CANCEL_REQUEST {
        let cancel = CANCEL_REQUEST.instantiate(fromImShStoryboard: .Jobs)
        cancel.strcomeFrom = comeFrom
        cancel.jobRequestItem = item
        cancel.jobrequesData = jobrequestData
        return cancel
    }
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblReason: UILabel!
    
    @IBOutlet weak var lblReasonTitle: UILabel!
    @IBOutlet weak var txtReason: UITextField!

    
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var txtComments: UITextView!
    
    @IBOutlet weak var viewConfirm: UIView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnselectReason: UIButton!
    
    @IBOutlet weak var conTopviewConstant: NSLayoutConstraint!


    var jobRequestItem : Jobrequestitem!
    var jobrequesData : JobIssueList!
    var strcomeFrom : String!
    weak var delegate: cancelRequestDelegate? = nil
    
    var abandoneId : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.setLabel()
        
        var bottomPadding : CGFloat = 0
        var topPadding : CGFloat = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }

        self.conTopviewConstant.constant = self.view.frame.size.height - (bottomPadding + topPadding) - 416

        
    }
    
   
    
    func setLabel()
    {
        lblReasonTitle.text = "Reason of Cancelling Request"
        lblReason.text = "Reason to Cancel"
        txtReason.placeholder = "Select reason to cancel"
        lblComments.text = " Comments"
        txtComments.text = ""
        txtComments.placeholder1 = "Let us know more"
        btnConfirm.setTitle("CONFIRM", for: .normal)
    }
    
    
    //MARK: Button methods
    
    @IBAction func btncloseClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnConfirmClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        // update job issue status , status - issue Abondoned
//        let dictPara  = ["status":"8"] as [String : String]
//        ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: self.jobRequestItem.id, dictPara: dictPara)
        //-------------------------------

        
        if txtReason.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select reason", duration: .lengthShort).show()
            return

        }
        else if txtComments.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter comments", duration: .lengthShort).show()
            return

        }
        
        if strcomeFrom == "quotation"
        {
            self.delegate?.selectReason(reason: self.txtReason.text!, remark: self.txtComments.text!)
            self.dismiss(animated: true, completion: nil)
        }
        else if strcomeFrom == "detail"
        {
            
            let arr = UserSettings.shared.initialData.reasonForAbandonWithType.filter({$0.id.toString() == abandoneId})
            if arr.count > 0
            {
                let dict1 = arr[0]
                let abandoneTypeId  = dict1.id.toString()
                
                // update job issue status , status - issue Abandoned
                let dictPara2  = ["status":"8","reason_for_abandon_type_id":abandoneTypeId, "reason_for_abandon_id" :abandoneId] as! [String : String]
                ServerRequest.shared.UpdateJobIssueStatusApiIntegration(jobid: self.jobRequestItem.id, dictPara: dictPara2, delegate: nil) {
                    
                    if dict1.name == "1"
                    {
//                        self.CreateFollowUpNewJobRequest()
                    }
                    else if dict1.name == "2"
                    {
//                        self.saveIssueToJobList()
                    }
                    
                    
                } failure: { (errorMsg) in
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                }
                
                
            }
        }
        else
        {
            self.dismiss(animated: true) {
                
                let controller = UIApplication.topViewController()
                if controller is FIND_TECHNICIAN
                {
                    if UserDefaults.standard.bool(forKey: "arabic")
                    {
                        UIView.appearance().semanticContentAttribute = .forceRightToLeft
                    }
                    else
                    {
                        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                    }
                    
                    let storyboard1 = UIStoryboard(name: "Home", bundle: nil)
                    let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                    AppDelegate.shared.window?.rootViewController = navigationController
                    AppDelegate.shared.window?.makeKeyAndVisible()
                    
                }
            }
        }
        
        

    }
    
    @IBAction func btnselectReasonClick(_ sender: Any) {
        
        self.view.endEditing(true)

        let alertvc = IMSH_CUSTOM_SELECTION.createwithTypes(title: "Select", data: UserSettings.shared.initialData.reasonForAbandon, type: "issueabandoned"  , delegate: self)
        alertvc.present(from: self)

    }
    
    //MARK: WebServices
    
//    func saveIssueToJobList()  // add issue data to the server
//    {
//        let dictServiceReq = AddService.init()
//        dictServiceReq.customerId = self.jobrequesData.customerId
//        dictServiceReq.customerName = self.jobrequesData.customerName
//        dictServiceReq.customerMobile = self.jobrequesData.customerMobile
//        dictServiceReq.createdBy = UserSettings.shared.getCustomerId()
//        dictServiceReq.issueId = self.jobRequestItem.id
//        dictServiceReq.jobReqId = self.jobrequesData.id
//
//        print(dictServiceReq.toJobListDictionary())
//
//        ServerRequest.shared.CreateJobList(isCloneItem: "1", customerId: self.jobrequesData.customerId.toString(), dictPara: dictServiceReq, delegate: self) {_ in
//
//            self.dismiss(animated: true) {
//            }
//
//        } failure: { (errorMsg) in
//            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
//        }
//
//    }
//
//    func CreateFollowUpNewJobRequest()
//    {
//        let param = ["issue[0]" : String(format: "%d", self.jobRequestItem.id),"priority":"high","abandoned" : "1"]
//
//        ServerRequest.shared.createFollowupNewJobRequset(dictPara: param, jobRequestId: self.jobrequesData.id, delegate: self) { response in
//
//            self.dismiss(animated: true) {
//            }
//
//        } failure: { (errorMsg) in
//            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
//            }
//        }
//    }

}
extension CANCEL_REQUEST : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}

extension CANCEL_REQUEST: ImShCustomSelectionDelegate {
    func CountrySelected(at index: Int, dict: Country, type: String) {
        
    }
    
    
    func itemSelected(at index: Int, dict: [String : Any], title: CustomerTitle, dictType: CustomerType, type: String)
    {
        if type == "issueabandoned"
        {
            abandoneId = String(format: "%d", dictType.id)
            self.txtReason.text = dictType.name
        }
       
    }
    
}
protocol cancelRequestDelegate: AnyObject {
    func selectReason(reason:String, remark : String)
}

