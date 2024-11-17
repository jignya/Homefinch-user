//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class CategoryIssueList : NSObject, NSCoding{
    
    var category : Category!
    var categoryId : Int!
    var id : Int!
    var issueDescription : String!
    var issueIdSap : String!
    var issueType : Int!
    var service : Service!
    var serviceId : Int!
    var image : String!

    
    override init() {
        
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let categoryJson = json["category"]
        if !categoryJson.isEmpty{
            category = Category(fromJson: categoryJson)
        }
        categoryId = json["category_id"].intValue
        id = json["id"].intValue
        issueDescription = json["issue_description"].stringValue
        issueIdSap = json["issue_id_sap"].stringValue
        issueType = json["issue_type"].intValue
        let serviceJson = json["service"]
        if !serviceJson.isEmpty{
            service = Service(fromJson: serviceJson)
        }
        serviceId = json["service_id"].intValue
        image = json["image"].stringValue

    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if categoryId != nil{
            dictionary["category_id"] = categoryId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if issueDescription != nil{
            dictionary["issue_description"] = issueDescription
        }
        if issueIdSap != nil{
            dictionary["issue_id_sap"] = issueIdSap
        }
        if issueType != nil{
            dictionary["issue_type"] = issueType
        }
        if service != nil{
            dictionary["service"] = service.toDictionary()
        }
        if serviceId != nil{
            dictionary["service_id"] = serviceId
        }
        if image != nil{
            dictionary["image"] = image
        }

        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         category = aDecoder.decodeObject(forKey: "category") as? Category
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         issueDescription = aDecoder.decodeObject(forKey: "issue_description") as? String
         issueIdSap = aDecoder.decodeObject(forKey: "issue_id_sap") as? String
         issueType = aDecoder.decodeObject(forKey: "issue_type") as? Int
         service = aDecoder.decodeObject(forKey: "service") as? Service
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if categoryId != nil{
            aCoder.encode(categoryId, forKey: "category_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if issueDescription != nil{
            aCoder.encode(issueDescription, forKey: "issue_description")
        }
        if issueIdSap != nil{
            aCoder.encode(issueIdSap, forKey: "issue_id_sap")
        }
        if issueType != nil{
            aCoder.encode(issueType, forKey: "issue_type")
        }
        if service != nil{
            aCoder.encode(service, forKey: "service")
        }
        if serviceId != nil{
            aCoder.encode(serviceId, forKey: "service_id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }

    }

}
