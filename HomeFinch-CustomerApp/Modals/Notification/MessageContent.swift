//
//	MessageContent.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class MessageContent : NSObject, NSCoding{
    
    var descriptionField : String!
    var redirectUrlId : String!
    var senderId : Int!
    var status : String!
    var subStatus : String!
    var title : String!
    var userId : Int!
    var userType : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        descriptionField = json["description"].stringValue
        redirectUrlId = json["redirect_url_id"].stringValue
        senderId = json["senderId"].intValue
        status = json["status"].stringValue
        subStatus = json["sub_status"].stringValue
        title = json["title"].stringValue
        userId = json["userId"].intValue
        userType = json["userType"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if redirectUrlId != nil{
            dictionary["redirect_url_id"] = redirectUrlId
        }
        if senderId != nil{
            dictionary["senderId"] = senderId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if subStatus != nil{
            dictionary["sub_status"] = subStatus
        }
        if title != nil{
            dictionary["title"] = title
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if userType != nil{
            dictionary["userType"] = userType
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         redirectUrlId = aDecoder.decodeObject(forKey: "redirect_url_id") as? String
         senderId = aDecoder.decodeObject(forKey: "senderId") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? String
         subStatus = aDecoder.decodeObject(forKey: "sub_status") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int
         userType = aDecoder.decodeObject(forKey: "userType") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if redirectUrlId != nil{
            aCoder.encode(redirectUrlId, forKey: "redirect_url_id")
        }
        if senderId != nil{
            aCoder.encode(senderId, forKey: "senderId")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if subStatus != nil{
            aCoder.encode(subStatus, forKey: "sub_status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if userType != nil{
            aCoder.encode(userType, forKey: "userType")
        }

    }

}
