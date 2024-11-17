//
//	Jobitemsafterinspection.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobitemsafterinspection : NSObject, NSCoding{

	var appVersion : String!
	var createdAt : String!
	var createdBy : Int!
	var filePath : String!
	var id : Int!
	var jobRequestId : Int!
	var jobRequestItemId : Int!
	var sourceFrom : Int!
	var sourceInfo : String!
	var sourceIp : String!
	var type : Int!
	var updatedAt : String!
	var updatedBy : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		appVersion = json["app_version"].stringValue
		createdAt = json["created_at"].stringValue
		createdBy = json["created_by"].intValue
		filePath = json["file_path"].stringValue
		id = json["id"].intValue
		jobRequestId = json["job_request_id"].intValue
		jobRequestItemId = json["job_request_item_id"].intValue
		sourceFrom = json["source_from"].intValue
		sourceInfo = json["source_info"].stringValue
		sourceIp = json["source_ip"].stringValue
		type = json["type"].intValue
		updatedAt = json["updated_at"].stringValue
		updatedBy = json["updated_by"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if appVersion != nil{
			dictionary["app_version"] = appVersion
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if createdBy != nil{
			dictionary["created_by"] = createdBy
		}
		if filePath != nil{
			dictionary["file_path"] = filePath
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
		if sourceFrom != nil{
			dictionary["source_from"] = sourceFrom
		}
		if sourceInfo != nil{
			dictionary["source_info"] = sourceInfo
		}
		if sourceIp != nil{
			dictionary["source_ip"] = sourceIp
		}
		if type != nil{
			dictionary["type"] = type
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
         appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
         filePath = aDecoder.decodeObject(forKey: "file_path") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         jobRequestItemId = aDecoder.decodeObject(forKey: "job_request_item_id") as? Int
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         type = aDecoder.decodeObject(forKey: "type") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if appVersion != nil{
			aCoder.encode(appVersion, forKey: "app_version")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "created_by")
		}
		if filePath != nil{
			aCoder.encode(filePath, forKey: "file_path")
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
		if sourceFrom != nil{
			aCoder.encode(sourceFrom, forKey: "source_from")
		}
		if sourceInfo != nil{
			aCoder.encode(sourceInfo, forKey: "source_info")
		}
		if sourceIp != nil{
			aCoder.encode(sourceIp, forKey: "source_ip")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}

	}

}
