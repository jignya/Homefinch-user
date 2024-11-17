//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PropertyDetailData : NSObject, NSCoding{
    
    var accuracy : Int!
    var activeRequests : String!
    var appVersion : String!
    var appartmentBuilding : String!
    var appartmentFlatNo : String!
    var appartmentStreet : String!
    var builtUpAreaSqft : String!
    var createdAt : String!
    var createdBy : String!
    var customerCount : Int!
    var customerId : Int!
    var distancet : Float!
    var fullAddress : String!
    var gLocation : String!
    var geofenceRadarId : String!
    var id : Int!
    var isDefault : Int!
    var isTenant : Int!
    var latitude : String!
    var longitude : String!
    var numberOfBathrooms : String!
    var numberOfBedrooms : String!
    var numberOfFloors : String!
    var ownerMobile : String!
    var ownerName : String!
    var propertyName : String!
    var propertyRadarId : String!
    var propertyType : Int!
    var sourceFrom : Int!
    var sourceInfo : String!
    var sourceIp : String!
    var status : Int!
    var totalRequests : String!
    var uniquePropertyId : String!
    var uniquePropertyIdType : String!
    var updatedAt : String!
    var updatedBy : String!
    var villaNumber : String!
    var villaStreet : String!
    
    override init() {
        
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accuracy = json["accuracy"].intValue
        activeRequests = json["active_requests"].stringValue
        appVersion = json["app_version"].stringValue
        appartmentBuilding = json["appartment_building"].stringValue
        appartmentFlatNo = json["appartment_flat_no"].stringValue
        appartmentStreet = json["appartment_street"].stringValue
        builtUpAreaSqft = json["built_up_area_sqft"].stringValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].stringValue
        customerCount = json["customer_count"].intValue
        customerId = json["customer_id"].intValue
        distancet = json["distancet"].floatValue
        fullAddress = json["full_address"].stringValue
        gLocation = json["g_location"].stringValue
        geofenceRadarId = json["geofence_radar_id"].stringValue
        id = json["id"].intValue
        isDefault = json["is_default"].intValue
        isTenant = json["is_tenant"].intValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        numberOfBathrooms = json["number_of_bathrooms"].stringValue
        numberOfBedrooms = json["number_of_bedrooms"].stringValue
        numberOfFloors = json["number_of_floors"].stringValue
        ownerMobile = json["owner_mobile"].stringValue
        ownerName = json["owner_name"].stringValue
        propertyName = json["property_name"].stringValue
        propertyRadarId = json["property_radar_id"].stringValue
        propertyType = json["property_type"].intValue
        sourceFrom = json["source_from"].intValue
        sourceInfo = json["source_info"].stringValue
        sourceIp = json["source_ip"].stringValue
        status = json["status"].intValue
        totalRequests = json["total_requests"].stringValue
        uniquePropertyId = json["unique_property_id"].stringValue
        uniquePropertyIdType = json["unique_property_id_type"].stringValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
        villaNumber = json["villa_number"].stringValue
        villaStreet = json["villa_street"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accuracy != nil{
            dictionary["accuracy"] = accuracy
        }
        if activeRequests != nil{
            dictionary["active_requests"] = activeRequests
        }
        if appVersion != nil{
            dictionary["app_version"] = appVersion
        }
        if appartmentBuilding != nil{
            dictionary["appartment_building"] = appartmentBuilding
        }
        if appartmentFlatNo != nil{
            dictionary["appartment_flat_no"] = appartmentFlatNo
        }
        if appartmentStreet != nil{
            dictionary["appartment_street"] = appartmentStreet
        }
        if builtUpAreaSqft != nil{
            dictionary["built_up_area_sqft"] = builtUpAreaSqft
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if customerCount != nil{
            dictionary["customer_count"] = customerCount
        }
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if distancet != nil{
            dictionary["distancet"] = distancet
        }
        if fullAddress != nil{
            dictionary["full_address"] = fullAddress
        }
        if gLocation != nil{
            dictionary["g_location"] = gLocation
        }
        if geofenceRadarId != nil{
            dictionary["geofence_radar_id"] = geofenceRadarId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isDefault != nil{
            dictionary["is_default"] = isDefault
        }
        if isTenant != nil{
            dictionary["is_tenant"] = isTenant
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if numberOfBathrooms != nil{
            dictionary["number_of_bathrooms"] = numberOfBathrooms
        }
        if numberOfBedrooms != nil{
            dictionary["number_of_bedrooms"] = numberOfBedrooms
        }
        if numberOfFloors != nil{
            dictionary["number_of_floors"] = numberOfFloors
        }
        if ownerMobile != nil{
            dictionary["owner_mobile"] = ownerMobile
        }
        if ownerName != nil{
            dictionary["owner_name"] = ownerName
        }
        if propertyName != nil{
            dictionary["property_name"] = propertyName
        }
        if propertyRadarId != nil{
            dictionary["property_radar_id"] = propertyRadarId
        }
        if propertyType != nil{
            dictionary["property_type"] = propertyType
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
        if totalRequests != nil{
            dictionary["total_requests"] = totalRequests
        }
        if uniquePropertyId != nil{
            dictionary["unique_property_id"] = uniquePropertyId
        }
        if uniquePropertyIdType != nil{
            dictionary["unique_property_id_type"] = uniquePropertyIdType
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if updatedBy != nil{
            dictionary["updated_by"] = updatedBy
        }
        if villaNumber != nil{
            dictionary["villa_number"] = villaNumber
        }
        if villaStreet != nil{
            dictionary["villa_street"] = villaStreet
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accuracy = aDecoder.decodeObject(forKey: "accuracy") as? Int
         activeRequests = aDecoder.decodeObject(forKey: "active_requests") as? String
         appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
         appartmentBuilding = aDecoder.decodeObject(forKey: "appartment_building") as? String
         appartmentFlatNo = aDecoder.decodeObject(forKey: "appartment_flat_no") as? String
         appartmentStreet = aDecoder.decodeObject(forKey: "appartment_street") as? String
         builtUpAreaSqft = aDecoder.decodeObject(forKey: "built_up_area_sqft") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? String
         customerCount = aDecoder.decodeObject(forKey: "customer_count") as? Int
         customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
         distancet = aDecoder.decodeObject(forKey: "distancet") as? Float
         fullAddress = aDecoder.decodeObject(forKey: "full_address") as? String
         gLocation = aDecoder.decodeObject(forKey: "g_location") as? String
         geofenceRadarId = aDecoder.decodeObject(forKey: "geofence_radar_id") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Int
         isTenant = aDecoder.decodeObject(forKey: "is_tenant") as? Int
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         numberOfBathrooms = aDecoder.decodeObject(forKey: "number_of_bathrooms") as? String
         numberOfBedrooms = aDecoder.decodeObject(forKey: "number_of_bedrooms") as? String
         numberOfFloors = aDecoder.decodeObject(forKey: "number_of_floors") as? String
         ownerMobile = aDecoder.decodeObject(forKey: "owner_mobile") as? String
         ownerName = aDecoder.decodeObject(forKey: "owner_name") as? String
         propertyName = aDecoder.decodeObject(forKey: "property_name") as? String
         propertyRadarId = aDecoder.decodeObject(forKey: "property_radar_id") as? String
         propertyType = aDecoder.decodeObject(forKey: "property_type") as? Int
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         totalRequests = aDecoder.decodeObject(forKey: "total_requests") as? String
         uniquePropertyId = aDecoder.decodeObject(forKey: "unique_property_id") as? String
         uniquePropertyIdType = aDecoder.decodeObject(forKey: "unique_property_id_type") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
         villaNumber = aDecoder.decodeObject(forKey: "villa_number") as? String
         villaStreet = aDecoder.decodeObject(forKey: "villa_street") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if accuracy != nil{
            aCoder.encode(accuracy, forKey: "accuracy")
        }
        if activeRequests != nil{
            aCoder.encode(activeRequests, forKey: "active_requests")
        }
        if appVersion != nil{
            aCoder.encode(appVersion, forKey: "app_version")
        }
        if appartmentBuilding != nil{
            aCoder.encode(appartmentBuilding, forKey: "appartment_building")
        }
        if appartmentFlatNo != nil{
            aCoder.encode(appartmentFlatNo, forKey: "appartment_flat_no")
        }
        if appartmentStreet != nil{
            aCoder.encode(appartmentStreet, forKey: "appartment_street")
        }
        if builtUpAreaSqft != nil{
            aCoder.encode(builtUpAreaSqft, forKey: "built_up_area_sqft")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if customerCount != nil{
            aCoder.encode(customerCount, forKey: "customer_count")
        }
        if customerId != nil{
            aCoder.encode(customerId, forKey: "customer_id")
        }
        if distancet != nil{
            aCoder.encode(distancet, forKey: "distancet")
        }
        if fullAddress != nil{
            aCoder.encode(fullAddress, forKey: "full_address")
        }
        if gLocation != nil{
            aCoder.encode(gLocation, forKey: "g_location")
        }
        if geofenceRadarId != nil{
            aCoder.encode(geofenceRadarId, forKey: "geofence_radar_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isDefault != nil{
            aCoder.encode(isDefault, forKey: "is_default")
        }
        if isTenant != nil{
            aCoder.encode(isTenant, forKey: "is_tenant")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if numberOfBathrooms != nil{
            aCoder.encode(numberOfBathrooms, forKey: "number_of_bathrooms")
        }
        if numberOfBedrooms != nil{
            aCoder.encode(numberOfBedrooms, forKey: "number_of_bedrooms")
        }
        if numberOfFloors != nil{
            aCoder.encode(numberOfFloors, forKey: "number_of_floors")
        }
        if ownerMobile != nil{
            aCoder.encode(ownerMobile, forKey: "owner_mobile")
        }
        if ownerName != nil{
            aCoder.encode(ownerName, forKey: "owner_name")
        }
        if propertyName != nil{
            aCoder.encode(propertyName, forKey: "property_name")
        }
        if propertyRadarId != nil{
            aCoder.encode(propertyRadarId, forKey: "property_radar_id")
        }
        if propertyType != nil{
            aCoder.encode(propertyType, forKey: "property_type")
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
        if totalRequests != nil{
            aCoder.encode(totalRequests, forKey: "total_requests")
        }
        if uniquePropertyId != nil{
            aCoder.encode(uniquePropertyId, forKey: "unique_property_id")
        }
        if uniquePropertyIdType != nil{
            aCoder.encode(uniquePropertyIdType, forKey: "unique_property_id_type")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if updatedBy != nil{
            aCoder.encode(updatedBy, forKey: "updated_by")
        }
        if villaNumber != nil{
            aCoder.encode(villaNumber, forKey: "villa_number")
        }
        if villaStreet != nil{
            aCoder.encode(villaStreet, forKey: "villa_street")
        }

    }

}
