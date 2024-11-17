//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class AddService : NSObject, NSCoding{
    
    var additinalComment : String!
    var customerId : Int!
    var customerMobile : String!
    var customerName : String!
    var distributionChannel : String!
    var issueItem : [IssueItem]!
    var propertyId : Int!
    var startDate : String!
    var status : Int!
    var subStatus : Int!

    
    var slotid : String!
    var slottime : String!
    var slotdate : String!
    var subsequentslotId : String!
    var skipPayment : String!
    var skipSlot : String!
    var skipSlotFix : String!

    
    var createdBy : String!
    var issueId : Int!
    var jobReqId : Int!


    override init() {
        
    }


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        additinalComment = json["additinal_comment"].stringValue
        customerId = json["customer_id"].intValue
        customerMobile = json["customer_mobile"].stringValue
        customerName = json["customer_name"].stringValue
        distributionChannel = json["distribution_channel"].stringValue
        issueItem = [IssueItem]()
        let issueItemArray = json["issue_item"].arrayValue
        for issueItemJson in issueItemArray{
            let value = IssueItem(fromJson: issueItemJson)
            issueItem.append(value)
        }
        propertyId = json["property_id"].intValue
        startDate = json["start_date"].stringValue
        status = json["status"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if additinalComment != nil{
            dictionary["additinal_comment"] = additinalComment
        }
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if customerMobile != nil{
            dictionary["customer_mobile"] = customerMobile
        }
        if customerName != nil{
            dictionary["customer_name"] = customerName
        }
        if distributionChannel != nil{
            dictionary["distribution_channel"] = distributionChannel
        }
        if issueItem != nil{
            var dictionaryElements = [[String:Any]]()
            for issueItemElement in issueItem {
                dictionaryElements.append(issueItemElement.toDictionary())
            }
            dictionary["issue_item"] = dictionaryElements
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if startDate != nil{
            dictionary["start_date"] = startDate
        }
        if status != nil{
            dictionary["status"] = status
        }
        if subStatus != nil{
            dictionary["sub_status"] = subStatus
        }
        if slotid != nil{
            dictionary["slot_id"] = slotid
        }
        if slottime != nil{
            dictionary["slot_time"] = slottime
        }
        if slotdate != nil{
            dictionary["slot_date"] = slotdate
        }
        if subsequentslotId != nil{
            dictionary["subsequent_slot_id"] = subsequentslotId
        }
        if skipPayment != nil{
            dictionary["skip_generate_payment_link"] = skipPayment
        }
        if skipSlot != nil{
            dictionary["enable_select_slot_skip"] = skipSlot
        }
        if skipSlotFix != nil{
            dictionary["slot_skipped"] = skipSlotFix
        }
        return dictionary
    }

    func toJobListDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
      
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if customerMobile != nil{
            dictionary["customer_mobile"] = customerMobile
        }
        if customerName != nil{
            dictionary["customer_name"] = customerName
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if jobReqId != nil{
            dictionary["job_request_id"] = jobReqId
        }
        
        
        return dictionary
    }
    
    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         additinalComment = aDecoder.decodeObject(forKey: "additinal_comment") as? String
         customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
         customerMobile = aDecoder.decodeObject(forKey: "customer_mobile") as? String
         customerName = aDecoder.decodeObject(forKey: "customer_name") as? String
         distributionChannel = aDecoder.decodeObject(forKey: "distribution_channel") as? String
         issueItem = aDecoder.decodeObject(forKey: "issue_item") as? [IssueItem]
         propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int
         startDate = aDecoder.decodeObject(forKey: "start_date") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if additinalComment != nil{
            aCoder.encode(additinalComment, forKey: "additinal_comment")
        }
        if customerId != nil{
            aCoder.encode(customerId, forKey: "customer_id")
        }
        if customerMobile != nil{
            aCoder.encode(customerMobile, forKey: "customer_mobile")
        }
        if customerName != nil{
            aCoder.encode(customerName, forKey: "customer_name")
        }
        if distributionChannel != nil{
            aCoder.encode(distributionChannel, forKey: "distribution_channel")
        }
        if issueItem != nil{
            aCoder.encode(issueItem, forKey: "issue_item")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if startDate != nil{
            aCoder.encode(startDate, forKey: "start_date")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
