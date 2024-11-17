//
//	Service.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Service : NSObject, NSCoding{

	var id : Int!
	var serviceDescription : String!
	var serviceIdSap : String!

    override init() {
        
    }

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["id"].intValue
		serviceDescription = json["service_description"].stringValue
		serviceIdSap = json["service_id_sap"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if serviceDescription != nil{
			dictionary["service_description"] = serviceDescription
		}
		if serviceIdSap != nil{
			dictionary["service_id_sap"] = serviceIdSap
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         serviceDescription = aDecoder.decodeObject(forKey: "service_description") as? String
         serviceIdSap = aDecoder.decodeObject(forKey: "service_id_sap") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if serviceDescription != nil{
			aCoder.encode(serviceDescription, forKey: "service_description")
		}
		if serviceIdSap != nil{
			aCoder.encode(serviceIdSap, forKey: "service_id_sap")
		}

	}

}
