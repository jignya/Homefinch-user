//
//  TimeSlotTableHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class JobListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var didSelect: ((IndexPath) -> Void)? = nil
    var RateServiceTapped: ((IndexPath) -> Void)? = nil
    var CancelServiceTapped: ((IndexPath) -> Void)? = nil

    
    var isupcoming : Bool = false
    
    var arrList = [JobIssueList]()
    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isupcoming
        {
            return arrList.count
        }
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobCell.className, for: indexPath) as! JobCell
        
        cell.lblFixNow.text = ("Fix Now").uppercased()
        cell.viewFixNow1.alpha = 1
        
        cell.btnRateService.tag = indexPath.row
        cell.btnRateService.addTarget(self, action: #selector(btnrateServiceClick(_:)), for: .touchUpInside)
        
        cell.btnCancelled.isUserInteractionEnabled = true
        cell.btnCancelled.tag = indexPath.row
        cell.btnCancelled.addTarget(self, action: #selector(btncancelReqClick(_:)), for: .touchUpInside)

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let jobIssue = arrList[indexPath.row]
        cell.viewRatedService.isHidden = true
        cell.viewRateService.isHidden = true
        
        cell.viewRated.dataPassed = "yes"
        cell.viewRated.commonInit()
        
        cell.viewApplyRating.dataPassed = "yes"
        cell.viewApplyRating.commonInit()

        cell.lblServiceNum.text = String(format: "Job %d", jobIssue.id)
        
        let jobDate =  jobIssue.startDate
        if let jobdate = dateformatter.date(from: jobDate!)
        {
            if jobIssue.distributionChannel.lowercased() != "fixnow"   //if jobIssue.slotSkipped == 1
            {
                dateformatter.dateFormat = "E, d MMM yyyy - hh:mm a"
                cell.lblDate.text = dateformatter.string(from: jobdate)
            }
            else
            {
                dateformatter.dateFormat = "E, d MMM yyyy"
                cell.lblDate.text = dateformatter.string(from: jobdate)
            }
        }
        
        cell.lblserviceCount.text = String(format: "%d Issue", jobIssue.issueCount)
        
        let arrStatus = UserSettings.shared.initialData.jobRequestStatus.filter { $0.id == jobIssue.status}
        if arrStatus.count > 0
        {
            cell.lblStatus.text = arrStatus[0].name.capitalized
        }
        
        
        cell.viewBorder.borderWidth = 0.7
        cell.viewDashed.isHidden = true
        cell.viewFixNow1.isHidden = true
        //------------------
        cell.viewRatedService.isHidden = true
        cell.viewRateService.isHidden = true
        //------------------
        cell.viewCancelled.isHidden = true
        
        if jobIssue.status == 1  && jobIssue.subStatus == 1 // requested, Draft
        {
            cell.viewBorder.borderWidth = 0.7
            cell.viewDashed.isHidden = true
            cell.viewFixNow1.isHidden = true
            cell.viewCancelled.isHidden = false
            
            cell.lblDate.text = ""
            
//            let arrStatus = UserSettings.shared.initialData.jobRequetSubStatus.filter { $0.id == jobIssue.subStatus}
//            if arrStatus.count > 0
//            {
//                cell.lblStatus.text = arrStatus[0].name.capitalized
//            }

            //------------------
//            cell.imgService.image = UIImage.Serviceimage(type: .S_Cancelled)
//            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .cancelled)
//            cell.lblStatus.textColor = UIColor.statusTextColor(status: .cancelled)
            
            cell.imgService.image = UIImage.Serviceimage(type: .S_Placed)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .servicePlaced)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .servicePlaced)

        }
        else if jobIssue.status == 1  // requested
        {
            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Placed)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .servicePlaced)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .servicePlaced)
            
            cell.viewCancelled.isHidden = false
           
        }
        else if jobIssue.status == 2 // out for services
        {
            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Intransit)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .outForService)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .outForService)
            
        }
        else if jobIssue.status == 3 // inspection
        {
            cell.viewRatedService.isHidden = true
            cell.viewRateService.isHidden = true
            
            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Inspection)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .inspection)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .inspection)
        }
        else if jobIssue.status == 4 // execution
        {
            cell.viewRatedService.isHidden = true
            cell.viewRateService.isHidden = true
            
            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Inspection)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .inspection)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .inspection)
        }
        
        else if jobIssue.status == 5  // completed - payment success
        {
//            let arrStatus = UserSettings.shared.initialData.jobRequetSubStatus.filter { $0.id == jobIssue.subStatus}
//            if arrStatus.count > 0
//            {
//                cell.lblStatus.text = arrStatus[0].name.capitalized
//            }
            
            if (jobIssue.subStatus == 14) // invoice
            {
                //------------------
                cell.imgService.image = UIImage.Serviceimage(type: .S_Completed)
                cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .completed)
                cell.lblStatus.textColor = UIColor.statusTextColor(status: .completed)
            }
            else if (jobIssue.subStatus == 15)  // invoice , success
            {
                if jobIssue.jobrequestadditionalinfo.overallRatingByCustomer == ""
                {
                    cell.viewRatedService.isHidden = true
                    cell.viewRateService.isHidden = false
                }
                else
                {
                    cell.viewRated.currentCount = Int(jobIssue.jobrequestadditionalinfo.overallRatingByCustomer) ?? 3
                    cell.viewRatedService.isHidden = false
                    cell.viewRateService.isHidden = true
                }
                
                //------------------
                cell.imgService.image = UIImage.Serviceimage(type: .S_Completed)
                cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .completed)
                cell.lblStatus.textColor = UIColor.statusTextColor(status: .completed)
            }
            else if (jobIssue.subStatus == 16)  // failed
            {
                cell.viewBorder.borderWidth = 0.7
                cell.viewDashed.isHidden = true
                cell.viewFixNow1.isHidden = true

                //------------------
                cell.imgService.image = UIImage.Serviceimage(type: .S_Cancelled)
                cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .cancelled)
                cell.lblStatus.textColor = UIColor.statusTextColor(status: .cancelled)
                
                cell.viewRatedService.isHidden = true
                cell.viewRateService.isHidden = true

            }
            
        }
        else if jobIssue.status == 6 // cancelled
        {
            cell.viewBorder.borderWidth = 0.7
            cell.viewDashed.isHidden = true
            cell.viewFixNow1.isHidden = true

            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Cancelled)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .cancelled)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .cancelled)
            
            if jobIssue.jobrequestadditionalinfo.overallRatingByCustomer == ""
            {
                cell.viewRatedService.isHidden = true
                cell.viewRateService.isHidden = false
            }
            else
            {
                cell.viewRated.currentCount = Int(jobIssue.jobrequestadditionalinfo.overallRatingByCustomer) ?? 0
                cell.viewRatedService.isHidden = false
                cell.viewRateService.isHidden = true
            }
            
//            let arrPayInfo = jobIssue.paymenttransaction.filter{$0.statusCode == "A"}
//
//            if jobIssue.jobotherservices.count > 0 && arrPayInfo.count == 0
//            {
//                cell.lblStatus.text = "Pending Payment"
//            }

        }
        
        else if jobIssue.status == 7 && jobIssue.subStatus == 19 // closed - Serviced
        {
            if jobIssue.jobrequestadditionalinfo != nil
            {
                if jobIssue.jobrequestadditionalinfo.overallRatingByCustomer == ""
                {
                    cell.viewRatedService.isHidden = true
                    cell.viewRateService.isHidden = false
                }
                else
                {
                    cell.viewRated.currentCount = Int(jobIssue.jobrequestadditionalinfo.overallRatingByCustomer) ?? 0
//                    cell.viewRated.rating = Double(jobIssue.jobrequestadditionalinfo.ratingsByTechnician)!
                    cell.viewRatedService.isHidden = false
                    cell.viewRateService.isHidden = true
                }
            }
            
            cell.viewDashed.isHidden = true
            cell.viewFixNow1.isHidden = true

            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Completed)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .completed)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .completed)

        }
        else if jobIssue.status == 7 && jobIssue.subStatus == 20 // closed - Cancelled
        {
            
            if jobIssue.jobrequestadditionalinfo.overallRatingByCustomer == ""
            {
                cell.viewRatedService.isHidden = true
                cell.viewRateService.isHidden = false
            }
            else
            {
                cell.viewRated.currentCount = Int(jobIssue.jobrequestadditionalinfo.overallRatingByCustomer) ?? 0
                cell.viewRatedService.isHidden = false
                cell.viewRateService.isHidden = true
            }
            
//            cell.viewRatedService.isHidden = true
//            cell.viewRateService.isHidden = true
//
//            cell.viewDashed.isHidden = true
//            cell.viewFixNow1.isHidden = true

            //------------------
            cell.imgService.image = UIImage.Serviceimage(type: .S_Cancelled)
            cell.viewImgBg.backgroundColor = UIColor.statusBackgroundColor(status: .cancelled)
            cell.lblStatus.textColor = UIColor.statusTextColor(status: .cancelled)

        }

        cell.viewBorder.backgroundColor = UIColor.white

        
        if jobIssue.distributionChannel.lowercased() == "fixnow"
        {
            // Fix Now
            cell.viewBorder.borderWidth = 0
            cell.viewDashed.isHidden = false
            cell.viewFixNow1.isHidden = false
            cell.viewBorder.backgroundColor = UIColor.init(hex: "FFF7F6")
        }
        
        cell.lblStatus.textColor = UserSettings.shared.themeColor2()
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.didSelect?(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let jobIssue = arrList[indexPath.row]
//        if jobIssue.subStatus == 1
//        {
//            return 0
//        }

        return UITableView.automaticDimension
    }
    
    @objc func btnrateServiceClick(_ Sender:UIButton)
    {
        let btn = Sender
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.RateServiceTapped?(indexpath)
    }
    
    @objc func btncancelReqClick(_ Sender:UIButton)
    {
        let btn = Sender
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.CancelServiceTapped?(indexpath)
    }
}

