//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class NotificationResp : NSObject, NSCoding{

	var data : NotificationData!
	var message : String!
	var status : Int!
	var success : Bool!
    var list : [NotificationList]!

    
    override init() {
        
    }
    
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let dataJson = json["data"]
		if !dataJson.isEmpty{
			data = NotificationData(fromJson: dataJson)
		}
        
        
        list = [NotificationList]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = NotificationList(fromJson: dataJson)
            list.append(value)
        }
        
		message = json["message"].stringValue
		status = json["status"].intValue
		success = json["success"].boolValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if message != nil{
			dictionary["message"] = message
		}
		if status != nil{
			dictionary["status"] = status
		}
		if success != nil{
			dictionary["success"] = success
		}
        if list != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in list {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["list"] = dictionaryElements
        }
        
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? NotificationData
         message = aDecoder.decodeObject(forKey: "message") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         success = aDecoder.decodeObject(forKey: "success") as? Bool
         list = aDecoder.decodeObject(forKey: "data") as? [NotificationList]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if success != nil{
			aCoder.encode(success, forKey: "success")
		}
        if list != nil{
            aCoder.encode(list, forKey: "data")
        }
	}

}
