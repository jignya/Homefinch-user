//
//	Jobrequestitem.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobrequestitem : NSObject, NSCoding{
    
    var actualIssue1 : String!
    var actualIssue2 : String!
    var actualIssueId : [String]!
    var actualServiceId : [String]!
    var appVersion : String!
    var categoryId : Int!
    var commentAfterInspection : String!
    var commentBeforeInspection : String!
    var createdAt : String!
    var createdBy : Int!
    var customerDescription : String!
    var descriptionField : String!
    var id : Int!
    var internalRemarks : String!
    var issueId : Int!
    var itemQuantity : String!
    var itemUom : String!
    var items : String!
    var jobRequestId : Int!
    var jobcategory : Jobcategory!
    var jobissue : Jobissue!
    var jobitemsafterinspections : [Jobitemsafterinspection]!
    var jobitemsattachments : [Jobattachment]!
    var jobitemsbeforeinspections : [Jobitemsbeforeinspection]!
    var jobitemsmaterials : [JobIssueList]!
    var jobservice : Jobservice!
    var productId : String!
    var quantity : String!
    var resolution1 : String!
    var resolution2 : String!
    var serviceId : Int!
    var sourceFrom : Int!
    var sourceInfo : String!
    var sourceIp : String!
    var status : Int!
    var updatedAt : String!
    var updatedBy : String!

    var isExpand : Int = 0
    var isSelected : Int = 0

    
    override init() {
    }


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        actualIssue1 = json["actual_issue_1"].stringValue
        actualIssue2 = json["actual_issue_2"].stringValue
        actualIssueId = [String]()
        let actualIssueIdArray = json["actual_issue_id"].arrayValue
        for actualIssueIdJson in actualIssueIdArray{
            actualIssueId.append(actualIssueIdJson.stringValue)
        }
        actualServiceId = [String]()
        let actualServiceIdArray = json["actual_service_id"].arrayValue
        for actualServiceIdJson in actualServiceIdArray{
            actualServiceId.append(actualServiceIdJson.stringValue)
        }
        appVersion = json["app_version"].stringValue
        categoryId = json["category_id"].intValue
        commentAfterInspection = json["comment_after_inspection"].stringValue
        commentBeforeInspection = json["comment_before_inspection"].stringValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].intValue
        customerDescription = json["customer_description"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        internalRemarks = json["internal_remarks"].stringValue
        issueId = json["issue_id"].intValue
        itemQuantity = json["item_quantity"].stringValue
        itemUom = json["item_uom"].stringValue
        items = json["items"].stringValue
        jobRequestId = json["job_request_id"].intValue
        let jobcategoryJson = json["jobcategory"]
        if !jobcategoryJson.isEmpty{
            jobcategory = Jobcategory(fromJson: jobcategoryJson)
        }
        let jobissueJson = json["jobissue"]
        if !jobissueJson.isEmpty{
            jobissue = Jobissue(fromJson: jobissueJson)
        }
        jobitemsafterinspections = [Jobitemsafterinspection]()
        let jobitemsafterinspectionsArray = json["jobitemsafterinspections"].arrayValue
        for jobitemsafterinspectionsJson in jobitemsafterinspectionsArray{
            let value = Jobitemsafterinspection(fromJson: jobitemsafterinspectionsJson)
            jobitemsafterinspections.append(value)
        }
        jobitemsattachments = [Jobattachment]()
        let jobitemsattachmentsArray = json["jobitemsattachments"].arrayValue
        for jobitemsattachmentsJson in jobitemsattachmentsArray{
            let value = Jobattachment(fromJson: jobitemsattachmentsJson)
            jobitemsattachments.append(value)
        }
        jobitemsbeforeinspections = [Jobitemsbeforeinspection]()
        let jobitemsbeforeinspectionsArray = json["jobitemsbeforeinspections"].arrayValue
        for jobitemsbeforeinspectionsJson in jobitemsbeforeinspectionsArray{
            let value = Jobitemsbeforeinspection(fromJson: jobitemsbeforeinspectionsJson)
            jobitemsbeforeinspections.append(value)
        }
        jobitemsmaterials = [JobIssueList]()
        let jobitemsmaterialsArray = json["jobitemsmaterials"].arrayValue
        for jobitemsmaterialsJson in jobitemsmaterialsArray{
            let value = JobIssueList(fromJson: jobitemsmaterialsJson)
            jobitemsmaterials.append(value)
        }
        let jobserviceJson = json["jobservice"]
        if !jobserviceJson.isEmpty{
            jobservice = Jobservice(fromJson: jobserviceJson)
        }
        productId = json["product_id"].stringValue
        quantity = json["quantity"].stringValue
        resolution1 = json["resolution_1"].stringValue
        resolution2 = json["resolution_2"].stringValue
        serviceId = json["service_id"].intValue
        sourceFrom = json["source_from"].intValue
        sourceInfo = json["source_info"].stringValue
        sourceIp = json["source_ip"].stringValue
        status = json["status"].intValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if actualIssue1 != nil{
            dictionary["actual_issue_1"] = actualIssue1
        }
        if actualIssue2 != nil{
            dictionary["actual_issue_2"] = actualIssue2
        }
        if actualIssueId != nil{
            dictionary["actual_issue_id"] = actualIssueId
        }
        if actualServiceId != nil{
            dictionary["actual_service_id"] = actualServiceId
        }
        if appVersion != nil{
            dictionary["app_version"] = appVersion
        }
        if categoryId != nil{
            dictionary["category_id"] = categoryId
        }
        if commentAfterInspection != nil{
            dictionary["comment_after_inspection"] = commentAfterInspection
        }
        if commentBeforeInspection != nil{
            dictionary["comment_before_inspection"] = commentBeforeInspection
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if customerDescription != nil{
            dictionary["customer_description"] = customerDescription
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if internalRemarks != nil{
            dictionary["internal_remarks"] = internalRemarks
        }
        if issueId != nil{
            dictionary["issue_id"] = issueId
        }
        if itemQuantity != nil{
            dictionary["item_quantity"] = itemQuantity
        }
        if itemUom != nil{
            dictionary["item_uom"] = itemUom
        }
        if items != nil{
            dictionary["items"] = items
        }
        if jobRequestId != nil{
            dictionary["job_request_id"] = jobRequestId
        }
        if jobcategory != nil{
            dictionary["jobcategory"] = jobcategory.toDictionary()
        }
        if jobissue != nil{
            dictionary["jobissue"] = jobissue.toDictionary()
        }
        if jobitemsafterinspections != nil{
            var dictionaryElements = [[String:Any]]()
            for jobitemsafterinspectionsElement in jobitemsafterinspections {
                dictionaryElements.append(jobitemsafterinspectionsElement.toDictionary())
            }
            dictionary["jobitemsafterinspections"] = dictionaryElements
        }
        if jobitemsattachments != nil{
            var dictionaryElements = [[String:Any]]()
            for jobitemsattachmentsElement in jobitemsattachments {
                dictionaryElements.append(jobitemsattachmentsElement.toDictionary())
            }
            dictionary["jobitemsattachments"] = dictionaryElements
        }
        if jobitemsbeforeinspections != nil{
            var dictionaryElements = [[String:Any]]()
            for jobitemsbeforeinspectionsElement in jobitemsbeforeinspections {
                dictionaryElements.append(jobitemsbeforeinspectionsElement.toDictionary())
            }
            dictionary["jobitemsbeforeinspections"] = dictionaryElements
        }
        if jobitemsmaterials != nil{
            var dictionaryElements = [[String:Any]]()
            for jobitemsmaterialsElement in jobitemsmaterials {
                dictionaryElements.append(jobitemsmaterialsElement.toDictionary())
            }
            dictionary["jobitemsmaterials"] = dictionaryElements
        }
        if jobservice != nil{
            dictionary["jobservice"] = jobservice.toDictionary()
        }
        if productId != nil{
            dictionary["product_id"] = productId
        }
        if quantity != nil{
            dictionary["quantity"] = quantity
        }
        if resolution1 != nil{
            dictionary["resolution_1"] = resolution1
        }
        if resolution2 != nil{
            dictionary["resolution_2"] = resolution2
        }
        if serviceId != nil{
            dictionary["service_id"] = serviceId
        }
        if sourceFrom != nil{
            dictionary["source_from"] = sourceFrom
        }
        if sourceInfo != nil{
            dictionary["source_info"] = sourceInfo
        }
        if sourceIp != nil{
            dictionary["source_ip"] = sourceIp
        }
        if status != nil{
            dictionary["status"] = status
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if updatedBy != nil{
            dictionary["updated_by"] = updatedBy
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        actualIssue1 = aDecoder.decodeObject(forKey: "actual_issue_1") as? String
        actualIssue2 = aDecoder.decodeObject(forKey: "actual_issue_2") as? String
        actualIssueId = aDecoder.decodeObject(forKey: "actual_issue_id") as? [String]
        actualServiceId = aDecoder.decodeObject(forKey: "actual_service_id") as? [String]
        appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
        categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
        commentAfterInspection = aDecoder.decodeObject(forKey: "comment_after_inspection") as? String
        commentBeforeInspection = aDecoder.decodeObject(forKey: "comment_before_inspection") as? String
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
        customerDescription = aDecoder.decodeObject(forKey: "customer_description") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        internalRemarks = aDecoder.decodeObject(forKey: "internal_remarks") as? String
        issueId = aDecoder.decodeObject(forKey: "issue_id") as? Int
        itemQuantity = aDecoder.decodeObject(forKey: "item_quantity") as? String
        itemUom = aDecoder.decodeObject(forKey: "item_uom") as? String
        items = aDecoder.decodeObject(forKey: "items") as? String
        jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
        jobcategory = aDecoder.decodeObject(forKey: "jobcategory") as? Jobcategory
        jobissue = aDecoder.decodeObject(forKey: "jobissue") as? Jobissue
        jobitemsafterinspections = aDecoder.decodeObject(forKey: "jobitemsafterinspections") as? [Jobitemsafterinspection]
        jobitemsattachments = aDecoder.decodeObject(forKey: "jobitemsattachments") as? [Jobattachment]
        jobitemsbeforeinspections = aDecoder.decodeObject(forKey: "jobitemsbeforeinspections") as? [Jobitemsbeforeinspection]
        jobitemsmaterials = aDecoder.decodeObject(forKey: "jobitemsmaterials") as? [JobIssueList]
        jobservice = aDecoder.decodeObject(forKey: "jobservice") as? Jobservice
        productId = aDecoder.decodeObject(forKey: "product_id") as? String
        quantity = aDecoder.decodeObject(forKey: "quantity") as? String
        resolution1 = aDecoder.decodeObject(forKey: "resolution_1") as? String
        resolution2 = aDecoder.decodeObject(forKey: "resolution_2") as? String
        serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
        sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
        sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
        sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
        
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if actualIssue1 != nil{
            aCoder.encode(actualIssue1, forKey: "actual_issue_1")
        }
        if actualIssue2 != nil{
            aCoder.encode(actualIssue2, forKey: "actual_issue_2")
        }
        if actualIssueId != nil{
            aCoder.encode(actualIssueId, forKey: "actual_issue_id")
        }
        if actualServiceId != nil{
            aCoder.encode(actualServiceId, forKey: "actual_service_id")
        }
        if appVersion != nil{
            aCoder.encode(appVersion, forKey: "app_version")
        }
        if categoryId != nil{
            aCoder.encode(categoryId, forKey: "category_id")
        }
        if commentAfterInspection != nil{
            aCoder.encode(commentAfterInspection, forKey: "comment_after_inspection")
        }
        if commentBeforeInspection != nil{
            aCoder.encode(commentBeforeInspection, forKey: "comment_before_inspection")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if customerDescription != nil{
            aCoder.encode(customerDescription, forKey: "customer_description")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if internalRemarks != nil{
            aCoder.encode(internalRemarks, forKey: "internal_remarks")
        }
        if issueId != nil{
            aCoder.encode(issueId, forKey: "issue_id")
        }
        if itemQuantity != nil{
            aCoder.encode(itemQuantity, forKey: "item_quantity")
        }
        if itemUom != nil{
            aCoder.encode(itemUom, forKey: "item_uom")
        }
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if jobRequestId != nil{
            aCoder.encode(jobRequestId, forKey: "job_request_id")
        }
        if jobcategory != nil{
            aCoder.encode(jobcategory, forKey: "jobcategory")
        }
        if jobissue != nil{
            aCoder.encode(jobissue, forKey: "jobissue")
        }
//        if jobitemsafterinspections != nil{
//            aCoder.encode(jobitemsafterinspections, forKey: "jobitemsafterinspections")
//        }
        if jobitemsattachments != nil{
            aCoder.encode(jobitemsattachments, forKey: "jobitemsattachments")
        }
        if jobitemsbeforeinspections != nil{
            aCoder.encode(jobitemsbeforeinspections, forKey: "jobitemsbeforeinspections")
        }
        if jobitemsmaterials != nil{
            aCoder.encode(jobitemsmaterials, forKey: "jobitemsmaterials")
        }
        if jobservice != nil{
            aCoder.encode(jobservice, forKey: "jobservice")
        }
        if productId != nil{
            aCoder.encode(productId, forKey: "product_id")
        }
        if quantity != nil{
            aCoder.encode(quantity, forKey: "quantity")
        }
        if resolution1 != nil{
            aCoder.encode(resolution1, forKey: "resolution_1")
        }
        if resolution2 != nil{
            aCoder.encode(resolution2, forKey: "resolution_2")
        }
        if serviceId != nil{
            aCoder.encode(serviceId, forKey: "service_id")
        }
        if sourceFrom != nil{
            aCoder.encode(sourceFrom, forKey: "source_from")
        }
        if sourceInfo != nil{
            aCoder.encode(sourceInfo, forKey: "source_info")
        }
        if sourceIp != nil{
            aCoder.encode(sourceIp, forKey: "source_ip")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if updatedBy != nil{
            aCoder.encode(updatedBy, forKey: "updated_by")
        }

    }

}
