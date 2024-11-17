//
//	EmployeeSkill.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class EmployeeSkill : NSObject, NSCoding{

	var createdAt : String!
	var employeeId : Int!
	var id : Int!
	var matchSkill : MatchSkill!
	var matchSkillId : Int!
	var primarySkill : String!
	var proficiency : String!
	var serviceUnit : ServiceUnit!
	var serviceUnitId : Int!
	var serviceUnitSkill : MatchSkill!
	var serviceUnitSkillId : Int!
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
		let matchSkillJson = json["match_skill"]
		if !matchSkillJson.isEmpty{
			matchSkill = MatchSkill(fromJson: matchSkillJson)
		}
		matchSkillId = json["match_skill_id"].intValue
		primarySkill = json["primary_skill"].stringValue
		proficiency = json["proficiency"].stringValue
		let serviceUnitJson = json["service_unit"]
		if !serviceUnitJson.isEmpty{
			serviceUnit = ServiceUnit(fromJson: serviceUnitJson)
		}
		serviceUnitId = json["service_unit_id"].intValue
		let serviceUnitSkillJson = json["service_unit_skill"]
		if !serviceUnitSkillJson.isEmpty{
			serviceUnitSkill = MatchSkill(fromJson: serviceUnitSkillJson)
		}
		serviceUnitSkillId = json["service_unit_skill_id"].intValue
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
		if matchSkill != nil{
			dictionary["match_skill"] = matchSkill.toDictionary()
		}
		if matchSkillId != nil{
			dictionary["match_skill_id"] = matchSkillId
		}
		if primarySkill != nil{
			dictionary["primary_skill"] = primarySkill
		}
		if proficiency != nil{
			dictionary["proficiency"] = proficiency
		}
		if serviceUnit != nil{
			dictionary["service_unit"] = serviceUnit.toDictionary()
		}
		if serviceUnitId != nil{
			dictionary["service_unit_id"] = serviceUnitId
		}
		if serviceUnitSkill != nil{
			dictionary["service_unit_skill"] = serviceUnitSkill.toDictionary()
		}
		if serviceUnitSkillId != nil{
			dictionary["service_unit_skill_id"] = serviceUnitSkillId
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
         matchSkill = aDecoder.decodeObject(forKey: "match_skill") as? MatchSkill
         matchSkillId = aDecoder.decodeObject(forKey: "match_skill_id") as? Int
         primarySkill = aDecoder.decodeObject(forKey: "primary_skill") as? String
         proficiency = aDecoder.decodeObject(forKey: "proficiency") as? String
         serviceUnit = aDecoder.decodeObject(forKey: "service_unit") as? ServiceUnit
         serviceUnitId = aDecoder.decodeObject(forKey: "service_unit_id") as? Int
         serviceUnitSkill = aDecoder.decodeObject(forKey: "service_unit_skill") as? MatchSkill
         serviceUnitSkillId = aDecoder.decodeObject(forKey: "service_unit_skill_id") as? Int
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
		if matchSkill != nil{
			aCoder.encode(matchSkill, forKey: "match_skill")
		}
		if matchSkillId != nil{
			aCoder.encode(matchSkillId, forKey: "match_skill_id")
		}
		if primarySkill != nil{
			aCoder.encode(primarySkill, forKey: "primary_skill")
		}
		if proficiency != nil{
			aCoder.encode(proficiency, forKey: "proficiency")
		}
		if serviceUnit != nil{
			aCoder.encode(serviceUnit, forKey: "service_unit")
		}
		if serviceUnitId != nil{
			aCoder.encode(serviceUnitId, forKey: "service_unit_id")
		}
		if serviceUnitSkill != nil{
			aCoder.encode(serviceUnitSkill, forKey: "service_unit_skill")
		}
		if serviceUnitSkillId != nil{
			aCoder.encode(serviceUnitSkillId, forKey: "service_unit_skill_id")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
