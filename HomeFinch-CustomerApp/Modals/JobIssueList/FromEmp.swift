//
//	FromEmp.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class FromEmp : NSObject, NSCoding{

	var appVersion : String!
	var avatar : String!
	var createdAt : String!
	var dob : String!
	var email : String!
	var employeeSkill : [EmployeeSkill]!
	var firstName : String!
	var fullName : String!
	var gender : String!
	var genderName : String!
	var hireDate : String!
	var id : Int!
	var lastName : String!
	var phone : String!
	var sapId : String!
	var serviceStartDate : String!
	var serviceTerminationDate : String!
	var sourceFrom : Int!
	var sourceInfo : String!
	var sourceIp : String!
	var status : Int!
	var title : String!
	var titleName : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		appVersion = json["app_version"].stringValue
		avatar = json["avatar"].stringValue
		createdAt = json["created_at"].stringValue
		dob = json["dob"].stringValue
		email = json["email"].stringValue
		employeeSkill = [EmployeeSkill]()
		let employeeSkillArray = json["employee_skill"].arrayValue
		for employeeSkillJson in employeeSkillArray{
			let value = EmployeeSkill(fromJson: employeeSkillJson)
			employeeSkill.append(value)
		}
		firstName = json["first_name"].stringValue
		fullName = json["full_name"].stringValue
		gender = json["gender"].stringValue
		genderName = json["gender_name"].stringValue
		hireDate = json["hire_date"].stringValue
		id = json["id"].intValue
		lastName = json["last_name"].stringValue
		phone = json["phone"].stringValue
		sapId = json["sap_id"].stringValue
		serviceStartDate = json["service_start_date"].stringValue
		serviceTerminationDate = json["service_termination_date"].stringValue
		sourceFrom = json["source_from"].intValue
		sourceInfo = json["source_info"].stringValue
		sourceIp = json["source_ip"].stringValue
		status = json["status"].intValue
		title = json["title"].stringValue
		titleName = json["title_name"].stringValue
		updatedAt = json["updated_at"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if appVersion != nil{
			dictionary["app_version"] = appVersion
		}
		if avatar != nil{
			dictionary["avatar"] = avatar
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if dob != nil{
			dictionary["dob"] = dob
		}
		if email != nil{
			dictionary["email"] = email
		}
		if employeeSkill != nil{
			var dictionaryElements = [[String:Any]]()
			for employeeSkillElement in employeeSkill {
				dictionaryElements.append(employeeSkillElement.toDictionary())
			}
			dictionary["employee_skill"] = dictionaryElements
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if genderName != nil{
			dictionary["gender_name"] = genderName
		}
		if hireDate != nil{
			dictionary["hire_date"] = hireDate
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastName != nil{
			dictionary["last_name"] = lastName
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if sapId != nil{
			dictionary["sap_id"] = sapId
		}
		if serviceStartDate != nil{
			dictionary["service_start_date"] = serviceStartDate
		}
		if serviceTerminationDate != nil{
			dictionary["service_termination_date"] = serviceTerminationDate
		}
		if sourceFrom != nil{
			dictionary["source_from"] = sourceFrom
		}
		if sourceInfo != nil{
			dictionary["source_info"] = sourceInfo
		}
		if sourceIp != nil{
			dictionary["source_ip"] = sourceIp
		}
		if status != nil{
			dictionary["status"] = status
		}
		if title != nil{
			dictionary["title"] = title
		}
		if titleName != nil{
			dictionary["title_name"] = titleName
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
         appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
         avatar = aDecoder.decodeObject(forKey: "avatar") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         dob = aDecoder.decodeObject(forKey: "dob") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         employeeSkill = aDecoder.decodeObject(forKey: "employee_skill") as? [EmployeeSkill]
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         genderName = aDecoder.decodeObject(forKey: "gender_name") as? String
         hireDate = aDecoder.decodeObject(forKey: "hire_date") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         sapId = aDecoder.decodeObject(forKey: "sap_id") as? String
         serviceStartDate = aDecoder.decodeObject(forKey: "service_start_date") as? String
         serviceTerminationDate = aDecoder.decodeObject(forKey: "service_termination_date") as? String
         sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
         sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
         sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         titleName = aDecoder.decodeObject(forKey: "title_name") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if appVersion != nil{
			aCoder.encode(appVersion, forKey: "app_version")
		}
		if avatar != nil{
			aCoder.encode(avatar, forKey: "avatar")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if dob != nil{
			aCoder.encode(dob, forKey: "dob")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if employeeSkill != nil{
			aCoder.encode(employeeSkill, forKey: "employee_skill")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if genderName != nil{
			aCoder.encode(genderName, forKey: "gender_name")
		}
		if hireDate != nil{
			aCoder.encode(hireDate, forKey: "hire_date")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if sapId != nil{
			aCoder.encode(sapId, forKey: "sap_id")
		}
		if serviceStartDate != nil{
			aCoder.encode(serviceStartDate, forKey: "service_start_date")
		}
		if serviceTerminationDate != nil{
			aCoder.encode(serviceTerminationDate, forKey: "service_termination_date")
		}
		if sourceFrom != nil{
			aCoder.encode(sourceFrom, forKey: "source_from")
		}
		if sourceInfo != nil{
			aCoder.encode(sourceInfo, forKey: "source_info")
		}
		if sourceIp != nil{
			aCoder.encode(sourceIp, forKey: "source_ip")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if titleName != nil{
			aCoder.encode(titleName, forKey: "title_name")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
