//
//  JOBS.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/11/20.
//

import UIKit
import TBEmptyDataSet

class JOBS: UIViewController,ServerRequestDelegate {
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnPast: UIButton!

    @IBOutlet weak var viewEmpty: UIView!

    var strType : String = "upcoming"
    
    // MARK: PRIVATE

    private let joblisthandler = JobListTableHandler()
    private var isLoading: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        

        CommonFunction.shared.addTabBar(self, tab: 1)
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.viewEmpty.isHidden = false
        self.tblList.isHidden = true

        self.ImShSetLayout()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.roboto(size: 18, weight: .Bold)]

    }
    
    func refreshApi()  {
        
        btnUpcoming.isSelected = (strType == "upcoming")
        btnPast.isSelected = !(strType == "upcoming")
        joblisthandler.isupcoming = (strType == "upcoming")
        self.GetJobRequestList(type: self.strType)

    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnUpcoming.titleLabel?.font?.pointSize
        {
            btnUpcoming.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnPast.titleLabel?.font?.pointSize
        {
            btnPast.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshApi()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    
    override func ImShSetLayout()
    {
        self.tblList.estimatedRowHeight = 200
        self.tblList.rowHeight = UITableView.automaticDimension
        
//        self.tblList.emptyDataSetDelegate = self
//        self.tblList.emptyDataSetDataSource = self
        
        
        self.navigationItem.setNotificationBtn(target: self, action: #selector(btnNotificationTapped(_:)), tag: 0, animated: true)
        self.navigationItem.setwalletBtn(target: self, action: #selector(btnWalletTapped(_:)), amount:  UserSettings.shared.getwalletbalance(), animated: true)

        self.navigationItem.leftBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        
        self.navigationController?.navigationBar.hideBottomHairline()
                
        self.tblList.setUpTable(delegate: joblisthandler, dataSource: joblisthandler, cellNibWithReuseId: JobCell.className)
        
        /// Handling actions
        joblisthandler.didSelect =  { (indexpath) in
            
            let jobData = self.joblisthandler.arrList[indexpath.row]
            
            if (jobData.status == 5 && jobData.subStatus == 15) || (jobData.status == 7 && jobData.subStatus == 19) // Payment success - completed , closed
            {
                let arrPayInfo = jobData.jobrequestitems.filter{$0.status == 8}
                
                if arrPayInfo.count == jobData.jobrequestitems.count
                {
                    let detail = JOB_PAST_DETAIL.create(data: jobData,iscancelService: true)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
                else
                {
                    let detail = JOB_PAST_DETAIL.create(data: jobData,iscancelService: false)
                    self.navigationController?.pushViewController(detail, animated: true)
                }

            }
            else if (jobData.status == 5 && jobData.subStatus == 16) || (jobData.status == 6 && jobData.subStatus == 17) || (jobData.status == 6 && jobData.subStatus == 18) || (jobData.status == 7 && jobData.subStatus == 20)  // cancelled services
            {
                if (jobData.status == 5 && jobData.subStatus == 16)// Payment failed
                {
                    let review = REVIEW_PAYMENT.create(jobData: nil,jobId: jobData.id,comeFrom: "list")
                    self.navigationController?.pushViewController(review, animated: true)
                }
                else if jobData.status == 6  // cancelled JR having service charges
                {
                    let arrPayInfo = jobData.paymenttransaction.filter{$0.statusCode == "A"}
                    
                    if jobData.jobotherservices.count > 0 && arrPayInfo.count == 0 // cancellation charge flow implementation
                    {
                        let review = REVIEW_PAYMENT.create(jobData: nil,jobId: jobData.id,comeFrom: "list")
                        self.navigationController?.pushViewController(review, animated: true)
                    }
                    else
                    {
                        let detail = JOB_PAST_DETAIL.create(data: jobData,iscancelService: true)
                        self.navigationController?.pushViewController(detail, animated: true)

                    }

                }
                else
                {
                    let detail = JOB_PAST_DETAIL.create(data: jobData,iscancelService: true)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
            else
            {
                let arrPayInfo = jobData.paymenttransaction.filter{$0.statusCode != "A" && $0.paymentMode == "3"}
                if jobData.subStatus == 14 && arrPayInfo.count > 0  // cash payment mode
                {
                    let detail = JOB_PAST_DETAIL.create(data: jobData,iscancelService: false)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
                else
                {
                    let detail = JOB_UPCOMING_DETAIL.create(data: jobData)
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        
        joblisthandler.RateServiceTapped =  { (indexpath) in
            
            let jobData = self.joblisthandler.arrList[indexpath.row]
            
            if (jobData.status == 6 && jobData.subStatus == 17) || (jobData.status == 6 && jobData.subStatus == 18) || (jobData.status == 7 && jobData.subStatus == 20)  // cancelled services
            {
                let review = REVIEW_SERVICE.create(data: jobData, isCancelled: true)
                self.present(review, animated: true, completion: nil)
            }
            else
            {
                let arrAbandonIssue = jobData.jobrequestitems.filter{$0.status == 8}
                
                if arrAbandonIssue.count == jobData.jobrequestitems.count
                {
                    let review = REVIEW_SERVICE.create(data: jobData, isCancelled: true)
                    self.present(review, animated: true, completion: nil)
                }
                else
                {
                    let review = REVIEW_SERVICE.create(data: jobData, isCancelled: false)
                    self.present(review, animated: true, completion: nil)
                }
            }
        }
        
        joblisthandler.CancelServiceTapped = { (indexpath) in
            
            AJAlertController.initialization1().showAlert(isBottomShow: true, aStrTitle: "Cancel Request", aStrMessage: "Are you sure you want to cancel your job request?", aCancelBtnTitle: "No", aOtherBtnTitle: "Yes") { (index, title) in
                
                if title == "Yes"
                {
                    self.isLoading(loading: true)
                    let jobData = self.joblisthandler.arrList[indexpath.row]
                    
                    ServerRequest.shared.cancelJobRequest(jobRequestId: jobData.id, status: jobData.status, delegate: nil) {
                        
                        let jobId = String(format: "%d", jobData.id)
                        
                        let serverUrl = ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["record-job-with-slot",jobId,"cancel"]).absoluteString
                        
                        // update job status - status - canceled , sub_status - customer
                        let dictPara2  = ["status":"6","sub_status":"18","request_info":[:],"request_url":serverUrl] as [String : Any]
                        ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: jobData.id, dictPara: dictPara2, delegate: nil) {
                            
                            self.GetJobRequestList(type: self.strType)
                            
                        } failure: { (errorMsg) in
                            
                            self.isLoading(loading: false)

                            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                        }
                        
                        //-------------------------------
                        
                    } failure: { (errorMsg) in
                        
                        self.isLoading(loading: false)

                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
                    }
                }
            }
        }
    }
    
    
    //MARK: Button Methods
    
    @IBAction func btnUpcomingClick(_ sender: Any) {
        
        let btn = sender as! UIButton
        if !btn.isSelected
        {
            btnUpcoming.isSelected = true
            btnPast.isSelected = false

            joblisthandler.isupcoming = true
            
            self.joblisthandler.arrList.removeAll()
            self.tblList.reloadData()
            
            self.strType = "upcoming"
            self.GetJobRequestList(type: self.strType)
        }
        
    }
    
    @IBAction func btnPastClick(_ sender: Any) {
    
        let btn = sender as! UIButton
        if !btn.isSelected
        {
            btnUpcoming.isSelected = false
            btnPast.isSelected = true

            joblisthandler.isupcoming = false
            self.joblisthandler.arrList.removeAll()
            self.tblList.reloadData()

            self.strType = "past"
            self.GetJobRequestList(type: self.strType)
        }
        
    }
    

    @objc func btnNotificationTapped(_ sender : Any)
    {
        if let notification = NOTIFICATION_LIST.create() {
            self.present(notification, animated: true, completion: nil)
        }
    }

    @objc func btnWalletTapped(_ sender : Any)
    {
        print("tapped")
        let wallet = MYWALLET.create()
        self.navigationController?.pushViewController(wallet, animated: true)

    }
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        self.isLoading = loading
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    //MARK: Webservices
    
    func GetJobRequestList(type : String)
    {
        ServerRequest.shared.GetJobRequestList(type: type, delegate: self) { (response) in

            self.joblisthandler.arrList = response.data
            self.tblList.reloadData()
            self.tblList.isHidden = (self.joblisthandler.arrList.count == 0)
            self.viewEmpty.isHidden = (self.joblisthandler.arrList.count > 0)
            self.isLoading(loading: false)
            
            self.GetNotifcationList()


        } failure: { (errMsg) in
            self.joblisthandler.arrList = []
            self.tblList.reloadData()
            self.viewEmpty.isHidden = (self.joblisthandler.arrList.count > 0)
            self.tblList.isHidden = (self.joblisthandler.arrList.count == 0)
            self.isLoading(loading: false)
        }

    }
    
    func GetNotifcationList()
    {
        ServerRequest.shared.GetNotificationList(delegate: self) { (response) in

            let arrNot = response.list ?? []
            let arrFilter = arrNot.filter{$0.isRead == 1}
            self.navigationItem.setBadgeCount(value: arrFilter.count)
            
        } failure: { (errorMsg) in
        }
    }
    
}
extension JOBS: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    func customViewForEmptyDataSet(in scrollView: UIScrollView) -> UIView? {
        if isLoading {
            return nil
        } else {
            let emptyView = EmptyView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
            emptyView.setup(title: "No Data Found", buttonTitle: "", image: UIImage(named: "no_data"))
            return emptyView
        }
    }
    
    func emptyDataSetDidTapEmptyView(in scrollView: UIScrollView) {

    }
    
}
