//
//  LabelData.swift
//  Omahat
//
//  Created by Jignya Panchal on 02/10/20.
//  Copyright © 2020 ImSh. All rights reserved.
//

import Foundation
import SwiftyJSON

class labelItem : NSObject, NSCoding{
    
    var labelCode : String!
    var labelId : String!
    var labelValue : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        labelCode = json["label_code"].stringValue
        labelId = json["label_id"].stringValue
        labelValue = json["label_value"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if labelCode != nil{
            dictionary["label_code"] = labelCode
        }
        if labelId != nil{
            dictionary["label_id"] = labelId
        }
        if labelValue != nil{
            dictionary["label_value"] = labelValue
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         labelCode = aDecoder.decodeObject(forKey: "label_code") as? String
         labelId = aDecoder.decodeObject(forKey: "label_id") as? String
         labelValue = aDecoder.decodeObject(forKey: "label_value") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if labelCode != nil{
            aCoder.encode(labelCode, forKey: "label_code")
        }
        if labelId != nil{
            aCoder.encode(labelId, forKey: "label_id")
        }
        if labelValue != nil{
            aCoder.encode(labelValue, forKey: "label_value")
        }
    }
}
