//
//	ServiceUnit.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ServiceUnit : NSObject, NSCoding{

	var createdAt : String!
	var id : Int!
	var name : String!
	var qty : Int!
	var sapId : String!
	var status : String!
	var updatedAt : String!
	var vehicleMake : String!
	var vehicleModel : String!
	var vehicleRegistrationNumber : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		id = json["id"].intValue
		name = json["name"].stringValue
		qty = json["qty"].intValue
		sapId = json["sap_id"].stringValue
		status = json["status"].stringValue
		updatedAt = json["updated_at"].stringValue
		vehicleMake = json["vehicle_make"].stringValue
		vehicleModel = json["vehicle_model"].stringValue
		vehicleRegistrationNumber = json["vehicle_registration_number"].stringValue
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
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if qty != nil{
			dictionary["qty"] = qty
		}
		if sapId != nil{
			dictionary["sap_id"] = sapId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if vehicleMake != nil{
			dictionary["vehicle_make"] = vehicleMake
		}
		if vehicleModel != nil{
			dictionary["vehicle_model"] = vehicleModel
		}
		if vehicleRegistrationNumber != nil{
			dictionary["vehicle_registration_number"] = vehicleRegistrationNumber
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         qty = aDecoder.decodeObject(forKey: "qty") as? Int
         sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         vehicleMake = aDecoder.decodeObject(forKey: "vehicle_make") as? String
         vehicleModel = aDecoder.decodeObject(forKey: "vehicle_model") as? String
         vehicleRegistrationNumber = aDecoder.decodeObject(forKey: "vehicle_registration_number") as? String

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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if qty != nil{
			aCoder.encode(qty, forKey: "qty")
		}
		if sapId != nil{
			aCoder.encode(sapId, forKey: "sap_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if vehicleMake != nil{
			aCoder.encode(vehicleMake, forKey: "vehicle_make")
		}
		if vehicleModel != nil{
			aCoder.encode(vehicleModel, forKey: "vehicle_model")
		}
		if vehicleRegistrationNumber != nil{
			aCoder.encode(vehicleRegistrationNumber, forKey: "vehicle_registration_number")
		}

	}

}
