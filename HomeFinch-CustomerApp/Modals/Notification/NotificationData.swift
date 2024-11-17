//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class NotificationData : NSObject, NSCoding{

	var appVersion : String!
	var createdAt : String!
	var createdBy : String!
	var id : Int!
	var notification : Int!
	var referenceId : Int!
	var sourceFrom : Int!
	var sourceInfo : String!
	var sourceIp : String!
	var updatedAt : String!
	var updatedBy : String!
	var userType : Int!


    override init() {
        
    }
    
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		appVersion = json["app_version"].stringValue
		createdAt = json["created_at"].stringValue
		createdBy = json["created_by"].stringValue
		id = json["id"].intValue
		notification = json["notification"].intValue
		referenceId = json["reference_id"].intValue
		sourceFrom = json["source_from"].intValue
		sourceInfo = json["source_info"].stringValue
		sourceIp = json["source_ip"].stringValue
		updatedAt = json["updated_at"].stringValue
		updatedBy = json["updated_by"].stringValue
		userType = json["user_type"].intValue
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
		if id != nil{
			dictionary["id"] = id
		}
		if notification != nil{
			dictionary["notification"] = notification
		}
		if referenceId != nil{
			dictionary["reference_id"] = referenceId
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
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if updatedBy != nil{
			dictionary["updated_by"] = updatedBy
		}
		if userType != nil{
			dictionary["user_type"] = userType
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
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         notification = aDecoder.decodeObject(forKey: "notification") as? Int
         referenceId = aDecoder.decodeObject(forKey: "reference_id") as? Int
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         userType = aDecoder.decodeObject(forKey: "user_type") as? Int

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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if notification != nil{
			aCoder.encode(notification, forKey: "notification")
		}
		if referenceId != nil{
			aCoder.encode(referenceId, forKey: "reference_id")
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
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}
		if userType != nil{
			aCoder.encode(userType, forKey: "user_type")
		}

	}

}
