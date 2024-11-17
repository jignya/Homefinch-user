//
//	JobQuotationData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class JobQuotationData : NSObject, NSCoding{

	var currencyCode : String!
	var jobRequestItemData : JobRequestItemData!
	var serviceData : [ServiceData]!
	var sum : Int!
    
    var isExpand : Int = 0
    var isSelected : Int = 1

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		currencyCode = json["currency_code"].stringValue
		let jobRequestItemDataJson = json["job_request_item_data"]
		if !jobRequestItemDataJson.isEmpty{
			jobRequestItemData = JobRequestItemData(fromJson: jobRequestItemDataJson)
		}
		serviceData = [ServiceData]()
		let serviceDataArray = json["service_data"].arrayValue
		for serviceDataJson in serviceDataArray{
			let value = ServiceData(fromJson: serviceDataJson)
			serviceData.append(value)
		}
		sum = json["sum"].intValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if currencyCode != nil{
			dictionary["currency_code"] = currencyCode
		}
		if jobRequestItemData != nil{
			dictionary["job_request_item_data"] = jobRequestItemData.toDictionary()
		}
		if serviceData != nil{
			var dictionaryElements = [[String:Any]]()
			for serviceDataElement in serviceData {
				dictionaryElements.append(serviceDataElement.toDictionary())
			}
			dictionary["service_data"] = dictionaryElements
		}
		if sum != nil{
			dictionary["sum"] = sum
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         jobRequestItemData = aDecoder.decodeObject(forKey: "job_request_item_data") as? JobRequestItemData
         serviceData = aDecoder.decodeObject(forKey: "service_data") as? [ServiceData]
         sum = aDecoder.decodeObject(forKey: "sum") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if currencyCode != nil{
			aCoder.encode(currencyCode, forKey: "currency_code")
		}
		if jobRequestItemData != nil{
			aCoder.encode(jobRequestItemData, forKey: "job_request_item_data")
		}
		if serviceData != nil{
			aCoder.encode(serviceData, forKey: "service_data")
		}
		if sum != nil{
			aCoder.encode(sum, forKey: "sum")
		}

	}

}
