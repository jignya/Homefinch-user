//
//	RequestedMaterial.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RequestedMaterial : NSObject, NSCoding{

	var appVersion : String!
	var createdAt : String!
	var createdBy : Int!
	var deliveryDatetime : String!
	var deliveryPriority : String!
	var fromEmp : [FromEmp]!
	var fromEmpId : Int!
	var fromEmpName : String!
	var id : Int!
	var items : String!
	var jobRequestId : Int!
	var material : Material!
	var product : [Product]!
	var productId : Int!
	var requestedDatetime : String!
	var requestedQuantity : Int!
	var shipFromSiteId : String!
	var shipFromSiteName : String!
	var shipToLocationId : String!
	var shipToLocationName : String!
	var shipToSiteId : String!
	var shipToSiteName : String!
	var sourceFrom : Int!
	var sourceInfo : String!
	var sourceIp : String!
	var status : Int!
	var toEmp : [FromEmp]!
	var toEmpId : Int!
	var toEmpName : String!
	var updatedAt : String!
	var updatedBy : Int!


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
		deliveryDatetime = json["delivery_datetime"].stringValue
		deliveryPriority = json["delivery_priority"].stringValue
		fromEmp = [FromEmp]()
		let fromEmpArray = json["from_emp"].arrayValue
		for fromEmpJson in fromEmpArray{
			let value = FromEmp(fromJson: fromEmpJson)
			fromEmp.append(value)
		}
		fromEmpId = json["from_emp_id"].intValue
		fromEmpName = json["from_emp_name"].stringValue
		id = json["id"].intValue
		items = json["items"].stringValue
		jobRequestId = json["job_request_id"].intValue
		let materialJson = json["material"]
		if !materialJson.isEmpty{
			material = Material(fromJson: materialJson)
		}
		product = [Product]()
		let productArray = json["product"].arrayValue
		for productJson in productArray{
			let value = Product(fromJson: productJson)
			product.append(value)
		}
		productId = json["product_id"].intValue
		requestedDatetime = json["requested_datetime"].stringValue
		requestedQuantity = json["requested_quantity"].intValue
		shipFromSiteId = json["ship_from_site_id"].stringValue
		shipFromSiteName = json["ship_from_site_name"].stringValue
		shipToLocationId = json["ship_to_location_id"].stringValue
		shipToLocationName = json["ship_to_location_name"].stringValue
		shipToSiteId = json["ship_to_site_id"].stringValue
		shipToSiteName = json["ship_to_site_name"].stringValue
		sourceFrom = json["source_from"].intValue
		sourceInfo = json["source_info"].stringValue
		sourceIp = json["source_ip"].stringValue
		status = json["status"].intValue
		toEmp = [FromEmp]()
		let toEmpArray = json["to_emp"].arrayValue
		for toEmpJson in toEmpArray{
			let value = FromEmp(fromJson: toEmpJson)
			toEmp.append(value)
		}
		toEmpId = json["to_emp_id"].intValue
		toEmpName = json["to_emp_name"].stringValue
		updatedAt = json["updated_at"].stringValue
		updatedBy = json["updated_by"].intValue
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
		if deliveryDatetime != nil{
			dictionary["delivery_datetime"] = deliveryDatetime
		}
		if deliveryPriority != nil{
			dictionary["delivery_priority"] = deliveryPriority
		}
		if fromEmp != nil{
			var dictionaryElements = [[String:Any]]()
			for fromEmpElement in fromEmp {
				dictionaryElements.append(fromEmpElement.toDictionary())
			}
			dictionary["from_emp"] = dictionaryElements
		}
		if fromEmpId != nil{
			dictionary["from_emp_id"] = fromEmpId
		}
		if fromEmpName != nil{
			dictionary["from_emp_name"] = fromEmpName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if items != nil{
			dictionary["items"] = items
		}
		if jobRequestId != nil{
			dictionary["job_request_id"] = jobRequestId
		}
		if material != nil{
			dictionary["material"] = material.toDictionary()
		}
		if product != nil{
			var dictionaryElements = [[String:Any]]()
			for productElement in product {
				dictionaryElements.append(productElement.toDictionary())
			}
			dictionary["product"] = dictionaryElements
		}
		if productId != nil{
			dictionary["product_id"] = productId
		}
		if requestedDatetime != nil{
			dictionary["requested_datetime"] = requestedDatetime
		}
		if requestedQuantity != nil{
			dictionary["requested_quantity"] = requestedQuantity
		}
		if shipFromSiteId != nil{
			dictionary["ship_from_site_id"] = shipFromSiteId
		}
		if shipFromSiteName != nil{
			dictionary["ship_from_site_name"] = shipFromSiteName
		}
		if shipToLocationId != nil{
			dictionary["ship_to_location_id"] = shipToLocationId
		}
		if shipToLocationName != nil{
			dictionary["ship_to_location_name"] = shipToLocationName
		}
		if shipToSiteId != nil{
			dictionary["ship_to_site_id"] = shipToSiteId
		}
		if shipToSiteName != nil{
			dictionary["ship_to_site_name"] = shipToSiteName
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
		if status != nil{
			dictionary["status"] = status
		}
		if toEmp != nil{
			var dictionaryElements = [[String:Any]]()
			for toEmpElement in toEmp {
				dictionaryElements.append(toEmpElement.toDictionary())
			}
			dictionary["to_emp"] = dictionaryElements
		}
		if toEmpId != nil{
			dictionary["to_emp_id"] = toEmpId
		}
		if toEmpName != nil{
			dictionary["to_emp_name"] = toEmpName
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
         deliveryDatetime = aDecoder.decodeObject(forKey: "delivery_datetime") as? String
         deliveryPriority = aDecoder.decodeObject(forKey: "delivery_priority") as? String
         fromEmp = aDecoder.decodeObject(forKey: "from_emp") as? [FromEmp]
         fromEmpId = aDecoder.decodeObject(forKey: "from_emp_id") as? Int
         fromEmpName = aDecoder.decodeObject(forKey: "from_emp_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         items = aDecoder.decodeObject(forKey: "items") as? String
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         material = aDecoder.decodeObject(forKey: "material") as? Material
         product = aDecoder.decodeObject(forKey: "product") as? [Product]
         productId = aDecoder.decodeObject(forKey: "product_id") as? Int
         requestedDatetime = aDecoder.decodeObject(forKey: "requested_datetime") as? String
         requestedQuantity = aDecoder.decodeObject(forKey: "requested_quantity") as? Int
         shipFromSiteId = aDecoder.decodeObject(forKey: "ship_from_site_id") as? String
         shipFromSiteName = aDecoder.decodeObject(forKey: "ship_from_site_name") as? String
         shipToLocationId = aDecoder.decodeObject(forKey: "ship_to_location_id") as? String
         shipToLocationName = aDecoder.decodeObject(forKey: "ship_to_location_name") as? String
         shipToSiteId = aDecoder.decodeObject(forKey: "ship_to_site_id") as? String
         shipToSiteName = aDecoder.decodeObject(forKey: "ship_to_site_name") as? String
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         toEmp = aDecoder.decodeObject(forKey: "to_emp") as? [FromEmp]
         toEmpId = aDecoder.decodeObject(forKey: "to_emp_id") as? Int
         toEmpName = aDecoder.decodeObject(forKey: "to_emp_name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? Int

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
		if deliveryDatetime != nil{
			aCoder.encode(deliveryDatetime, forKey: "delivery_datetime")
		}
		if deliveryPriority != nil{
			aCoder.encode(deliveryPriority, forKey: "delivery_priority")
		}
		if fromEmp != nil{
			aCoder.encode(fromEmp, forKey: "from_emp")
		}
		if fromEmpId != nil{
			aCoder.encode(fromEmpId, forKey: "from_emp_id")
		}
		if fromEmpName != nil{
			aCoder.encode(fromEmpName, forKey: "from_emp_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if items != nil{
			aCoder.encode(items, forKey: "items")
		}
		if jobRequestId != nil{
			aCoder.encode(jobRequestId, forKey: "job_request_id")
		}
		if material != nil{
			aCoder.encode(material, forKey: "material")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if requestedDatetime != nil{
			aCoder.encode(requestedDatetime, forKey: "requested_datetime")
		}
		if requestedQuantity != nil{
			aCoder.encode(requestedQuantity, forKey: "requested_quantity")
		}
		if shipFromSiteId != nil{
			aCoder.encode(shipFromSiteId, forKey: "ship_from_site_id")
		}
		if shipFromSiteName != nil{
			aCoder.encode(shipFromSiteName, forKey: "ship_from_site_name")
		}
		if shipToLocationId != nil{
			aCoder.encode(shipToLocationId, forKey: "ship_to_location_id")
		}
		if shipToLocationName != nil{
			aCoder.encode(shipToLocationName, forKey: "ship_to_location_name")
		}
		if shipToSiteId != nil{
			aCoder.encode(shipToSiteId, forKey: "ship_to_site_id")
		}
		if shipToSiteName != nil{
			aCoder.encode(shipToSiteName, forKey: "ship_to_site_name")
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
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if toEmp != nil{
			aCoder.encode(toEmp, forKey: "to_emp")
		}
		if toEmpId != nil{
			aCoder.encode(toEmpId, forKey: "to_emp_id")
		}
		if toEmpName != nil{
			aCoder.encode(toEmpName, forKey: "to_emp_name")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if updatedBy != nil{
			aCoder.encode(updatedBy, forKey: "updated_by")
		}

	}

}
