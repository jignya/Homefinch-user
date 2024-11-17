//
//	Material.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Material : NSObject, NSCoding{

	var categoryName : String!
	var createdAt : String!
	var currencyCode : String!
	var descriptionField : String!
	var id : Int!
	var installationDescription : String!
	var mainImagePath : String!
	var modelNo : String!
	var name : String!
	var parentCategoryName : String!
	var price : String!
	var sapId : String!
	var status : Int!
	var totalStock : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		categoryName = json["category_name"].stringValue
		createdAt = json["created_at"].stringValue
		currencyCode = json["currency_code"].stringValue
		descriptionField = json["description"].stringValue
		id = json["id"].intValue
		installationDescription = json["installation_description"].stringValue
		mainImagePath = json["main_image_path"].stringValue
		modelNo = json["model_no"].stringValue
		name = json["name"].stringValue
		parentCategoryName = json["parent_category_name"].stringValue
		price = json["price"].stringValue
		sapId = json["sap_id"].stringValue
		status = json["status"].intValue
		totalStock = json["total_stock"].stringValue
		updatedAt = json["updated_at"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categoryName != nil{
			dictionary["category_name"] = categoryName
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if currencyCode != nil{
			dictionary["currency_code"] = currencyCode
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if id != nil{
			dictionary["id"] = id
		}
		if installationDescription != nil{
			dictionary["installation_description"] = installationDescription
		}
		if mainImagePath != nil{
			dictionary["main_image_path"] = mainImagePath
		}
		if modelNo != nil{
			dictionary["model_no"] = modelNo
		}
		if name != nil{
			dictionary["name"] = name
		}
		if parentCategoryName != nil{
			dictionary["parent_category_name"] = parentCategoryName
		}
		if price != nil{
			dictionary["price"] = price
		}
		if sapId != nil{
			dictionary["sap_id"] = sapId
		}
		if status != nil{
			dictionary["status"] = status
		}
		if totalStock != nil{
			dictionary["total_stock"] = totalStock
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
         categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         installationDescription = aDecoder.decodeObject(forKey: "installation_description") as? String
         mainImagePath = aDecoder.decodeObject(forKey: "main_image_path") as? String
         modelNo = aDecoder.decodeObject(forKey: "model_no") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         parentCategoryName = aDecoder.decodeObject(forKey: "parent_category_name") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         totalStock = aDecoder.decodeObject(forKey: "total_stock") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if categoryName != nil{
			aCoder.encode(categoryName, forKey: "category_name")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if currencyCode != nil{
			aCoder.encode(currencyCode, forKey: "currency_code")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if installationDescription != nil{
			aCoder.encode(installationDescription, forKey: "installation_description")
		}
		if mainImagePath != nil{
			aCoder.encode(mainImagePath, forKey: "main_image_path")
		}
		if modelNo != nil{
			aCoder.encode(modelNo, forKey: "model_no")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if parentCategoryName != nil{
			aCoder.encode(parentCategoryName, forKey: "parent_category_name")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if sapId != nil{
			aCoder.encode(sapId, forKey: "sap_id")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if totalStock != nil{
			aCoder.encode(totalStock, forKey: "total_stock")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
