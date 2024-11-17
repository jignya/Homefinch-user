//
//	Jobquote.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobquote : NSObject, NSCoding{
    
    var appVersion : String!
    var confirmByOtherPerson : Int!
    var createdAt : String!
    var createdBy : String!
    var currencyCode : String!
    var customerId : Int!
    var distributionChannel : String!
    var employeeId : Int!
    var id : Int!
    var jobRequestId : Int!
    var name : String!
    var overallDiscount : String!
    var overallDiscountPercentage : String!
    var propertyId : Int!
    var salesUnitId : String!
    var signature : String!
    var sourceFrom : Int!
    var sourceInfo : String!
    var sourceIp : String!
    var status : Int!
    var totalPrice : String!
    var updatedAt : String!
    var updatedBy : String!
    var vatPercentage : Int!



    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appVersion = json["app_version"].stringValue
        confirmByOtherPerson = json["confirm_by_other_person"].intValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].stringValue
        currencyCode = json["currency_code"].stringValue
        customerId = json["customer_id"].intValue
        distributionChannel = json["distribution_channel"].stringValue
        employeeId = json["employee_id"].intValue
        id = json["id"].intValue
        jobRequestId = json["job_request_id"].intValue
        name = json["name"].stringValue
        overallDiscount = json["overall_discount"].stringValue
        overallDiscountPercentage = json["overall_discount_percentage"].stringValue
        propertyId = json["property_id"].intValue
        salesUnitId = json["sales_unit_id"].stringValue
        signature = json["signature"].stringValue
        sourceFrom = json["source_from"].intValue
        sourceInfo = json["source_info"].stringValue
        sourceIp = json["source_ip"].stringValue
        status = json["status"].intValue
        totalPrice = json["total_price"].stringValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
        vatPercentage = json["vat_percentage"].intValue

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
        if confirmByOtherPerson != nil{
            dictionary["confirm_by_other_person"] = confirmByOtherPerson
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if distributionChannel != nil{
            dictionary["distribution_channel"] = distributionChannel
        }
        if employeeId != nil{
            dictionary["employee_id"] = employeeId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if jobRequestId != nil{
            dictionary["job_request_id"] = jobRequestId
        }
        if name != nil{
            dictionary["name"] = name
        }
        if overallDiscount != nil{
            dictionary["overall_discount"] = overallDiscount
        }
        if overallDiscountPercentage != nil{
            dictionary["overall_discount_percentage"] = overallDiscountPercentage
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if salesUnitId != nil{
            dictionary["sales_unit_id"] = salesUnitId
        }
        if signature != nil{
            dictionary["signature"] = signature
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
        if totalPrice != nil{
            dictionary["total_price"] = totalPrice
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

        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
         confirmByOtherPerson = aDecoder.decodeObject(forKey: "confirm_by_other_person") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? String
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
         distributionChannel = aDecoder.decodeObject(forKey: "distribution_channel") as? String
         employeeId = aDecoder.decodeObject(forKey: "employee_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         overallDiscount = aDecoder.decodeObject(forKey: "overall_discount") as? String
         overallDiscountPercentage = aDecoder.decodeObject(forKey: "overall_discount_percentage") as? String
         propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int
         salesUnitId = aDecoder.decodeObject(forKey: "sales_unit_id") as? String
         signature = aDecoder.decodeObject(forKey: "signature") as? String
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "total_price") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         vatPercentage = aDecoder.decodeObject(forKey: "vat_percentage") as? Int


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
        if confirmByOtherPerson != nil{
            aCoder.encode(confirmByOtherPerson, forKey: "confirm_by_other_person")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if customerId != nil{
            aCoder.encode(customerId, forKey: "customer_id")
        }
        if distributionChannel != nil{
            aCoder.encode(distributionChannel, forKey: "distribution_channel")
        }
        if employeeId != nil{
            aCoder.encode(employeeId, forKey: "employee_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if jobRequestId != nil{
            aCoder.encode(jobRequestId, forKey: "job_request_id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if overallDiscount != nil{
            aCoder.encode(overallDiscount, forKey: "overall_discount")
        }
        if overallDiscountPercentage != nil{
            aCoder.encode(overallDiscountPercentage, forKey: "overall_discount_percentage")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if salesUnitId != nil{
            aCoder.encode(salesUnitId, forKey: "sales_unit_id")
        }
        if signature != nil{
            aCoder.encode(signature, forKey: "signature")
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
        if totalPrice != nil{
            aCoder.encode(totalPrice, forKey: "total_price")
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


    }

}
