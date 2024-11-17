//
//	Location.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class SULocation : NSObject, NSCoding{

	var createdAt : String!
	var geofenceId : String!
	var id : Int!
	var name : String!
	var sapId : String!
	var status : String!
	var tag : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		geofenceId = json["geofence_id"].stringValue
		id = json["id"].intValue
		name = json["name"].stringValue
		sapId = json["sap_id"].stringValue
		status = json["status"].stringValue
		tag = json["tag"].stringValue
		updatedAt = json["updated_at"].stringValue
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
		if geofenceId != nil{
			dictionary["geofence_id"] = geofenceId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if sapId != nil{
			dictionary["sap_id"] = sapId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if tag != nil{
			dictionary["tag"] = tag
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
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         geofenceId = aDecoder.decodeObject(forKey: "geofence_id") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         tag = aDecoder.decodeObject(forKey: "tag") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

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
		if geofenceId != nil{
			aCoder.encode(geofenceId, forKey: "geofence_id")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if sapId != nil{
			aCoder.encode(sapId, forKey: "sap_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
