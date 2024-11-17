//
//  REVIEW_SERVICE.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 23/12/20.
//

import UIKit
import TagCellLayout
import TagListView

class REVIEW_SERVICE: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, FloatRatingViewDelegate , SmileyRateViewDelegate,TagCellLayoutDelegate,TagListViewDelegate {
    
    static func create(data:JobIssueList ,comeFrom:String = "",isCancelled : Bool) -> REVIEW_SERVICE {
        let detail = REVIEW_SERVICE.instantiate(fromImShStoryboard: .Jobs)
        detail.issueData = data
        detail.isCancelled = isCancelled
        return detail
    }
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblRateExp: UILabel!
    @IBOutlet weak var lblHelp: UILabel!
    @IBOutlet weak var viewrating: FloatRatingView!
    
    @IBOutlet weak var lblWhatWentWell: UILabel!
    @IBOutlet weak var collTagList: UICollectionView!
    @IBOutlet weak var conCollTagListHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTagList: UIView!
    
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var txtComments: UITextView!
    
    @IBOutlet weak var viewSubmit: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var conScrollBottom: NSLayoutConstraint!

    @IBOutlet weak var btnrate1: UIButton!
    @IBOutlet weak var btnrate2: UIButton!
    @IBOutlet weak var btnrate3: UIButton!
    @IBOutlet weak var btnrate4: UIButton!
    @IBOutlet weak var btnrate5: UIButton!

    @IBOutlet weak var lblrate1: UILabel!
    @IBOutlet weak var lblrate2: UILabel!
    @IBOutlet weak var lblrate3: UILabel!
    @IBOutlet weak var lblrate4: UILabel!
    @IBOutlet weak var lblrate5: UILabel!
    
    @IBOutlet weak var rateview: SmileyRateView!

    @IBOutlet weak var viewtagLayout: TagListView!


    var arrList = [CustomerType]()
    var issueData : JobIssueList!
    var ratingId : String!
    var isCancelled : Bool!

    var ratingArr = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        rateview.dataPassed = "no"
        rateview.delegate = self
        rateview.commonInit()

        self.setLayout()
        self.setLabel()

    }

    
    func ratingUpdated(count: Int) {
        self.ratingId = count.toString()
        
        self.view.endEditing(true)
        
        if viewComments.isHidden
        {
            self.viewComments.isHidden = false
            self.viewTagList.isHidden = false

            UIView.animate(withDuration: 0.3) {
                self.viewComments.alpha = 1
                self.viewTagList.alpha = 1
            }
        }
    }
    
    func setButtonAlignments()
    {
        let spacing : CGFloat = 10 // the amount of spacing to appear between image and title
        btnrate1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        btnrate1.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        
        btnrate2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        btnrate2.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)

        btnrate3.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        btnrate3.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        
        btnrate4.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        btnrate4.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        
        btnrate5.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        btnrate5.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
//        let totalItems = collTagList.numberOfItems(inSection: 0)
//
//        let currItem: Int = 1
//        var currRowOriginY = CGFloat.greatestFiniteMagnitude
//        for currItem in 0..<totalItems {
//            let attributes = collTagList.collectionViewLayout.layoutAttributesForItem(at: IndexPath(item: currItem, section: 0))
//
//            if currItem == 0 {
//                currRowOriginY = attributes?.frame.origin.y ?? 0
//                continue
//            }
//
//            if (attributes?.frame.origin.y ?? 0.0) > currRowOriginY + 5.0 {
////                break
//            }
//
//        }
//
//
//        print(String(format: "new row started at item %ld", Int(currItem)))
//        let totalRows = totalItems / currItem
//        print(String(format: "%ld rows", totalRows))


//        conCollTagListHeight.constant = CGFloat((arrList.count / 3) * 50)
//        collTagList.updateConstraintsIfNeeded()
//        collTagList.layoutIfNeeded()
    }
    
    func setLayout()
    {
//        handleKeyboardUpdates()

        viewrating.rating = 0
        viewrating.delegate = self
        
        
        let tagCellLayout = TagCellLayout(alignment: .center, delegate: self)
        collTagList.collectionViewLayout = tagCellLayout
        
        
//        let alignedFlowLayout = collTagList?.collectionViewLayout as? AlignedCollectionViewFlowLayout
//        alignedFlowLayout?.horizontalAlignment = .justified
//        alignedFlowLayout?.verticalAlignment = .center
//        alignedFlowLayout?.minimumLineSpacing = 10
//        alignedFlowLayout?.minimumInteritemSpacing = 10
        
        self.viewComments.isHidden = true
        self.viewTagList.isHidden = true
        
        self.viewComments.alpha = 0
        self.viewTagList.alpha = 0
        
        arrList = UserSettings.shared.initialData.cuFeedbackOptions4
        
//        arrList.append(contentsOf: UserSettings.shared.initialData.cuFeedbackOptions4)
        
        for i in 0..<arrList.count
        {
            let dict = arrList[i]
            dict.isSelected = 0
            arrList[i] = dict
        }
        self.collTagList.reloadData()
        

        
//        viewtagLayout.delegate = self
//        viewtagLayout.textFont = UIFont.roboto(size: 14, weight: .Bold) ?? UIFont.systemFont(ofSize: 14)
//        viewtagLayout.alignment = .center // possible values are [.leading, .trailing, .left, .center, .right]
////        viewtagLayout.minWidth = 57
//
//        for i in 0..<arrList.count
//        {
//            let dict = arrList[i]
//            viewtagLayout.addTag(dict.name)
//        }

    }
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }

    
    func setLabel()
    {
        lblRateExp.text = "Rate Your Experience"
        lblHelp.text = "Help us to improve our services by rating us."
        lblWhatWentWell.text = "What went well?"
        lblComments.text = " Additional Comments"
        txtComments.text = ""
        txtComments.placeholder1 = "Let us know more"
        btnSubmit.setTitle("SUBMIT", for: .normal)
    }
    
    //MARK: Floating view
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        self.viewComments.isHidden = false
        self.viewTagList.isHidden = false

        UIView.animate(withDuration: 0.3) {
            self.viewComments.alpha = 1
            self.viewTagList.alpha = 1
        }
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
    }
    
    //MARK: collection methods

    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        
        let nameString = arrList[index].name ?? ""
        let font : UIFont = UIFont.roboto(size: 14, weight: .Regular)!
        let attributes = NSDictionary(object: font, forKey:NSAttributedString.Key.font as NSCopying)
        let sizeOfText = nameString.size(withAttributes: (attributes as! [NSAttributedString.Key : Any]))
        let cellSize = CGSize(width:sizeOfText.width + 30, height:50)

        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.className, for: indexPath) as! TagCell
        
        cell.lblTitle.text = arrList[indexPath.item].name
        
        if arrList[indexPath.item].isSelected == 1
        {
            cell.viewBg.backgroundColor = UserSettings.shared.themeColor()
            cell.lblTitle.textColor = UIColor.white
        }
        else
        {
            cell.viewBg.backgroundColor = UserSettings.shared.ThemeBgGroupColor()
            cell.lblTitle.textColor = UserSettings.shared.themeColor2()
        }
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height > 2400 || UIScreen.main.nativeBounds.height == 1792
            {
                conCollTagListHeight.constant = CGFloat(Float(Double(arrList.count) / 2.75) * 50)
                collTagList.updateConstraintsIfNeeded()
                collTagList.layoutIfNeeded()
                conCollTagListHeight.constant = CGFloat(Float(Double(arrList.count) / 2.75) * 50)
            }
            else
            {
                conCollTagListHeight.constant = CGFloat(Float(Double(arrList.count) / 2) * 50)
                collTagList.updateConstraintsIfNeeded()
                collTagList.layoutIfNeeded()
                conCollTagListHeight.constant = CGFloat(Float(Double(arrList.count) / 2) * 50)
            }
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dict = arrList[indexPath.item]
        if dict.isSelected == 0
        {
            dict.isSelected = 1
            ratingArr.append(dict.id.toString())
        }
        else
        {
            dict.isSelected = 0
            ratingArr.removeAll(where: {$0 == dict.id.toString()})
        }
        
        arrList[indexPath.item] = dict
        self.collTagList.reloadData()

    }
        
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let nameString = arrList[indexPath.item].name ?? ""
        let font : UIFont = UIFont.roboto(size: 14, weight: .Regular)!
        let attributes = NSDictionary(object: font, forKey:NSAttributedString.Key.font as NSCopying)
        let sizeOfText = nameString.size(withAttributes: (attributes as! [NSAttributedString.Key : Any]))
        let cellSize = CGSize(width:sizeOfText.width + 20, height:40)
        return cellSize
    }
    
    //MARK: Button methods
    
    @IBAction func btncloseClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClick(_ sender: Any)
    {
        self.view.endEditing(true)
        if ratingArr.count == 0 || ratingId == nil
        {
            SnackBar.make(in: self.view, message: "Please select rating", duration: .lengthShort).show()
            return
        }
        
        self.rateServices()
    }
    
    @IBAction func btnEmojiClick(_ sender: Any)
    {
        self.view.endEditing(true)
        let btn = sender as! UIButton
        
        if viewComments.isHidden
        {
            self.viewComments.isHidden = false
            self.viewTagList.isHidden = false

            UIView.animate(withDuration: 0.3) {
                self.viewComments.alpha = 1
                self.viewTagList.alpha = 1
            }
        }
       
        
        if btn.tag == 1
        {
            ratingId = "1"
            btnrate1.isSelected = true
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 2
        {
            ratingId = "2"
            btnrate1.isSelected = false
            btnrate2.isSelected = true
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 3
        {
            ratingId = "3"
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = true
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 4
        {
            ratingId = "4"
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = true
            btnrate5.isSelected = false
        }
        else if btn.tag == 5
        {
            ratingId = "5"
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = true
        }
        
        lblrate1.isHidden = !btnrate1.isSelected
        lblrate2.isHidden = !btnrate2.isSelected
        lblrate3.isHidden = !btnrate3.isSelected
        lblrate4.isHidden = !btnrate4.isSelected
        lblrate5.isHidden = !btnrate5.isSelected
        
    }
    
    //MARK: Web service calling
    func rateServices()
    {
        ServerRequest.shared.rateServices(jobRequestId: issueData.id, ratingType: ratingArr, rating: Int(self.ratingId) ?? 0, comment: self.txtComments.text, delegate: self) {
            
            let requestId = String(format: "%d", self.issueData.id)

            let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [requestId,"additional-update"]).absoluteString
            
            let params = ["job_request_id":requestId,"overall_rating_by_customer":self.ratingId,"remarks_by_customer":self.txtComments.text,"ratings_type":self.ratingArr] as [String : Any]
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Rating Added Successfully", aOKBtnTitle: "OK") { (index, title) in
                
                if self.isCancelled
                {
                    // update job status , status - closed , sub-status - Cancelled
                    let dict  = ["status":"7","sub_status":"20","request_info":params,"request_url":serverUrl] as [String : Any]
                    
                    ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.issueData.id, dictPara: dict, delegate: self) {
                        
                        self.dismiss(animated: true) {
                            let vc = UIViewController.topViewController()
                            if vc is JOBS
                            {
                                let controller = vc as! JOBS
                                controller.refreshApi()
                            }
                            else if vc is JOB_PAST_DETAIL
                            {
                                let controller = vc as! JOB_PAST_DETAIL
                                controller.fetchJobRequestDetail()
                            }
                        }

                    } failure: { (errorMsg) in
                        
                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                        }
                    }
                    //-------------------------------
                }
                else
                {
                    // update job status , status - closed , sub-status - serviced
                    let dict  = ["status":"7","sub_status":"19","request_info":params,"request_url":serverUrl] as [String : Any]
                    
                    ServerRequest.shared.UpdateJobstatusApiIntegration(jobid: self.issueData.id, dictPara: dict, delegate: self) {
                        
                        self.dismiss(animated: true) {
                            let vc = UIViewController.topViewController()
                            if vc is JOBS
                            {
                                let controller = vc as! JOBS
                                controller.refreshApi()
                            }
                            else if vc is JOB_PAST_DETAIL
                            {
                                let controller = vc as! JOB_PAST_DETAIL
                                controller.fetchJobRequestDetail()
                            }
                        }
                        
                    } failure: { (errorMsg) in
                        
                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                        }
                    }
                    
                    //-------------------------------

                }
                
            }
            
        } failure: { (errorMsg) in
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                
            }
        }

    }

}
extension REVIEW_SERVICE : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
extension REVIEW_SERVICE {
    
//    func handleKeyboardUpdates() {
//        keyboard.observe { [weak self] (event) -> Void in
//            switch event.type {
//            case .willShow, .willChangeFrame, .willHide:
//                let distance = UIScreen.main.bounds.height - event.keyboardFrameEnd.origin.y
//                print(distance)
//                UIView.animate(withDuration: event.duration, delay: 0.0, options: [event.options], animations:
//                    { [weak self] () -> Void in
//                        self?.conScrollBottom.constant = -distance
//                    } , completion: nil)
//            default:
//                break
//            }
//        }
//    }
    
}
