//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class CategoryList : NSObject, NSCoding{
    
    var alias : String!
    var categoryIdSap : String!
    var id : Int!
    var image : String!
    var name : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        alias = json["alias"].stringValue
        categoryIdSap = json["category_id_sap"].stringValue
        id = json["id"].intValue
        image = json["image"].stringValue
        name = json["name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if alias != nil{
            dictionary["alias"] = alias
        }
        if categoryIdSap != nil{
            dictionary["category_id_sap"] = categoryIdSap
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         alias = aDecoder.decodeObject(forKey: "alias") as? String
         categoryIdSap = aDecoder.decodeObject(forKey: "category_id_sap") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         image = aDecoder.decodeObject(forKey: "image") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if alias != nil{
            aCoder.encode(alias, forKey: "alias")
        }
        if categoryIdSap != nil{
            aCoder.encode(categoryIdSap, forKey: "category_id_sap")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

    }

}
