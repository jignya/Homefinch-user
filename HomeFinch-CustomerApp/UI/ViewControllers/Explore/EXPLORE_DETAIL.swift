//
//  EXPLORE_DETAIL.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/01/21.
//

import UIKit
import ReadMoreTextView

class EXPLORE_DETAIL: UIViewController,ASFSharedViewTransitionDataSource {
    
    static func create(serviceData : Servicelist) -> EXPLORE_DETAIL {
        let detail = EXPLORE_DETAIL.instantiate(fromImShStoryboard: .Explore)
        detail.serviceData = serviceData
        return detail
    }
    
   
    //MARK:Outlets
    
    @IBOutlet weak var viewSlider: UIView!

    
    @IBOutlet weak var collSlidder: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgCat: UIImageView!
    
    @IBOutlet weak var txtDesc: ReadMoreTextView!
    
    @IBOutlet weak var lblWarranty: UILabel!
    @IBOutlet weak var lblWarrantyValue: UILabel!

    @IBOutlet weak var lblInstallation: UILabel!
    @IBOutlet weak var lblInstallationValue: UILabel!

    @IBOutlet weak var lblFeature: UILabel!
    @IBOutlet weak var lblFeatureValue: UILabel!

    @IBOutlet weak var btnSchedule: UIButton!
    @IBOutlet weak var btnFixNow: UIButton!
    
    @IBOutlet weak var viewWarranty: UIView!
    @IBOutlet weak var viewInstallation: UIView!
    @IBOutlet weak var viewFeatures: UIView!



    // MARK: PRIVATE
    private let bannersHandler = SliderImagesCollectionHandler()
    var serviceData : Servicelist!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ImShSetLayout()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.setData(dict: serviceData)
    }
    
    func sharedView() -> UIView! {
        
        viewSlider.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)

        return viewSlider
    }
    
    func setData(dict:Servicelist)
    {
        titleLbl.text = dict.name
        PriceLbl.text = String(format: "%@ %d", dict.currencyCode , dict.price)
        
        txtDesc.text = dict.descriptionField
        
        if dict.warrantyPeriod == nil || dict.warrantyPeriod == ""
        {
            self.viewWarranty.isHidden = true
        }
        
//        if dict.warrantyPeriod == nil || dict.warrantyPeriod == ""
//        {
            self.viewFeatures.isHidden = true
//        }
//
//        if dict.warrantyPeriod == nil || dict.warrantyPeriod == ""
//        {
            self.viewInstallation.isHidden = true
//        }
        
        lblWarrantyValue.text = dict.warrantyPeriod
        lblInstallationValue.text = ""
        lblFeatureValue.text = ""
        
        bannersHandler.images = [dict.mainImagePath]
        bannersHandler.imageContentMode = .scaleAspectFill
        pageControl.numberOfPages = bannersHandler.images.count
        self.collSlidder.reloadData()
    }
    
    override func ImShSetLayout() {
        
        self.setLabel()
        
        let defaultReadMoreText = "... READ MORE"
        
        let attributedDefaultReadMoreText = NSAttributedString(string: defaultReadMoreText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1),
            NSAttributedString.Key.font: UIFont.roboto(size: 14, weight: .Medium) as Any
        ])
        
        let defaultReadLessText = " READ LESS"
        
        let attributedDefaultReadLessText = NSAttributedString(string: defaultReadLessText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1),
            NSAttributedString.Key.font: UIFont.roboto(size: 14, weight: .Medium) as Any
        ])
        
        txtDesc.attributedReadMoreText = attributedDefaultReadMoreText
        txtDesc.attributedReadLessText = attributedDefaultReadLessText

        
        /// Registering cells

        
        bannersHandler.isStatic = false
        self.collSlidder.setUp(delegate: bannersHandler, dataSource: bannersHandler, cellNibWithReuseId: ImageCell.className)
        
        
        /// Handling actions
        bannersHandler.didScroll = {
            guard let currIndex = self.collSlidder.getCurrentIndexpath() else { return }
            self.pageControl.currentPage = currIndex.row
        }
        
        bannersHandler.didSelect =  {
        }
    }
    
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblWarranty.text = "Warranty"
        lblInstallation.text = "Installation"
        lblFeature.text = "Features"
        btnSchedule.setTitle("SCHEDULE", for: .normal)
        btnFixNow.setTitle(("PROCEED").uppercased(), for: .normal)
        btnSchedule.isHidden = true

    }
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnSchedule.titleLabel?.font?.pointSize
        {
            btnSchedule.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnFixNow.titleLabel?.font?.pointSize
        {
            btnFixNow.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
    }
    
    
    //MARK: Buttton Methods

    @IBAction func btnScheduleClick(_ sender: Any) {
        
//        let schedule = CALENDER_TIME.create(issueList: <#[Jobrequestitem]#>)
//        self.navigationController?.pushViewController(schedule, animated: true)

    }
    
    @IBAction func btnFixNowClick(_ sender: Any) { // proceed button
        
        ServerRequest.shared.GetServiceWiseIssueList(serviceId: serviceData.id.toString(), delegate: self) {
            (response) in
            
            if response.data.count > 0
            {
                let issueData = response.data[0]
                let idata = CategoryIssueList.init()
                idata.id = issueData.id
                idata.categoryId = issueData.categoryId
                idata.issueDescription = issueData.issueDescription
                
                let detail = SERVICE_DETAIL.create(issueData: issueData,strcomeFrom: "detail")
                self.navigationController?.pushViewController(detail, animated: false)

            }
            else
            {
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "No service items available", aOKBtnTitle: "OK") { (index, title) in
                                   
                }

            }
            
        } failure: { (errMsg) in
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errMsg, aOKBtnTitle: "OK") { (index, title) in
                               
            }
        }
    

    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
    

}
extension EXPLORE_DETAIL : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
