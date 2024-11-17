//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class TimeSlot : NSObject, NSCoding{
    
    var aqFixNowAllocated : String!
    var aqFixNowTotal : String!
    var aqFixNowUnallocated : String!
    var aqScheduledAllocated : String!
    var aqScheduledTotal : String!
    var aqScheduledUnallocated : String!
    var aqTotal : String!
    var availableEmployee : Int!
    var blockedByCustomer : Int!
    var blockedTime : String!
    var createdAt : String!
    var estimatedTotalJobTime : String!
    var fixNowMargin : String!
    var highDemandUtilization : Bool!
    var id : Int!
    var locationId : Int!
    var otherSkillId : Int!
    var primarySkillId : Int!
    var scheduleMargin : String!
    var slotDate : String!
    var slotFull : Bool!
    var slotTime : String!
    var slotTimeEnd : String!
    var slotTimeStart : String!
    var slotUtilization : Int!
    var subsequentSlotId : String!
    var updatedAt : String!

    var isselected : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        aqFixNowAllocated = json["aq_fix_now_allocated"].stringValue
        aqFixNowTotal = json["aq_fix_now_total"].stringValue
        aqFixNowUnallocated = json["aq_fix_now_unallocated"].stringValue
        aqScheduledAllocated = json["aq_scheduled_allocated"].stringValue
        aqScheduledTotal = json["aq_scheduled_total"].stringValue
        aqScheduledUnallocated = json["aq_scheduled_unallocated"].stringValue
        aqTotal = json["aq_total"].stringValue
        availableEmployee = json["available_employee"].intValue
        blockedByCustomer = json["blocked_by_customer"].intValue
        blockedTime = json["blocked_time"].stringValue
        createdAt = json["created_at"].stringValue
        estimatedTotalJobTime = json["estimated_total_job_time"].stringValue
        fixNowMargin = json["fix_now_margin"].stringValue
        highDemandUtilization = json["high_demand_utilization"].boolValue
        id = json["id"].intValue
        locationId = json["location_id"].intValue
        otherSkillId = json["other_skill_id"].intValue
        primarySkillId = json["primary_skill_id"].intValue
        scheduleMargin = json["schedule_margin"].stringValue
        slotDate = json["slot_date"].stringValue
        slotFull = json["slot_full"].boolValue
        slotTime = json["slot_time"].stringValue
        slotTimeEnd = json["slot_time_end"].stringValue
        slotTimeStart = json["slot_time_start"].stringValue
        slotUtilization = json["slot_utilization"].intValue
        subsequentSlotId = json["subsequent_slot_id"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if aqFixNowAllocated != nil{
            dictionary["aq_fix_now_allocated"] = aqFixNowAllocated
        }
        if aqFixNowTotal != nil{
            dictionary["aq_fix_now_total"] = aqFixNowTotal
        }
        if aqFixNowUnallocated != nil{
            dictionary["aq_fix_now_unallocated"] = aqFixNowUnallocated
        }
        if aqScheduledAllocated != nil{
            dictionary["aq_scheduled_allocated"] = aqScheduledAllocated
        }
        if aqScheduledTotal != nil{
            dictionary["aq_scheduled_total"] = aqScheduledTotal
        }
        if aqScheduledUnallocated != nil{
            dictionary["aq_scheduled_unallocated"] = aqScheduledUnallocated
        }
        if aqTotal != nil{
            dictionary["aq_total"] = aqTotal
        }
        if availableEmployee != nil{
            dictionary["available_employee"] = availableEmployee
        }
        if blockedByCustomer != nil{
            dictionary["blocked_by_customer"] = blockedByCustomer
        }
        if blockedTime != nil{
            dictionary["blocked_time"] = blockedTime
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if estimatedTotalJobTime != nil{
            dictionary["estimated_total_job_time"] = estimatedTotalJobTime
        }
        if fixNowMargin != nil{
            dictionary["fix_now_margin"] = fixNowMargin
        }
        if highDemandUtilization != nil{
            dictionary["high_demand_utilization"] = highDemandUtilization
        }
        if id != nil{
            dictionary["id"] = id
        }
        if locationId != nil{
            dictionary["location_id"] = locationId
        }
        if otherSkillId != nil{
            dictionary["other_skill_id"] = otherSkillId
        }
        if primarySkillId != nil{
            dictionary["primary_skill_id"] = primarySkillId
        }
        if scheduleMargin != nil{
            dictionary["schedule_margin"] = scheduleMargin
        }
        if slotDate != nil{
            dictionary["slot_date"] = slotDate
        }
        if slotFull != nil{
            dictionary["slot_full"] = slotFull
        }
        if slotTime != nil{
            dictionary["slot_time"] = slotTime
        }
        if slotTimeEnd != nil{
            dictionary["slot_time_end"] = slotTimeEnd
        }
        if slotTimeStart != nil{
            dictionary["slot_time_start"] = slotTimeStart
        }
        if slotUtilization != nil{
            dictionary["slot_utilization"] = slotUtilization
        }
        if subsequentSlotId != nil{
            dictionary["subsequent_slot_id"] = subsequentSlotId
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
         aqFixNowAllocated = aDecoder.decodeObject(forKey: "aq_fix_now_allocated") as? String
         aqFixNowTotal = aDecoder.decodeObject(forKey: "aq_fix_now_total") as? String
         aqFixNowUnallocated = aDecoder.decodeObject(forKey: "aq_fix_now_unallocated") as? String
         aqScheduledAllocated = aDecoder.decodeObject(forKey: "aq_scheduled_allocated") as? String
         aqScheduledTotal = aDecoder.decodeObject(forKey: "aq_scheduled_total") as? String
         aqScheduledUnallocated = aDecoder.decodeObject(forKey: "aq_scheduled_unallocated") as? String
         aqTotal = aDecoder.decodeObject(forKey: "aq_total") as? String
         availableEmployee = aDecoder.decodeObject(forKey: "available_employee") as? Int
         blockedByCustomer = aDecoder.decodeObject(forKey: "blocked_by_customer") as? Int
         blockedTime = aDecoder.decodeObject(forKey: "blocked_time") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         estimatedTotalJobTime = aDecoder.decodeObject(forKey: "estimated_total_job_time") as? String
         fixNowMargin = aDecoder.decodeObject(forKey: "fix_now_margin") as? String
         highDemandUtilization = aDecoder.decodeObject(forKey: "high_demand_utilization") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? Int
         locationId = aDecoder.decodeObject(forKey: "location_id") as? Int
         otherSkillId = aDecoder.decodeObject(forKey: "other_skill_id") as? Int
         primarySkillId = aDecoder.decodeObject(forKey: "primary_skill_id") as? Int
         scheduleMargin = aDecoder.decodeObject(forKey: "schedule_margin") as? String
         slotDate = aDecoder.decodeObject(forKey: "slot_date") as? String
         slotFull = aDecoder.decodeObject(forKey: "slot_full") as? Bool
         slotTime = aDecoder.decodeObject(forKey: "slot_time") as? String
         slotTimeEnd = aDecoder.decodeObject(forKey: "slot_time_end") as? String
         slotTimeStart = aDecoder.decodeObject(forKey: "slot_time_start") as? String
         slotUtilization = aDecoder.decodeObject(forKey: "slot_utilization") as? Int
         subsequentSlotId = aDecoder.decodeObject(forKey: "subsequent_slot_id") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if aqFixNowAllocated != nil{
            aCoder.encode(aqFixNowAllocated, forKey: "aq_fix_now_allocated")
        }
        if aqFixNowTotal != nil{
            aCoder.encode(aqFixNowTotal, forKey: "aq_fix_now_total")
        }
        if aqFixNowUnallocated != nil{
            aCoder.encode(aqFixNowUnallocated, forKey: "aq_fix_now_unallocated")
        }
        if aqScheduledAllocated != nil{
            aCoder.encode(aqScheduledAllocated, forKey: "aq_scheduled_allocated")
        }
        if aqScheduledTotal != nil{
            aCoder.encode(aqScheduledTotal, forKey: "aq_scheduled_total")
        }
        if aqScheduledUnallocated != nil{
            aCoder.encode(aqScheduledUnallocated, forKey: "aq_scheduled_unallocated")
        }
        if aqTotal != nil{
            aCoder.encode(aqTotal, forKey: "aq_total")
        }
        if availableEmployee != nil{
            aCoder.encode(availableEmployee, forKey: "available_employee")
        }
        if blockedByCustomer != nil{
            aCoder.encode(blockedByCustomer, forKey: "blocked_by_customer")
        }
        if blockedTime != nil{
            aCoder.encode(blockedTime, forKey: "blocked_time")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if estimatedTotalJobTime != nil{
            aCoder.encode(estimatedTotalJobTime, forKey: "estimated_total_job_time")
        }
        if fixNowMargin != nil{
            aCoder.encode(fixNowMargin, forKey: "fix_now_margin")
        }
        if highDemandUtilization != nil{
            aCoder.encode(highDemandUtilization, forKey: "high_demand_utilization")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if locationId != nil{
            aCoder.encode(locationId, forKey: "location_id")
        }
        if otherSkillId != nil{
            aCoder.encode(otherSkillId, forKey: "other_skill_id")
        }
        if primarySkillId != nil{
            aCoder.encode(primarySkillId, forKey: "primary_skill_id")
        }
        if scheduleMargin != nil{
            aCoder.encode(scheduleMargin, forKey: "schedule_margin")
        }
        if slotDate != nil{
            aCoder.encode(slotDate, forKey: "slot_date")
        }
        if slotFull != nil{
            aCoder.encode(slotFull, forKey: "slot_full")
        }
        if slotTime != nil{
            aCoder.encode(slotTime, forKey: "slot_time")
        }
        if slotTimeEnd != nil{
            aCoder.encode(slotTimeEnd, forKey: "slot_time_end")
        }
        if slotTimeStart != nil{
            aCoder.encode(slotTimeStart, forKey: "slot_time_start")
        }
        if slotUtilization != nil{
            aCoder.encode(slotUtilization, forKey: "slot_utilization")
        }
        if subsequentSlotId != nil{
            aCoder.encode(subsequentSlotId, forKey: "subsequent_slot_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
