//
//	SlotGroup.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class SlotGroup : NSObject, NSCoding{

	var createdAt : String!
	var fromTimeSlot1 : String!
	var fromTimeSlot2 : String!
	var fromTimeSlot3 : String!
	var fromTimeSlot4 : String!
	var fromTimeSlot5 : String!
	var fromTimeSlot6 : String!
	var fromTimeSlot7 : String!
	var fromTimeSlot8 : String!
	var id : Int!
	var shiftOrTimeModel : String!
	var slotCount : Int!
	var slotGroup : String!
	var toTimeSlot1 : String!
	var toTimeSlot2 : String!
	var toTimeSlot3 : String!
	var toTimeSlot4 : String!
	var toTimeSlot5 : String!
	var toTimeSlot6 : String!
	var toTimeSlot7 : String!
	var toTimeSlot8 : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		fromTimeSlot1 = json["from_time_slot_1"].stringValue
		fromTimeSlot2 = json["from_time_slot_2"].stringValue
		fromTimeSlot3 = json["from_time_slot_3"].stringValue
		fromTimeSlot4 = json["from_time_slot_4"].stringValue
		fromTimeSlot5 = json["from_time_slot_5"].stringValue
		fromTimeSlot6 = json["from_time_slot_6"].stringValue
		fromTimeSlot7 = json["from_time_slot_7"].stringValue
		fromTimeSlot8 = json["from_time_slot_8"].stringValue
		id = json["id"].intValue
		shiftOrTimeModel = json["shift_or_time_model"].stringValue
		slotCount = json["slot_count"].intValue
		slotGroup = json["slot_group"].stringValue
		toTimeSlot1 = json["to_time_slot_1"].stringValue
		toTimeSlot2 = json["to_time_slot_2"].stringValue
		toTimeSlot3 = json["to_time_slot_3"].stringValue
		toTimeSlot4 = json["to_time_slot_4"].stringValue
		toTimeSlot5 = json["to_time_slot_5"].stringValue
		toTimeSlot6 = json["to_time_slot_6"].stringValue
		toTimeSlot7 = json["to_time_slot_7"].stringValue
		toTimeSlot8 = json["to_time_slot_8"].stringValue
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
		if fromTimeSlot1 != nil{
			dictionary["from_time_slot_1"] = fromTimeSlot1
		}
		if fromTimeSlot2 != nil{
			dictionary["from_time_slot_2"] = fromTimeSlot2
		}
		if fromTimeSlot3 != nil{
			dictionary["from_time_slot_3"] = fromTimeSlot3
		}
		if fromTimeSlot4 != nil{
			dictionary["from_time_slot_4"] = fromTimeSlot4
		}
		if fromTimeSlot5 != nil{
			dictionary["from_time_slot_5"] = fromTimeSlot5
		}
		if fromTimeSlot6 != nil{
			dictionary["from_time_slot_6"] = fromTimeSlot6
		}
		if fromTimeSlot7 != nil{
			dictionary["from_time_slot_7"] = fromTimeSlot7
		}
		if fromTimeSlot8 != nil{
			dictionary["from_time_slot_8"] = fromTimeSlot8
		}
		if id != nil{
			dictionary["id"] = id
		}
		if shiftOrTimeModel != nil{
			dictionary["shift_or_time_model"] = shiftOrTimeModel
		}
		if slotCount != nil{
			dictionary["slot_count"] = slotCount
		}
		if slotGroup != nil{
			dictionary["slot_group"] = slotGroup
		}
		if toTimeSlot1 != nil{
			dictionary["to_time_slot_1"] = toTimeSlot1
		}
		if toTimeSlot2 != nil{
			dictionary["to_time_slot_2"] = toTimeSlot2
		}
		if toTimeSlot3 != nil{
			dictionary["to_time_slot_3"] = toTimeSlot3
		}
		if toTimeSlot4 != nil{
			dictionary["to_time_slot_4"] = toTimeSlot4
		}
		if toTimeSlot5 != nil{
			dictionary["to_time_slot_5"] = toTimeSlot5
		}
		if toTimeSlot6 != nil{
			dictionary["to_time_slot_6"] = toTimeSlot6
		}
		if toTimeSlot7 != nil{
			dictionary["to_time_slot_7"] = toTimeSlot7
		}
		if toTimeSlot8 != nil{
			dictionary["to_time_slot_8"] = toTimeSlot8
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
         fromTimeSlot1 = aDecoder.decodeObject(forKey: "from_time_slot_1") as? String
         fromTimeSlot2 = aDecoder.decodeObject(forKey: "from_time_slot_2") as? String
         fromTimeSlot3 = aDecoder.decodeObject(forKey: "from_time_slot_3") as? String
         fromTimeSlot4 = aDecoder.decodeObject(forKey: "from_time_slot_4") as? String
         fromTimeSlot5 = aDecoder.decodeObject(forKey: "from_time_slot_5") as? String
         fromTimeSlot6 = aDecoder.decodeObject(forKey: "from_time_slot_6") as? String
         fromTimeSlot7 = aDecoder.decodeObject(forKey: "from_time_slot_7") as? String
         fromTimeSlot8 = aDecoder.decodeObject(forKey: "from_time_slot_8") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         shiftOrTimeModel = aDecoder.decodeObject(forKey: "shift_or_time_model") as? String
         slotCount = aDecoder.decodeObject(forKey: "slot_count") as? Int
         slotGroup = aDecoder.decodeObject(forKey: "slot_group") as? String
         toTimeSlot1 = aDecoder.decodeObject(forKey: "to_time_slot_1") as? String
         toTimeSlot2 = aDecoder.decodeObject(forKey: "to_time_slot_2") as? String
         toTimeSlot3 = aDecoder.decodeObject(forKey: "to_time_slot_3") as? String
         toTimeSlot4 = aDecoder.decodeObject(forKey: "to_time_slot_4") as? String
         toTimeSlot5 = aDecoder.decodeObject(forKey: "to_time_slot_5") as? String
         toTimeSlot6 = aDecoder.decodeObject(forKey: "to_time_slot_6") as? String
         toTimeSlot7 = aDecoder.decodeObject(forKey: "to_time_slot_7") as? String
         toTimeSlot8 = aDecoder.decodeObject(forKey: "to_time_slot_8") as? String
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
		if fromTimeSlot1 != nil{
			aCoder.encode(fromTimeSlot1, forKey: "from_time_slot_1")
		}
		if fromTimeSlot2 != nil{
			aCoder.encode(fromTimeSlot2, forKey: "from_time_slot_2")
		}
		if fromTimeSlot3 != nil{
			aCoder.encode(fromTimeSlot3, forKey: "from_time_slot_3")
		}
		if fromTimeSlot4 != nil{
			aCoder.encode(fromTimeSlot4, forKey: "from_time_slot_4")
		}
		if fromTimeSlot5 != nil{
			aCoder.encode(fromTimeSlot5, forKey: "from_time_slot_5")
		}
		if fromTimeSlot6 != nil{
			aCoder.encode(fromTimeSlot6, forKey: "from_time_slot_6")
		}
		if fromTimeSlot7 != nil{
			aCoder.encode(fromTimeSlot7, forKey: "from_time_slot_7")
		}
		if fromTimeSlot8 != nil{
			aCoder.encode(fromTimeSlot8, forKey: "from_time_slot_8")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if shiftOrTimeModel != nil{
			aCoder.encode(shiftOrTimeModel, forKey: "shift_or_time_model")
		}
		if slotCount != nil{
			aCoder.encode(slotCount, forKey: "slot_count")
		}
		if slotGroup != nil{
			aCoder.encode(slotGroup, forKey: "slot_group")
		}
		if toTimeSlot1 != nil{
			aCoder.encode(toTimeSlot1, forKey: "to_time_slot_1")
		}
		if toTimeSlot2 != nil{
			aCoder.encode(toTimeSlot2, forKey: "to_time_slot_2")
		}
		if toTimeSlot3 != nil{
			aCoder.encode(toTimeSlot3, forKey: "to_time_slot_3")
		}
		if toTimeSlot4 != nil{
			aCoder.encode(toTimeSlot4, forKey: "to_time_slot_4")
		}
		if toTimeSlot5 != nil{
			aCoder.encode(toTimeSlot5, forKey: "to_time_slot_5")
		}
		if toTimeSlot6 != nil{
			aCoder.encode(toTimeSlot6, forKey: "to_time_slot_6")
		}
		if toTimeSlot7 != nil{
			aCoder.encode(toTimeSlot7, forKey: "to_time_slot_7")
		}
		if toTimeSlot8 != nil{
			aCoder.encode(toTimeSlot8, forKey: "to_time_slot_8")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
