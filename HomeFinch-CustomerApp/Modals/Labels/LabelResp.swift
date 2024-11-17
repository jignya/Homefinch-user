//
//  LabelResp.swift
//  Omahat
//
//  Created by Jignya Panchal on 02/10/20.
//  Copyright © 2020 ImSh. All rights reserved.
//

import Foundation
import SwiftyJSON

class LabelResp : NSObject, NSCoding{
    
    var labelItems : [labelItem]!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        labelItems = [labelItem]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = labelItem(fromJson: dataJson)
            labelItems.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if labelItems != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in labelItems {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        labelItems = aDecoder.decodeObject(forKey: "data") as? [labelItem]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if labelItems != nil{
            aCoder.encode(labelItems, forKey: "data")
        }

    }

}
