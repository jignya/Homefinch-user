//
//	Jobissue.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobissue : NSObject, NSCoding{

	var categoryId : Int!
	var createdAt : String!
	var id : Int!
	var issueDescription : String!
	var issueIdSap : String!
	var issueType : Int!
	var serviceId : Int!
	var status : Int!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		categoryId = json["category_id"].intValue
		createdAt = json["created_at"].stringValue
		id = json["id"].intValue
		issueDescription = json["issue_description"].stringValue
		issueIdSap = json["issue_id_sap"].stringValue
		issueType = json["issue_type"].intValue
		serviceId = json["service_id"].intValue
		status = json["status"].intValue
		updatedAt = json["updated_at"].stringValue
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
		if createdAt != nil{
			dictionary["created_at"] = createdAt
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
		if serviceId != nil{
			dictionary["service_id"] = serviceId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         issueDescription = aDecoder.decodeObject(forKey: "issue_description") as? String
         issueIdSap = aDecoder.decodeObject(forKey: "issue_id_sap") as? String
         issueType = aDecoder.decodeObject(forKey: "issue_type") as? Int
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
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
		if serviceId != nil{
			aCoder.encode(serviceId, forKey: "service_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}