//
//	Stub.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Stub : NSObject, NSCoding{

	var amount : String!
	var date : String!
	var descriptionField : String!
	var humanDate : String!
	var partUuid : String!
	var refId : String!
	var type : String!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		amount = json["amount"].stringValue
		date = json["date"].stringValue
		descriptionField = json["description"].stringValue
		humanDate = json["human_date"].stringValue
		partUuid = json["part_uuid"].stringValue
		refId = json["ref_id"].stringValue
		type = json["type"].stringValue
		typeId = json["type_id"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if amount != nil{
			dictionary["amount"] = amount
		}
		if date != nil{
			dictionary["date"] = date
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if humanDate != nil{
			dictionary["human_date"] = humanDate
		}
		if partUuid != nil{
			dictionary["part_uuid"] = partUuid
		}
		if refId != nil{
			dictionary["ref_id"] = refId
		}
		if type != nil{
			dictionary["type"] = type
		}
		if typeId != nil{
			dictionary["type_id"] = typeId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         amount = aDecoder.decodeObject(forKey: "amount") as? String
         date = aDecoder.decodeObject(forKey: "date") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         humanDate = aDecoder.decodeObject(forKey: "human_date") as? String
         partUuid = aDecoder.decodeObject(forKey: "part_uuid") as? String
         refId = aDecoder.decodeObject(forKey: "ref_id") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         typeId = aDecoder.decodeObject(forKey: "type_id") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if amount != nil{
			aCoder.encode(amount, forKey: "amount")
		}
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if humanDate != nil{
			aCoder.encode(humanDate, forKey: "human_date")
		}
		if partUuid != nil{
			aCoder.encode(partUuid, forKey: "part_uuid")
		}
		if refId != nil{
			aCoder.encode(refId, forKey: "ref_id")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if typeId != nil{
			aCoder.encode(typeId, forKey: "type_id")
		}

	}

}