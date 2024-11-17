//
//	Jobotherservice.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobotherservice : NSObject, NSCoding{

	var createdAt : String!
	var createdBy : Int!
	var currencyCode : String!
	var discount : String!
	var discountPercentage : String!
	var goodwillPercentage : String!
	var id : Int!
	var isConsumable : Int!
	var jobRequestId : Int!
	var sapId : String!
	var serviceId : Int!
	var serviceName : String!
	var servicePrice : String!
	var serviceQuantity : Int!
	var serviceTotalPrice : String!
	var totalExcludeVat : String!
	var updatedAt : String!
	var updatedBy : Int!
	var vatPercentage : Int!
	var warrantyPercentage : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		createdBy = json["created_by"].intValue
		currencyCode = json["currency_code"].stringValue
		discount = json["discount"].stringValue
		discountPercentage = json["discount_percentage"].stringValue
		goodwillPercentage = json["goodwill_percentage"].stringValue
		id = json["id"].intValue
		isConsumable = json["is_consumable"].intValue
		jobRequestId = json["job_request_id"].intValue
		sapId = json["sap_id"].stringValue
		serviceId = json["service_id"].intValue
		serviceName = json["service_name"].stringValue
		servicePrice = json["service_price"].stringValue
		serviceQuantity = json["service_quantity"].intValue
		serviceTotalPrice = json["service_total_price"].stringValue
		totalExcludeVat = json["total_exclude_vat"].stringValue
		updatedAt = json["updated_at"].stringValue
		updatedBy = json["updated_by"].intValue
		vatPercentage = json["vat_percentage"].intValue
		warrantyPercentage = json["warranty_percentage"].stringValue
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
		if currencyCode != nil{
			dictionary["currency_code"] = currencyCode
		}
		if discount != nil{
			dictionary["discount"] = discount
		}
		if discountPercentage != nil{
			dictionary["discount_percentage"] = discountPercentage
		}
		if goodwillPercentage != nil{
			dictionary["goodwill_percentage"] = goodwillPercentage
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isConsumable != nil{
			dictionary["is_consumable"] = isConsumable
		}
		if jobRequestId != nil{
			dictionary["job_request_id"] = jobRequestId
		}
		if sapId != nil{
			dictionary["sap_id"] = sapId
		}
		if serviceId != nil{
			dictionary["service_id"] = serviceId
		}
		if serviceName != nil{
			dictionary["service_name"] = serviceName
		}
		if servicePrice != nil{
			dictionary["service_price"] = servicePrice
		}
		if serviceQuantity != nil{
			dictionary["service_quantity"] = serviceQuantity
		}
		if serviceTotalPrice != nil{
			dictionary["service_total_price"] = serviceTotalPrice
		}
		if totalExcludeVat != nil{
			dictionary["total_exclude_vat"] = totalExcludeVat
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if updatedBy != nil{
			dictionary["updated_by"] = updatedBy
		}
		if vatPercentage != nil{
			dictionary["vat_percentage"] = vatPercentage
		}
		if warrantyPercentage != nil{
			dictionary["warranty_percentage"] = warrantyPercentage
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
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         discount = aDecoder.decodeObject(forKey: "discount") as? String
         discountPercentage = aDecoder.decodeObject(forKey: "discount_percentage") as? String
         goodwillPercentage = aDecoder.decodeObject(forKey: "goodwill_percentage") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isConsumable = aDecoder.decodeObject(forKey: "is_consumable") as? Int
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
         serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
         serviceName = aDecoder.decodeObject(forKey: "service_name") as? String
         servicePrice = aDecoder.decodeObject(forKey: "service_price") as? String
         serviceQuantity = aDecoder.decodeObject(forKey: "service_quantity") as? Int
         serviceTotalPrice = aDecoder.decodeObject(forKey: "service_total_price") as? String
         totalExcludeVat = aDecoder.decodeObject(forKey: "total_exclude_vat") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? Int
         vatPercentage = aDecoder.decodeObject(forKey: "vat_percentage") as? Int
         warrantyPercentage = aDecoder.decodeObject(forKey: "warranty_percentage") as? String

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
		if currencyCode != nil{
			aCoder.encode(currencyCode, forKey: "currency_code")
		}
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if discountPercentage != nil{
			aCoder.encode(discountPercentage, forKey: "discount_percentage")
		}
		if goodwillPercentage != nil{
			aCoder.encode(goodwillPercentage, forKey: "goodwill_percentage")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isConsumable != nil{
			aCoder.encode(isConsumable, forKey: "is_consumable")
		}
		if jobRequestId != nil{
			aCoder.encode(jobRequestId, forKey: "job_request_id")
		}
		if sapId != nil{
			aCoder.encode(sapId, forKey: "sap_id")
		}
		if serviceId != nil{
			aCoder.encode(serviceId, forKey: "service_id")
		}
		if serviceName != nil{
			aCoder.encode(serviceName, forKey: "service_name")
		}
		if servicePrice != nil{
			aCoder.encode(servicePrice, forKey: "service_price")
		}
		if serviceQuantity != nil{
			aCoder.encode(serviceQuantity, forKey: "service_quantity")
		}
		if serviceTotalPrice != nil{
			aCoder.encode(serviceTotalPrice, forKey: "service_total_price")
		}
		if totalExcludeVat != nil{
			aCoder.encode(totalExcludeVat, forKey: "total_exclude_vat")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}
		if vatPercentage != nil{
			aCoder.encode(vatPercentage, forKey: "vat_percentage")
		}
		if warrantyPercentage != nil{
			aCoder.encode(warrantyPercentage, forKey: "warranty_percentage")
		}

	}

}
