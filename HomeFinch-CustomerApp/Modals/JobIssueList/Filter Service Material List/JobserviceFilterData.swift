//
//	Jobservice.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class JobserviceFilterData : NSObject, NSCoding{
    
    var categoryId : Int!
    var createdAt : String!
    var currencyCode : String!
    var estimatedExecutionTime : String!
    var estimatedInspectionTime : String!
    var estimatedMaterialProcurementTime : String!
    var estimatedTotalJobTime : String!
    var estimatedTravelTime : String!
    var id : Int!
    var isAdditionalHours : Int!
    var materialProcurementTime : String!
    var materialUnavailabilityPercentage : String!
    var price : String!
    var recommended : Int!
    var serviceDescription : String!
    var serviceIdSap : String!
    var status : Int!
    var uom : String!
    var updatedAt : String!
    var data : [JobIssueList]!
    var serviceQty : Float = 1


    override init() {
        
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        categoryId = json["category_id"].intValue
        createdAt = json["created_at"].stringValue
        currencyCode = json["currency_code"].stringValue
        estimatedExecutionTime = json["estimated_execution_time"].stringValue
        estimatedInspectionTime = json["estimated_inspection_time"].stringValue
        estimatedMaterialProcurementTime = json["estimated_material_procurement_time"].stringValue
        estimatedTotalJobTime = json["estimated_total_job_time"].stringValue
        estimatedTravelTime = json["estimated_travel_time"].stringValue
        id = json["id"].intValue
        isAdditionalHours = json["is_additional_hours"].intValue
        materialProcurementTime = json["material_procurement_time"].stringValue
        materialUnavailabilityPercentage = json["material_unavailability_percentage"].stringValue
        price = json["price"].stringValue
        recommended = json["recommended"].intValue
        serviceDescription = json["service_description"].stringValue
        serviceIdSap = json["service_id_sap"].stringValue
        status = json["status"].intValue
        uom = json["uom"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if categoryId != nil{
            dictionary["category_id"] = categoryId
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if estimatedExecutionTime != nil{
            dictionary["estimated_execution_time"] = estimatedExecutionTime
        }
        if estimatedInspectionTime != nil{
            dictionary["estimated_inspection_time"] = estimatedInspectionTime
        }
        if estimatedMaterialProcurementTime != nil{
            dictionary["estimated_material_procurement_time"] = estimatedMaterialProcurementTime
        }
        if estimatedTotalJobTime != nil{
            dictionary["estimated_total_job_time"] = estimatedTotalJobTime
        }
        if estimatedTravelTime != nil{
            dictionary["estimated_travel_time"] = estimatedTravelTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isAdditionalHours != nil{
            dictionary["is_additional_hours"] = isAdditionalHours
        }
        if materialProcurementTime != nil{
            dictionary["material_procurement_time"] = materialProcurementTime
        }
        if materialUnavailabilityPercentage != nil{
            dictionary["material_unavailability_percentage"] = materialUnavailabilityPercentage
        }
        if price != nil{
            dictionary["price"] = price
        }
        if recommended != nil{
            dictionary["recommended"] = recommended
        }
        if serviceDescription != nil{
            dictionary["service_description"] = serviceDescription
        }
        if serviceIdSap != nil{
            dictionary["service_id_sap"] = serviceIdSap
        }
        if status != nil{
            dictionary["status"] = status
        }
        if uom != nil{
            dictionary["uom"] = uom
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if serviceQty != nil{
            dictionary["serviceQty"] = serviceQty
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         estimatedExecutionTime = aDecoder.decodeObject(forKey: "estimated_execution_time") as? String
         estimatedInspectionTime = aDecoder.decodeObject(forKey: "estimated_inspection_time") as? String
         estimatedMaterialProcurementTime = aDecoder.decodeObject(forKey: "estimated_material_procurement_time") as? String
         estimatedTotalJobTime = aDecoder.decodeObject(forKey: "estimated_total_job_time") as? String
         estimatedTravelTime = aDecoder.decodeObject(forKey: "estimated_travel_time") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isAdditionalHours = aDecoder.decodeObject(forKey: "is_additional_hours") as? Int
         materialProcurementTime = aDecoder.decodeObject(forKey: "material_procurement_time") as? String
         materialUnavailabilityPercentage = aDecoder.decodeObject(forKey: "material_unavailability_percentage") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         recommended = aDecoder.decodeObject(forKey: "recommended") as? Int
         serviceDescription = aDecoder.decodeObject(forKey: "service_description") as? String
         serviceIdSap = aDecoder.decodeObject(forKey: "service_id_sap") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         uom = aDecoder.decodeObject(forKey: "uom") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if categoryId != nil{
            aCoder.encode(categoryId, forKey: "category_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if estimatedExecutionTime != nil{
            aCoder.encode(estimatedExecutionTime, forKey: "estimated_execution_time")
        }
        if estimatedInspectionTime != nil{
            aCoder.encode(estimatedInspectionTime, forKey: "estimated_inspection_time")
        }
        if estimatedMaterialProcurementTime != nil{
            aCoder.encode(estimatedMaterialProcurementTime, forKey: "estimated_material_procurement_time")
        }
        if estimatedTotalJobTime != nil{
            aCoder.encode(estimatedTotalJobTime, forKey: "estimated_total_job_time")
        }
        if estimatedTravelTime != nil{
            aCoder.encode(estimatedTravelTime, forKey: "estimated_travel_time")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isAdditionalHours != nil{
            aCoder.encode(isAdditionalHours, forKey: "is_additional_hours")
        }
        if materialProcurementTime != nil{
            aCoder.encode(materialProcurementTime, forKey: "material_procurement_time")
        }
        if materialUnavailabilityPercentage != nil{
            aCoder.encode(materialUnavailabilityPercentage, forKey: "material_unavailability_percentage")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if recommended != nil{
            aCoder.encode(recommended, forKey: "recommended")
        }
        if serviceDescription != nil{
            aCoder.encode(serviceDescription, forKey: "service_description")
        }
        if serviceIdSap != nil{
            aCoder.encode(serviceIdSap, forKey: "service_id_sap")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if uom != nil{
            aCoder.encode(uom, forKey: "uom")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
