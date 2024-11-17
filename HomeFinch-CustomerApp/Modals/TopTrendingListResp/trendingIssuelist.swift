//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class trendingIssuelist : NSObject, NSCoding{
    
    var categoryId : Int!
    var categoryImage : String!
    var categoryName : String!
    var issueCount : Int!
    var issueDescription : String!
    var issueId : Int!
    var issueIdSap : String!
    var issueType : Int!
    var serviceDescription : String!
    var serviceId : Int!
    var serviceIdSap : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categoryId = json["category_id"].intValue
        categoryImage = json["category_image"].stringValue
        categoryName = json["category_name"].stringValue
        issueCount = json["issue_count"].intValue
        issueDescription = json["issue_description"].stringValue
        issueId = json["issue_id"].intValue
        issueIdSap = json["issue_id_sap"].stringValue
        issueType = json["issue_type"].intValue
        serviceDescription = json["service_description"].stringValue
        serviceId = json["service_id"].intValue
        serviceIdSap = json["service_id_sap"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if categoryId != nil{
            dictionary["category_id"] = categoryId
        }
        if categoryImage != nil{
            dictionary["category_image"] = categoryImage
        }
        if categoryName != nil{
            dictionary["category_name"] = categoryName
        }
        if issueCount != nil{
            dictionary["issue_count"] = issueCount
        }
        if issueDescription != nil{
            dictionary["issue_description"] = issueDescription
        }
        if issueId != nil{
            dictionary["issue_id"] = issueId
        }
        if issueIdSap != nil{
            dictionary["issue_id_sap"] = issueIdSap
        }
        if issueType != nil{
            dictionary["issue_type"] = issueType
        }
        if serviceDescription != nil{
            dictionary["service_description"] = serviceDescription
        }
        if serviceId != nil{
            dictionary["service_id"] = serviceId
        }
        if serviceIdSap != nil{
            dictionary["service_id_sap"] = serviceIdSap
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
         categoryImage = aDecoder.decodeObject(forKey: "category_image") as? String
         categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
         issueCount = aDecoder.decodeObject(forKey: "issue_count") as? Int
         issueDescription = aDecoder.decodeObject(forKey: "issue_description") as? String
         issueId = aDecoder.decodeObject(forKey: "issue_id") as? Int
         issueIdSap = aDecoder.decodeObject(forKey: "issue_id_sap") as? String
         issueType = aDecoder.decodeObject(forKey: "issue_type") as? Int
         serviceDescription = aDecoder.decodeObject(forKey: "service_description") as? String
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
         serviceIdSap = aDecoder.decodeObject(forKey: "service_id_sap") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if categoryId != nil{
            aCoder.encode(categoryId, forKey: "category_id")
        }
        if categoryImage != nil{
            aCoder.encode(categoryImage, forKey: "category_image")
        }
        if categoryName != nil{
            aCoder.encode(categoryName, forKey: "category_name")
        }
        if issueCount != nil{
            aCoder.encode(issueCount, forKey: "issue_count")
        }
        if issueDescription != nil{
            aCoder.encode(issueDescription, forKey: "issue_description")
        }
        if issueId != nil{
            aCoder.encode(issueId, forKey: "issue_id")
        }
        if issueIdSap != nil{
            aCoder.encode(issueIdSap, forKey: "issue_id_sap")
        }
        if issueType != nil{
            aCoder.encode(issueType, forKey: "issue_type")
        }
        if serviceDescription != nil{
            aCoder.encode(serviceDescription, forKey: "service_description")
        }
        if serviceId != nil{
            aCoder.encode(serviceId, forKey: "service_id")
        }
        if serviceIdSap != nil{
            aCoder.encode(serviceIdSap, forKey: "service_id_sap")
        }

    }

}
