//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class PastServiceListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    
    var arrServices = [Jobrequestitem]()
    var didSelect: ((IndexPath) -> Void)? = nil
    var SelectIssueClick: ((IndexPath) -> Void)? = nil  
    var CancelIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming
    var EditIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming

        
    var strComeFrom :String = ""
    var selectedIndex :Int!

    var iscancelled :Bool!
    var isclosed :Bool!

    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceListCell.className, for: indexPath) as! ServiceListCell
        
        cell.btnSelect.isHidden = true
        cell.btnEdit.isHidden = true
        cell.btnCancel.isHidden = true
        cell.imgArw.image = UIImage(named: "Down")
        
        let dict = arrServices[indexPath.row]
        cell.lblName.text = dict.items
        cell.lblDesc.text = dict.descriptionField
        
        cell.imgStatusIcon.image = CommonFunction.shared.setIssueStatusIcon(status: dict.status)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        tapGesture.numberOfTapsRequired = 1
        cell.imgStatusIcon.tag = indexPath.row
        cell.imgStatusIcon.isUserInteractionEnabled = true
        cell.imgStatusIcon.addGestureRecognizer(tapGesture)
        
        
        cell.strcomeFrom = "joblist"
        cell.images.removeAll()
        for attachment in dict.jobitemsattachments
        {
            var dictimage = [String:Any]()
            dictimage["id"] = attachment.id
            dictimage["path"] = attachment.path
            dictimage["job_request_id"] = attachment.jobRequestId
            cell.images.append(dictimage)
        }
        
        cell.ImShSetLayout()
        
        if dict.isExpand == 1
        {
            cell.imgArw.image = UIImage(named: "Up")
            cell.viewImages.isHidden = (dict.jobitemsattachments.count == 0)
            cell.viewDesc.isHidden = false
            cell.viewButtons.isHidden = self.iscancelled
        }
        else
        {
            cell.imgArw.image = UIImage(named: "Down")
            cell.viewButtons.isHidden = true
            cell.viewDesc.isHidden = true
            cell.viewImages.isHidden = true
        }
        
        cell.lblBeforeDesc.text = dict.commentBeforeInspection
        cell.lblAfterDesc.text = dict.commentAfterInspection
        
        cell.imgBefore.contentMode = .scaleAspectFill
        cell.imgAfter.contentMode = .scaleAspectFill
        
        cell.viewBefore.isHidden = true
        cell.viewAfter.isHidden = true
        cell.viewTechnicianComment.isHidden = true
        
        if dict.isExpand == 1
        {
            cell.viewBefore.isHidden = !(dict.jobitemsbeforeinspections.count > 0 || dict.commentBeforeInspection != "")
            cell.viewAfter.isHidden = !(dict.jobitemsafterinspections.count > 0 || dict.commentAfterInspection != "")
            
            cell.viewTechnicianComment.isHidden = (cell.viewBefore.isHidden && cell.viewAfter.isHidden)
            
//            let arrservice = dict.jobservice.filter{$0.warrantyEndDate == "" || self.compareWarrantydate(warrantyDate: $0.warrantyEndDate) == false}
            
            let arrMaterial = dict.jobitemsmaterials.filter{self.compareWarrantydate(warrantyDate: $0.warrantyEndDate) == true && $0.type == 2}
            if arrMaterial.count > 0
            {
                cell.viewButtons.isHidden = false
            }
            else
            {
                cell.viewButtons.isHidden = true
            }
        }
        
        cell.imgBefore.image = UIImage.image(type: .Placeholder)
        cell.imgAfter.image = UIImage.image(type: .Placeholder)
        
        if dict.jobitemsbeforeinspections.count > 0
        {
            if let path =  dict.jobitemsbeforeinspections[0].filePath
            {
                if path.contains("jpg") || path.contains("png") || path.contains("svg")
                {
                    cell.imgBefore.setImage(url: path.getURL, placeholder: UIImage.image(type: .Placeholder))
                }
                else
                {
                    cell.imgBefore.image = UIImage.image(type: .Placeholder)
                    
                    if let video_Url = path.getURL
                    {
                        self.getThumbnailImageFromVideoUrl(url: video_Url) { (thumbImage) in
                            cell.imgBefore.image = thumbImage
                        }
                    }
                }
                
            }
        }
        
        if dict.jobitemsafterinspections.count > 0
        {
            
            if let path =  dict.jobitemsafterinspections[0].filePath
            {
                if path.contains("jpg") || path.contains("png") || path.contains("svg")
                {
                    cell.imgAfter.setImage(url: path.getURL, placeholder: UIImage.image(type: .Placeholder))
                }
                else
                {
                    cell.imgAfter.image = UIImage.image(type: .Placeholder)
                    
                    if let video_Url = path.getURL
                    {
                        self.getThumbnailImageFromVideoUrl(url: video_Url) { (thumbImage) in
                            cell.imgAfter.image = thumbImage
                        }
                    }
                }
                
            }
        }
        
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapGestureBefore(_:)))
        tapGesture1.numberOfTapsRequired = 1
        cell.imgBefore.tag = indexPath.row
        cell.imgBefore.isUserInteractionEnabled = true
        cell.imgBefore.addGestureRecognizer(tapGesture1)
        
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapGestureAfter(_:)))
        tapGesture2.numberOfTapsRequired = 1
        cell.imgAfter.tag = indexPath.row
        cell.imgAfter.isUserInteractionEnabled = true
        cell.imgAfter.addGestureRecognizer(tapGesture2)

        
        
        cell.btnFollowUp.tag = indexPath.row
        cell.btnFollowUp.addTarget(self, action: #selector(BtnEditClick(_:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = arrServices[indexPath.row]
        
        if dict.isExpand == 0
        {
            dict.isExpand = 1
        }
        else
        {
            dict.isExpand = 0
        }
        arrServices[indexPath.row] = dict
        self.didSelect?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let dict = arrServices[indexPath.row]
        
        return UITableView.automaticDimension
        
        
//        var height : CGFloat = 70
//        if dict.isExpand == 1
//        {
//            if dict.jobitemsattachments.count != 0
//            {
//                height = height + 100 + 8
//            }
//            if dict.descriptionField != ""
//            {
//                let nameString = dict.descriptionField ?? ""
//
//                let font : UIFont = UIFont.roboto(size: 17, weight: .Regular)!
//
//                let labelheight1 = nameString.height(withConstrainedWidth: (tableView.frame.size.width - 40), font: font)
//
//                height = height + labelheight1 + 8
//            }
//            if !iscancelled
//            {
//                let arrMaterial = dict.jobitemsmaterials.filter{self.compareWarrantydate(warrantyDate: $0.warrantyEndDate) == true && $0.type == 2}
//                if arrMaterial.count > 0
//                {
//                    height = height + 70 + 8
//                }
//            }
//
//            if (dict.jobitemsbeforeinspections.count > 0 || dict.commentBeforeInspection != "") && (dict.jobitemsafterinspections.count > 0 || dict.commentAfterInspection != "")
//            {
//                height = height + 300 + 8 + 20
//
//            }
//            else if (dict.jobitemsbeforeinspections.count > 0 || dict.commentBeforeInspection != "")
//            {
//                height = height + 180 + 8 + 20
//            }
//            else if (dict.jobitemsafterinspections.count > 0 || dict.commentAfterInspection != "")
//            {
//                height = height + 180 + 8 + 20
//            }
//
//        }
//
//        return height
    }
    
    //MARK: Compare date
    
    func compareWarrantydate(warrantyDate : String) -> Bool {
        
        let date1 = Date()
        if let date2 = warrantyDate.toDate()
        {
            if date1.compare(date2) == .orderedAscending {
                return true
            }
        }
        
        return false
    }
    
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
//        let cartItem = products.at(index: btn.tag)
//        self.favouriteTapped?(cartItem ,btn.tag)
        self.SelectIssueClick?(indexpath)
    }
    
    @objc func BtnEditClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.EditIssueClick?(indexpath)
    }
    
    //MARK: Gesture Methods
    @objc func tapGesture(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let dict = arrServices[img.tag]
            
            let status = UserSettings.shared.initialData.issueStatusList.filter{$0.id == dict.status}
            
            if status.count > 0
            {
                let pop = PopOverView.create(status: status[0].name, sender: img)
                
                pop.modalPresentationStyle = .popover
                // set up the popover presentation controller
                pop.popoverPresentationController?.delegate = self
                pop.popoverPresentationController?.permittedArrowDirections = .down
                pop.popoverPresentationController?.sourceView = img // button

                let vc = UIApplication.topViewController()
                vc?.present(pop, animated: true, completion: nil)

            }
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        // Force popover style

        return UIModalPresentationStyle.none
    }

    @objc func tapGestureBefore(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let dict = arrServices[img.tag]
            if dict.jobitemsbeforeinspections.count > 0
            {
                var images = [[String:Any]]()
                for attachment in dict.jobitemsbeforeinspections
                {
                    var dictimage = [String:Any]()
                    dictimage["id"] = attachment.id
                    dictimage["path"] = attachment.filePath
                    dictimage["job_request_id"] = attachment.jobRequestId
                    images.append(dictimage)
                }
                
                let storyboard = UIStoryboard.init(name: "Other", bundle: nil)
                let image = storyboard.instantiateViewController(withIdentifier: "ImagePreviewVC") as! ImagePreviewVC
                image.arrrimages = NSMutableArray(array: images)
                image.index = IndexPath(item: 0, section: 0)
                image.strcome = ""
                image.modalPresentationStyle = .overFullScreen
                let vc = UIApplication.topViewController()
                vc?.present(image, animated: false, completion: nil)
            }
        }
    }
    
    @objc func tapGestureAfter(_ sender:UITapGestureRecognizer)
    {
        if let img = sender.view as? UIImageView {
            
            let dict = arrServices[img.tag]
            if dict.jobitemsafterinspections.count > 0
            {
                var images = [[String:Any]]()
                for attachment in dict.jobitemsafterinspections
                {
                    var dictimage = [String:Any]()
                    dictimage["id"] = attachment.id
                    dictimage["path"] = attachment.filePath
                    dictimage["job_request_id"] = attachment.jobRequestId
                    images.append(dictimage)
                }
                
                let storyboard = UIStoryboard.init(name: "Other", bundle: nil)
                let image = storyboard.instantiateViewController(withIdentifier: "ImagePreviewVC") as! ImagePreviewVC
                image.arrrimages = NSMutableArray(array: images)
                image.index = IndexPath(item: 0, section: 0)
                image.strcome = ""
                image.modalPresentationStyle = .overFullScreen
                let vc = UIApplication.topViewController()
                vc?.present(image, animated: false, completion: nil)
            }
        }
    }
    
    //MARK: Create thumbnail
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
}
extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
