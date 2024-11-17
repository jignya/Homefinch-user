//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class UpcomingServiceListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource ,UIPopoverPresentationControllerDelegate{
    
    var arrServices = [Jobrequestitem]()
    var didSelect: ((IndexPath) -> Void)? = nil
    var SelectIssueClick: ((IndexPath) -> Void)? = nil  
    var CancelIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming
    var EditIssueClick: ((IndexPath) -> Void)? = nil  // for job_detail_upcoming

        
    var strComeFrom :String = ""
    var isEditable :String!


    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceListCell.className, for: indexPath) as! ServiceListCell
        
        cell.imgArw.image = UIImage(named: "Down")
        cell.btnSelect.isHidden = true
        cell.btnFollowUp.isHidden = true
        
        cell.conImageListHeight.constant = 80
        
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

        cell.btnCancel.alpha = 1
        cell.btnCancel.isEnabled = true
        
        cell.lblBeforeDesc.text = dict.commentBeforeInspection
        cell.lblAfterDesc.text = dict.commentAfterInspection
        
        cell.imgBefore.contentMode = .scaleAspectFill
        cell.imgAfter.contentMode = .scaleAspectFill
        
        cell.viewBefore.isHidden = true
        cell.viewAfter.isHidden = true
        cell.viewTechnicianComment.isHidden = true


        if dict.isExpand == 1
        {
            cell.imgArw.image = UIImage(named: "Up")
            cell.viewImages.isHidden = (cell.images.count == 0)
            cell.viewDesc.isHidden = false
            
            if isEditable == "2"  // requested - both enabled
            {
                cell.viewButtons.isHidden = false
            }
            else if isEditable == "1" // out for service - only edit enabled
            {
                cell.viewButtons.isHidden = false
                cell.btnCancel.alpha = 0.5
                cell.btnCancel.isEnabled = false
            }
            else 
            {
                cell.viewButtons.isHidden = true  //inspection -  both disabled
            }
            
            if dict.status == 8
            {
                cell.viewButtons.isHidden = true
            }
                
            
            cell.viewBefore.isHidden = !(dict.jobitemsbeforeinspections.count > 0 || dict.commentBeforeInspection != "")
            cell.viewAfter.isHidden = !(dict.jobitemsafterinspections.count > 0 || dict.commentAfterInspection != "")
            cell.viewTechnicianComment.isHidden = (cell.viewBefore.isHidden && cell.viewAfter.isHidden)
        }
        else
        {
            cell.imgArw.image = UIImage(named: "Down")
            cell.viewButtons.isHidden = true
            cell.viewDesc.isHidden = true
            cell.viewImages.isHidden = true
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
        

        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(BtnEditClick(_:)), for: .touchUpInside)

        cell.btnCancel.tag = indexPath.row
        cell.btnCancel.addTarget(self, action: #selector(BtnCancelClick(_:)), for: .touchUpInside)
        
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
        let dict = arrServices[indexPath.row]
//        if dict.status == 11
//        {
//            return 0
//        }
        return UITableView.automaticDimension
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
    
    @objc func BtnCancelClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.CancelIssueClick?(indexpath)
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
