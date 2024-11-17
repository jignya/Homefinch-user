//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class TransactionList : NSObject, NSCoding{

	var date : String!
	var stub : [Stub]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		date = json["date"].stringValue
		stub = [Stub]()
		let stubArray = json["stub"].arrayValue
		for stubJson in stubArray{
			let value = Stub(fromJson: stubJson)
			stub.append(value)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if date != nil{
			dictionary["date"] = date
		}
		if stub != nil{
			var dictionaryElements = [[String:Any]]()
			for stubElement in stub {
				dictionaryElements.append(stubElement.toDictionary())
			}
			dictionary["stub"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         date = aDecoder.decodeObject(forKey: "date") as? String
         stub = aDecoder.decodeObject(forKey: "stub") as? [Stub]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if stub != nil{
			aCoder.encode(stub, forKey: "stub")
		}

	}

}
