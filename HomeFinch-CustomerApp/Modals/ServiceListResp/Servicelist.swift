//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Servicelist : NSObject, NSCoding{
    
    var category : Category!
    var codeUom : String!
    var currencyCode : String!
    var descriptionField : String!
    var id : Int!
    var isAdditionalHours : Int!
    var mainImagePath : String!
    var name : String!
    var parentCategoryName : String!
    var price : Int!
    var productCategoryName : String!
    var sapId : String!
    var totalRequestCount : Int!
    var valueUom : String!
    var warrantyPeriod : String!
    var warrantyUom : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let categoryJson = json["category"]
        if !categoryJson.isEmpty{
            category = Category(fromJson: categoryJson)
        }
        codeUom = json["code_uom"].stringValue
        currencyCode = json["currency_code"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        isAdditionalHours = json["is_additional_hours"].intValue
        mainImagePath = json["main_image_path"].stringValue
        name = json["name"].stringValue
        parentCategoryName = json["parent_category_name"].stringValue
        price = json["price"].intValue
        productCategoryName = json["product_category_name"].stringValue
        sapId = json["sap_id"].stringValue
        totalRequestCount = json["total_request_count"].intValue
        valueUom = json["value_uom"].stringValue
        warrantyPeriod = json["warranty_period"].stringValue
        warrantyUom = json["warranty_uom"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            dictionary["category"] = category.toDictionary()
        }
        if codeUom != nil{
            dictionary["code_uom"] = codeUom
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
        if isAdditionalHours != nil{
            dictionary["is_additional_hours"] = isAdditionalHours
        }
        if mainImagePath != nil{
            dictionary["main_image_path"] = mainImagePath
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
        if productCategoryName != nil{
            dictionary["product_category_name"] = productCategoryName
        }
        if sapId != nil{
            dictionary["sap_id"] = sapId
        }
        if totalRequestCount != nil{
            dictionary["total_request_count"] = totalRequestCount
        }
        if valueUom != nil{
            dictionary["value_uom"] = valueUom
        }
        if warrantyPeriod != nil{
            dictionary["warranty_period"] = warrantyPeriod
        }
        if warrantyUom != nil{
            dictionary["warranty_uom"] = warrantyUom
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? Category
        codeUom = aDecoder.decodeObject(forKey: "code_uom") as? String
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isAdditionalHours = aDecoder.decodeObject(forKey: "is_additional_hours") as? Int
        mainImagePath = aDecoder.decodeObject(forKey: "main_image_path") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        parentCategoryName = aDecoder.decodeObject(forKey: "parent_category_name") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        productCategoryName = aDecoder.decodeObject(forKey: "product_category_name") as? String
        sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
        totalRequestCount = aDecoder.decodeObject(forKey: "total_request_count") as? Int
        valueUom = aDecoder.decodeObject(forKey: "value_uom") as? String
        warrantyPeriod = aDecoder.decodeObject(forKey: "warranty_period") as? String
        warrantyUom = aDecoder.decodeObject(forKey: "warranty_uom") as? String
        
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if codeUom != nil{
            aCoder.encode(codeUom, forKey: "code_uom")
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
        if isAdditionalHours != nil{
            aCoder.encode(isAdditionalHours, forKey: "is_additional_hours")
        }
        if mainImagePath != nil{
            aCoder.encode(mainImagePath, forKey: "main_image_path")
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
        if productCategoryName != nil{
            aCoder.encode(productCategoryName, forKey: "product_category_name")
        }
        if sapId != nil{
            aCoder.encode(sapId, forKey: "sap_id")
        }
        if totalRequestCount != nil{
            aCoder.encode(totalRequestCount, forKey: "total_request_count")
        }
        if valueUom != nil{
            aCoder.encode(valueUom, forKey: "value_uom")
        }
        if warrantyPeriod != nil{
            aCoder.encode(warrantyPeriod, forKey: "warranty_period")
        }
        if warrantyUom != nil{
            aCoder.encode(warrantyUom, forKey: "warranty_uom")
        }

    }

}

