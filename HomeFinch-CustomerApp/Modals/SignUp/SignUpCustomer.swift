//
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class SignUpCustomer : NSObject, NSCoding{

    var address : String!
    var appVersion : String!
    var avatar : String!
    var country : String!
    var createdAt : String!
    var createdBy : Int!
    var customerType : String!
    var email : String!
    var firstName : String!
    var id : Int!
    var idSap : String!
    var lastName : String!
    var latitude : String!
    var location : String!
    var longitude : String!
    var mobile : String!
    var sourceFrom : Int!
    var sourceInfo : String!
    var sourceIp : String!
    var status : Int!
    var title : String!
    var updatedAt : String!
    var updatedBy : String!

    
    override init() {
        
//        title = ""
//        email = ""
//        firstname = ""
//        lastname = ""
//        mobile = ""
//        country = ""
//        idSap = ""
//        created = ""
//        latitude = ""
//        longitude = ""
//        sourceFrom = ""
//        sourceInfo = ""
//        sourceIp = ""
    }

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        address = json["address"].stringValue
        appVersion = json["app_version"].stringValue
        avatar = json["avatar"].stringValue
        country = json["country"].stringValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].intValue
        customerType = json["customer_type"].stringValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        id = json["id"].intValue
        idSap = json["id_sap"].stringValue
        lastName = json["last_name"].stringValue
        latitude = json["latitude"].stringValue
        location = json["location"].stringValue
        longitude = json["longitude"].stringValue
        mobile = json["mobile"].stringValue
        sourceFrom = json["source_from"].intValue
        sourceInfo = json["source_info"].stringValue
        sourceIp = json["source_ip"].stringValue
        status = json["status"].intValue
        title = json["title"].stringValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if appVersion != nil{
            dictionary["app_version"] = appVersion
        }
        if avatar != nil{
            dictionary["avatar"] = avatar
        }
        if country != nil{
            dictionary["country"] = country
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if customerType != nil{
            dictionary["customer_type"] = customerType
        }
        if email != nil{
            dictionary["email"] = email
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if id != nil{
            dictionary["id"] = id
        }
        if idSap != nil{
            dictionary["id_sap"] = idSap
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if location != nil{
            dictionary["location"] = location
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
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
        if title != nil{
            dictionary["title"] = title
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if updatedBy != nil{
            dictionary["updated_by"] = updatedBy
        }
        return dictionary
    }

    func toDictionary1() -> [String:String]
    {
        var dictionary = [String:String]()
        if address != nil{
            dictionary["address"] = address
        }
        if appVersion != nil{
            dictionary["app_version"] = appVersion
        }
        if avatar != nil{
            dictionary["avatar"] = avatar
        }
        if country != nil{
            dictionary["country"] = country
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            let c1 = String(format: "%d", createdBy)
            dictionary["created_by"] = c1
        }
        if customerType != nil{
            dictionary["customer_type"] = customerType
        }
        if email != nil{
            dictionary["email"] = email
        }
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if id != nil{
            
            let id1 = String(format: "%d", id)
            dictionary["id"] = id1
        }
        if idSap != nil{
            dictionary["id_sap"] = idSap
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if location != nil{
            dictionary["location"] = location
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if sourceFrom != nil{
            let sFrom = String(format: "%d", sourceFrom)
            dictionary["source_from"] = sFrom
        }
        if sourceInfo != nil{
            dictionary["source_info"] = sourceInfo
        }
        if sourceIp != nil{
            dictionary["source_ip"] = sourceIp
        }
        if status != nil{
            let status1 = String(format: "%d", status)
            dictionary["status"] = status1
        }
        if title != nil{
            dictionary["title"] = title
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
         address = aDecoder.decodeObject(forKey: "address") as? String
         appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
         avatar = aDecoder.decodeObject(forKey: "avatar") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
         customerType = aDecoder.decodeObject(forKey: "customer_type") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         idSap = aDecoder.decodeObject(forKey: "id_sap") as? String
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if appVersion != nil{
            aCoder.encode(appVersion, forKey: "app_version")
        }
        if avatar != nil{
            aCoder.encode(avatar, forKey: "avatar")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if customerType != nil{
            aCoder.encode(customerType, forKey: "customer_type")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "first_name")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if idSap != nil{
            aCoder.encode(idSap, forKey: "id_sap")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "last_name")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
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
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if updatedBy != nil{
            aCoder.encode(updatedBy, forKey: "updated_by")
        }

    }

}

