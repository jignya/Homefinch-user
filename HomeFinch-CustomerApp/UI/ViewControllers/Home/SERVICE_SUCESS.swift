//
//  SERVICE_SUCESS.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 17/12/20.
//

import UIKit

class SERVICE_SUCESS: UIViewController {

    static func create(jobdata:JobIssueList,fixNow : Bool) -> SERVICE_SUCESS {
        let success = SERVICE_SUCESS.instantiate(fromImShStoryboard: .Home)
        success.jobdata = jobdata
        success.isFixNow = fixNow
        return success
    }
    
    
    @IBOutlet weak var btnviewJobs: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var lblMessage: UILabel!

    @IBOutlet weak var lblJobId: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    @IBOutlet weak var btnCancellation: UIButton!
    
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var viewCall: UIView!

    
    var jobdata:JobIssueList!
    var isFixNow : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        setLabel()
        
        self.lblJobId.text = String(format: "Job ID : %d", jobdata.id)
        self.viewCall.isHidden = true

        if !isFixNow
        {
            if let strStartDate = jobdata.startDate
            {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let serviceDate = dateformatter.date(from: strStartDate)
                {
                    dateformatter.dateFormat = "E, d MMM yyyy"
                    self.lblDate.text = String(format: "Scheduled On : %@ | %@",  dateformatter.string(from: serviceDate),UserSettings.shared.string24To12String(time: jobdata.jobrequestadditionalinfo.slotTime))
                }
            }
            
        }
        else
        {
            self.viewCall.isHidden = false
            self.lblDate.isHidden = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnHome.titleLabel?.font?.pointSize
        {
            btnHome.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnviewJobs.titleLabel?.font?.pointSize
        {
            btnviewJobs.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
      
    }
    func setLabel()
    {
        lblSuccess.text = "Job Request Placed"
        lblMessage.text = "Thank you for submitting your request. The technician will come soon for the diagnosis."
        
        if isFixNow
        {
            lblMessage.text = "Thank you for submitting your request. We will assign technician soon."
        }
        
        btnHome.setTitle("Home", for: .normal)
        btnviewJobs.setTitle("View Jobs", for: .normal)
        
    }
    @IBAction func btnCancellationClick(_ sender: Any) {
        
        let cms = CMS.create(title: "Cancellation Policy")
        self.navigationController?.pushViewController(cms, animated: true)

    }
    
    @IBAction func btnCallClick(_ sender: Any) {
        
//        let clientPhn = self.btnCall.titleLabel?.text?.replacingOccurrences(of: " ", with: "")
        
        let customerPhn = "+971600566663"
        if let url = URL(string: "tel://\(customerPhn)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    }
    
    @IBAction func btnHomeClick(_ sender: Any) {
        
//        self.navigationController?.popToRootViewController(animated: true)
        
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
    
    
    @IBAction func btnviewJobsClick(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let storyboard1 = UIStoryboard(name: "Jobs", bundle: nil)
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
   
}
