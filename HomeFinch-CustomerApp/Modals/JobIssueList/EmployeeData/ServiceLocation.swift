//
//	ServiceLocation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ServiceLocation : NSObject, NSCoding{

	var createdAt : String!
	var fixNowQuota : String!
	var id : Int!
	var location : SULocation!
	var locationId : Int!
	var scheduleQuota : String!
	var serviceUnitId : Int!
	var slotGroup : SlotGroup!
	var slotGroupId : Int!
	var updatedAt : String!
	var serviceUnit : ServiceUnit!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		fixNowQuota = json["fix_now_quota"].stringValue
		id = json["id"].intValue
		let locationJson = json["location"]
		if !locationJson.isEmpty{
			location = SULocation(fromJson: locationJson)
		}
		locationId = json["location_id"].intValue
		scheduleQuota = json["schedule_quota"].stringValue
		serviceUnitId = json["service_unit_id"].intValue
		let slotGroupJson = json["slot_group"]
		if !slotGroupJson.isEmpty{
			slotGroup = SlotGroup(fromJson: slotGroupJson)
		}
		slotGroupId = json["slot_group_id"].intValue
		updatedAt = json["updated_at"].stringValue
		let serviceUnitJson = json["service_unit"]
		if !serviceUnitJson.isEmpty{
			serviceUnit = ServiceUnit(fromJson: serviceUnitJson)
		}
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
		if fixNowQuota != nil{
			dictionary["fix_now_quota"] = fixNowQuota
		}
		if id != nil{
			dictionary["id"] = id
		}
		if location != nil{
			dictionary["location"] = location.toDictionary()
		}
		if locationId != nil{
			dictionary["location_id"] = locationId
		}
		if scheduleQuota != nil{
			dictionary["schedule_quota"] = scheduleQuota
		}
		if serviceUnitId != nil{
			dictionary["service_unit_id"] = serviceUnitId
		}
		if slotGroup != nil{
			dictionary["slot_group"] = slotGroup.toDictionary()
		}
		if slotGroupId != nil{
			dictionary["slot_group_id"] = slotGroupId
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if serviceUnit != nil{
			dictionary["service_unit"] = serviceUnit.toDictionary()
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
         fixNowQuota = aDecoder.decodeObject(forKey: "fix_now_quota") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         location = aDecoder.decodeObject(forKey: "location") as? SULocation
         locationId = aDecoder.decodeObject(forKey: "location_id") as? Int
         scheduleQuota = aDecoder.decodeObject(forKey: "schedule_quota") as? String
         serviceUnitId = aDecoder.decodeObject(forKey: "service_unit_id") as? Int
         slotGroup = aDecoder.decodeObject(forKey: "slot_group") as? SlotGroup
         slotGroupId = aDecoder.decodeObject(forKey: "slot_group_id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         serviceUnit = aDecoder.decodeObject(forKey: "service_unit") as? ServiceUnit

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
		if fixNowQuota != nil{
			aCoder.encode(fixNowQuota, forKey: "fix_now_quota")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if locationId != nil{
			aCoder.encode(locationId, forKey: "location_id")
		}
		if scheduleQuota != nil{
			aCoder.encode(scheduleQuota, forKey: "schedule_quota")
		}
		if serviceUnitId != nil{
			aCoder.encode(serviceUnitId, forKey: "service_unit_id")
		}
		if slotGroup != nil{
			aCoder.encode(slotGroup, forKey: "slot_group")
		}
		if slotGroupId != nil{
			aCoder.encode(slotGroupId, forKey: "slot_group_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if serviceUnit != nil{
			aCoder.encode(serviceUnit, forKey: "service_unit")
		}

	}

}
