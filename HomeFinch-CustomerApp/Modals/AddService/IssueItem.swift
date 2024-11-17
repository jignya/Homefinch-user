//
//	IssueItem.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class IssueItem : NSObject, NSCoding{

	var categoryId : Int!
	var descriptionField : String!
	var images : [String]!
	var issueId : Int!
	var items : String!
    
    override init() {
        
    }
    
    func GetFileUrl(Filename:String) -> URL
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let fileDataPath = documentsDirectory + "/" + Filename
        let filePathURL = URL(fileURLWithPath: fileDataPath)
        return filePathURL
    }

   
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		categoryId = json["category_id"].intValue
		descriptionField = json["description"].stringValue
		images = [String]()
		let imagesArray = json["images"].arrayValue
		for imagesJson in imagesArray{
			images.append(imagesJson.stringValue)
		}
		issueId = json["issue_id"].intValue
		items = json["items"].stringValue
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
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if images != nil{
			dictionary["images"] = images
		}
		if issueId != nil{
			dictionary["issue_id"] = issueId
		}
		if items != nil{
			dictionary["items"] = items
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
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         images = aDecoder.decodeObject(forKey: "images") as? [String]
         issueId = aDecoder.decodeObject(forKey: "issue_id") as? Int
         items = aDecoder.decodeObject(forKey: "items") as? String

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
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if images != nil{
			aCoder.encode(images, forKey: "images")
		}
		if issueId != nil{
			aCoder.encode(issueId, forKey: "issue_id")
		}
		if items != nil{
			aCoder.encode(items, forKey: "items")
		}

	}

}
