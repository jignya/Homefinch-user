//
//	ServiceData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ServiceData : NSObject, NSCoding{
    
    var currencyCode : String!
    var data : [JobIssueList]!
    var recommended : Int!
    var serviceData : Jobservice!
    var sum : Int!

    var isSelected : Int = 1


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        currencyCode = json["currency_code"].stringValue
        data = [JobIssueList]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = JobIssueList(fromJson: dataJson)
            data.append(value)
        }
        recommended = json["recommended"].intValue
        let serviceDataJson = json["service_data"]
        if !serviceDataJson.isEmpty{
            serviceData = Jobservice(fromJson: serviceDataJson)
        }
        sum = json["sum"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if data != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        if recommended != nil{
            dictionary["recommended"] = recommended
        }
        if serviceData != nil{
            dictionary["service_data"] = serviceData.toDictionary()
        }
        if sum != nil{
            dictionary["sum"] = sum
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         data = aDecoder.decodeObject(forKey: "data") as? [JobIssueList]
         recommended = aDecoder.decodeObject(forKey: "recommended") as? Int
         serviceData = aDecoder.decodeObject(forKey: "service_data") as? Jobservice
         sum = aDecoder.decodeObject(forKey: "sum") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if recommended != nil{
            aCoder.encode(recommended, forKey: "recommended")
        }
        if serviceData != nil{
            aCoder.encode(serviceData, forKey: "service_data")
        }
        if sum != nil{
            aCoder.encode(sum, forKey: "sum")
        }

    }

}
