//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class NotificationList : NSObject, NSCoding{
    
    var createdAt : String!
    var id : Int!
    var isRead : Int!
    var messageContent : MessageContent!
    var messageKey : String!
    var receiverId : Int!
    var senderId : Int!
    var status : Int!
    var updatedAt : String!
    var userType : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        isRead = json["is_read"].intValue
        let messageContentJson = json["message_content"]
        if !messageContentJson.isEmpty{
            messageContent = MessageContent(fromJson: messageContentJson)
        }
        messageKey = json["message_key"].stringValue
        receiverId = json["receiver_id"].intValue
        senderId = json["sender_id"].intValue
        status = json["status"].intValue
        updatedAt = json["updated_at"].stringValue
        userType = json["user_type"].intValue
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
        if id != nil{
            dictionary["id"] = id
        }
        if isRead != nil{
            dictionary["is_read"] = isRead
        }
        if messageContent != nil{
            dictionary["message_content"] = messageContent.toDictionary()
        }
        if messageKey != nil{
            dictionary["message_key"] = messageKey
        }
        if receiverId != nil{
            dictionary["receiver_id"] = receiverId
        }
        if senderId != nil{
            dictionary["sender_id"] = senderId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if userType != nil{
            dictionary["user_type"] = userType
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isRead = aDecoder.decodeObject(forKey: "is_read") as? Int
         messageContent = aDecoder.decodeObject(forKey: "message_content") as? MessageContent
         messageKey = aDecoder.decodeObject(forKey: "message_key") as? String
         receiverId = aDecoder.decodeObject(forKey: "receiver_id") as? Int
         senderId = aDecoder.decodeObject(forKey: "sender_id") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userType = aDecoder.decodeObject(forKey: "user_type") as? Int

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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isRead != nil{
            aCoder.encode(isRead, forKey: "is_read")
        }
        if messageContent != nil{
            aCoder.encode(messageContent, forKey: "message_content")
        }
        if messageKey != nil{
            aCoder.encode(messageKey, forKey: "message_key")
        }
        if receiverId != nil{
            aCoder.encode(receiverId, forKey: "receiver_id")
        }
        if senderId != nil{
            aCoder.encode(senderId, forKey: "sender_id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if userType != nil{
            aCoder.encode(userType, forKey: "user_type")
        }

    }

}
