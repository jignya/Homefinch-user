//
//	Jobattachment.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobattachment : NSObject, NSCoding{

	var createdAt : String!
	var createdBy : Int!
	var id : Int!
	var jobRequestId : Int!
	var jobRequestItemId : Int!
	var name : String!
	var path : String!
	var updatedAt : String!
	var updatedBy : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		createdBy = json["created_by"].intValue
		id = json["id"].intValue
		jobRequestId = json["job_request_id"].intValue
		jobRequestItemId = json["job_request_item_id"].intValue
		name = json["name"].stringValue
		path = json["path"].stringValue
		updatedAt = json["updated_at"].stringValue
		updatedBy = json["updated_by"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if createdBy != nil{
			dictionary["created_by"] = createdBy
		}
		if id != nil{
			dictionary["id"] = id
		}
		if jobRequestId != nil{
			dictionary["job_request_id"] = jobRequestId
		}
		if jobRequestItemId != nil{
			dictionary["job_request_item_id"] = jobRequestItemId
		}
		if name != nil{
			dictionary["name"] = name
		}
		if path != nil{
			dictionary["path"] = path
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         jobRequestItemId = aDecoder.decodeObject(forKey: "job_request_item_id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         path = aDecoder.decodeObject(forKey: "path") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "created_by")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if jobRequestId != nil{
			aCoder.encode(jobRequestId, forKey: "job_request_id")
		}
		if jobRequestItemId != nil{
			aCoder.encode(jobRequestItemId, forKey: "job_request_item_id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if path != nil{
			aCoder.encode(path, forKey: "path")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}

	}

}
