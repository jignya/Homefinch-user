//
//	Jobitemsmaterial.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobitemsmaterial : NSObject, NSCoding{
    
    var createdAt : String!
    var createdBy : Int!
    var currencyCode : String!
    var discount : String!
    var discountPercentage : String!
    var goodwillPercentage : String!
    var id : Int!
    var jobRequestId : Int!
    var jobRequestItemId : Int!
    var materialName : String!
    var materialPrice : String!
    var materialQuantity : Int!
    var materialTotalPrice : String!
    var recommended : Int!
    var referenceId : Int!
    var serviceId : Int!
    var type : Int!
    var updatedAt : String!
    var updatedBy : String!
    var vatPercentage : Int!
    var warrantyEndDate : String!
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
        jobRequestId = json["job_request_id"].intValue
        jobRequestItemId = json["job_request_item_id"].intValue
        materialName = json["material_name"].stringValue
        materialPrice = json["material_price"].stringValue
        materialQuantity = json["material_quantity"].intValue
        materialTotalPrice = json["material_total_price"].stringValue
        recommended = json["recommended"].intValue
        referenceId = json["reference_id"].intValue
        serviceId = json["service_id"].intValue
        type = json["type"].intValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
        vatPercentage = json["vat_percentage"].intValue
        warrantyEndDate = json["warranty_end_date"].stringValue
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
        if jobRequestId != nil{
            dictionary["job_request_id"] = jobRequestId
        }
        if jobRequestItemId != nil{
            dictionary["job_request_item_id"] = jobRequestItemId
        }
        if materialName != nil{
            dictionary["material_name"] = materialName
        }
        if materialPrice != nil{
            dictionary["material_price"] = materialPrice
        }
        if materialQuantity != nil{
            dictionary["material_quantity"] = materialQuantity
        }
        if materialTotalPrice != nil{
            dictionary["material_total_price"] = materialTotalPrice
        }
        if recommended != nil{
            dictionary["recommended"] = recommended
        }
        if referenceId != nil{
            dictionary["reference_id"] = referenceId
        }
        if serviceId != nil{
            dictionary["service_id"] = serviceId
        }
        if type != nil{
            dictionary["type"] = type
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
        if warrantyEndDate != nil{
            dictionary["warranty_end_date"] = warrantyEndDate
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
        jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
        jobRequestItemId = aDecoder.decodeObject(forKey: "job_request_item_id") as? Int
        materialName = aDecoder.decodeObject(forKey: "material_name") as? String
        materialPrice = aDecoder.decodeObject(forKey: "material_price") as? String
        materialQuantity = aDecoder.decodeObject(forKey: "material_quantity") as? Int
        materialTotalPrice = aDecoder.decodeObject(forKey: "material_total_price") as? String
        recommended = aDecoder.decodeObject(forKey: "recommended") as? Int
        referenceId = aDecoder.decodeObject(forKey: "reference_id") as? Int
        serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
        vatPercentage = aDecoder.decodeObject(forKey: "vat_percentage") as? Int
        warrantyEndDate = aDecoder.decodeObject(forKey: "warranty_end_date") as? String
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
        if jobRequestId != nil{
            aCoder.encode(jobRequestId, forKey: "job_request_id")
        }
        if jobRequestItemId != nil{
            aCoder.encode(jobRequestItemId, forKey: "job_request_item_id")
        }
        if materialName != nil{
            aCoder.encode(materialName, forKey: "material_name")
        }
        if materialPrice != nil{
            aCoder.encode(materialPrice, forKey: "material_price")
        }
        if materialQuantity != nil{
            aCoder.encode(materialQuantity, forKey: "material_quantity")
        }
        if materialTotalPrice != nil{
            aCoder.encode(materialTotalPrice, forKey: "material_total_price")
        }
        if recommended != nil{
            aCoder.encode(recommended, forKey: "recommended")
        }
        if referenceId != nil{
            aCoder.encode(referenceId, forKey: "reference_id")
        }
        if serviceId != nil{
            aCoder.encode(serviceId, forKey: "service_id")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
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
        if warrantyEndDate != nil{
            aCoder.encode(warrantyEndDate, forKey: "warranty_end_date")
        }
        if warrantyPercentage != nil{
            aCoder.encode(warrantyPercentage, forKey: "warranty_percentage")
        }

    }

}
