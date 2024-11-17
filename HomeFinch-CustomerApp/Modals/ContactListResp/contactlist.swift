//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class contactlist : NSObject, NSCoding{

	var contactType : Int!
	var createdAt : String!
	var customerId : Int!
	var email : String!
	var firstName : String!
	var fullName : String!
	var id : Int!
	var isOwner : Int!
	var lastName : String!
	var mobile : String!
	var title : String!

    var isSelected : Int = 0

    override init ()
    {
        
    }
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		contactType = json["contact_type"].intValue
		createdAt = json["created_at"].stringValue
		customerId = json["customer_id"].intValue
		email = json["email"].stringValue
		firstName = json["first_name"].stringValue
		fullName = json["full_name"].stringValue
		id = json["id"].intValue
		isOwner = json["is_owner"].intValue
		lastName = json["last_name"].stringValue
		mobile = json["mobile"].stringValue
		title = json["title"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if contactType != nil{
			dictionary["contact_type"] = contactType
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if customerId != nil{
			dictionary["customer_id"] = customerId
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isOwner != nil{
			dictionary["is_owner"] = isOwner
		}
		if lastName != nil{
			dictionary["last_name"] = lastName
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         contactType = aDecoder.decodeObject(forKey: "contact_type") as? Int
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isOwner = aDecoder.decodeObject(forKey: "is_owner") as? Int
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if contactType != nil{
			aCoder.encode(contactType, forKey: "contact_type")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if customerId != nil{
			aCoder.encode(customerId, forKey: "customer_id")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isOwner != nil{
			aCoder.encode(isOwner, forKey: "is_owner")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}
