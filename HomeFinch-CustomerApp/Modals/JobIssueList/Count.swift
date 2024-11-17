//
//	Count.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Count : NSObject, NSCoding{

	var customerCount : Int!
	var customerTotalCount : Int!
	var propertyCount : Int!
	var propertyTotalCount : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		customerCount = json["customer_count"].intValue
		customerTotalCount = json["customer_total_count"].intValue
		propertyCount = json["property_count"].intValue
		propertyTotalCount = json["property_total_count"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if customerCount != nil{
			dictionary["customer_count"] = customerCount
		}
		if customerTotalCount != nil{
			dictionary["customer_total_count"] = customerTotalCount
		}
		if propertyCount != nil{
			dictionary["property_count"] = propertyCount
		}
		if propertyTotalCount != nil{
			dictionary["property_total_count"] = propertyTotalCount
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         customerCount = aDecoder.decodeObject(forKey: "customer_count") as? Int
         customerTotalCount = aDecoder.decodeObject(forKey: "customer_total_count") as? Int
         propertyCount = aDecoder.decodeObject(forKey: "property_count") as? Int
         propertyTotalCount = aDecoder.decodeObject(forKey: "property_total_count") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if customerCount != nil{
			aCoder.encode(customerCount, forKey: "customer_count")
		}
		if customerTotalCount != nil{
			aCoder.encode(customerTotalCount, forKey: "customer_total_count")
		}
		if propertyCount != nil{
			aCoder.encode(propertyCount, forKey: "property_count")
		}
		if propertyTotalCount != nil{
			aCoder.encode(propertyTotalCount, forKey: "property_total_count")
		}

	}

}