//
//	EmployeeSlotGroup.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class EmployeeSlotGroup : NSObject, NSCoding{

	var createdAt : String!
	var employeeId : Int!
	var id : Int!
	var otherSkill : String!
	var otherSkillId : String!
	var primarySkill : MatchSkill!
	var primarySkillId : Int!
	var serviceLocation : ServiceLocation!
	var serviceUnit : ServiceUnit!
	var serviceUnitId : Int!
	var slotGroup : SlotGroup!
	var slotGroupId : Int!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		employeeId = json["employee_id"].intValue
		id = json["id"].intValue
		otherSkill = json["other_skill"].stringValue
		otherSkillId = json["other_skill_id"].stringValue
		let primarySkillJson = json["primary_skill"]
		if !primarySkillJson.isEmpty{
			primarySkill = MatchSkill(fromJson: primarySkillJson)
		}
		primarySkillId = json["primary_skill_id"].intValue
		let serviceLocationJson = json["service_location"]
		if !serviceLocationJson.isEmpty{
			serviceLocation = ServiceLocation(fromJson: serviceLocationJson)
		}
		let serviceUnitJson = json["service_unit"]
		if !serviceUnitJson.isEmpty{
			serviceUnit = ServiceUnit(fromJson: serviceUnitJson)
		}
		serviceUnitId = json["service_unit_id"].intValue
		let slotGroupJson = json["slot_group"]
		if !slotGroupJson.isEmpty{
			slotGroup = SlotGroup(fromJson: slotGroupJson)
		}
		slotGroupId = json["slot_group_id"].intValue
		updatedAt = json["updated_at"].stringValue
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
		if employeeId != nil{
			dictionary["employee_id"] = employeeId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if otherSkill != nil{
			dictionary["other_skill"] = otherSkill
		}
		if otherSkillId != nil{
			dictionary["other_skill_id"] = otherSkillId
		}
		if primarySkill != nil{
			dictionary["primary_skill"] = primarySkill.toDictionary()
		}
		if primarySkillId != nil{
			dictionary["primary_skill_id"] = primarySkillId
		}
		if serviceLocation != nil{
			dictionary["service_location"] = serviceLocation.toDictionary()
		}
		if serviceUnit != nil{
			dictionary["service_unit"] = serviceUnit.toDictionary()
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
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         employeeId = aDecoder.decodeObject(forKey: "employee_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         otherSkill = aDecoder.decodeObject(forKey: "other_skill") as? String
         otherSkillId = aDecoder.decodeObject(forKey: "other_skill_id") as? String
         primarySkill = aDecoder.decodeObject(forKey: "primary_skill") as? MatchSkill
         primarySkillId = aDecoder.decodeObject(forKey: "primary_skill_id") as? Int
         serviceLocation = aDecoder.decodeObject(forKey: "service_location") as? ServiceLocation
         serviceUnit = aDecoder.decodeObject(forKey: "service_unit") as? ServiceUnit
         serviceUnitId = aDecoder.decodeObject(forKey: "service_unit_id") as? Int
         slotGroup = aDecoder.decodeObject(forKey: "slot_group") as? SlotGroup
         slotGroupId = aDecoder.decodeObject(forKey: "slot_group_id") as? Int
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

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
		if employeeId != nil{
			aCoder.encode(employeeId, forKey: "employee_id")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if otherSkill != nil{
			aCoder.encode(otherSkill, forKey: "other_skill")
		}
		if otherSkillId != nil{
			aCoder.encode(otherSkillId, forKey: "other_skill_id")
		}
		if primarySkill != nil{
			aCoder.encode(primarySkill, forKey: "primary_skill")
		}
		if primarySkillId != nil{
			aCoder.encode(primarySkillId, forKey: "primary_skill_id")
		}
		if serviceLocation != nil{
			aCoder.encode(serviceLocation, forKey: "service_location")
		}
		if serviceUnit != nil{
			aCoder.encode(serviceUnit, forKey: "service_unit")
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

	}

}
