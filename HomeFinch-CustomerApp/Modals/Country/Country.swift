//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Country : NSObject, NSCoding{

	var countryCode : String!
	var countryName : String!
	var createdAt : String!
	var currencyCode : String!
	var currencyName : String!
	var id : Int!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		countryCode = json["country_code"].stringValue
		countryName = json["country_name"].stringValue
		createdAt = json["created_at"].stringValue
		currencyCode = json["currency_code"].stringValue
		currencyName = json["currency_name"].stringValue
		id = json["id"].intValue
		updatedAt = json["updated_at"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if countryCode != nil{
			dictionary["country_code"] = countryCode
		}
		if countryName != nil{
			dictionary["country_name"] = countryName
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if currencyCode != nil{
			dictionary["currency_code"] = currencyCode
		}
		if currencyName != nil{
			dictionary["currency_name"] = currencyName
		}
		if id != nil{
			dictionary["id"] = id
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
         countryCode = aDecoder.decodeObject(forKey: "country_code") as? String
         countryName = aDecoder.decodeObject(forKey: "country_name") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         currencyName = aDecoder.decodeObject(forKey: "currency_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if countryCode != nil{
			aCoder.encode(countryCode, forKey: "country_code")
		}
		if countryName != nil{
			aCoder.encode(countryName, forKey: "country_name")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if currencyCode != nil{
			aCoder.encode(currencyCode, forKey: "currency_code")
		}
		if currencyName != nil{
			aCoder.encode(currencyName, forKey: "currency_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
