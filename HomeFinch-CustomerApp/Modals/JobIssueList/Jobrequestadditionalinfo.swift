//
//	Jobrequestadditionalinfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Jobrequestadditionalinfo : NSObject, NSCoding{
    
    var actualExecutionTime : String!
    var actualInspectionTime : String!
    var actualMaterialProcurementTime : String!
    var actualTravelTime : String!
    var additionalSuForHelp : String!
    var assignedSu1Name : String!
    var assignedSu2Name : String!
    var assignedSu3Name : String!
    var cacellationReason : String!
    var cacellationRemarks : String!
    var createdAt : String!
    var createdBy : String!
    var estimatedExecutionTime : String!
    var estimatedInspectionTime : String!
    var estimatedMaterialProcurementTime : String!
    var estimatedTravelTime : String!
    var executionDateTime : String!
    var id : Int!
    var internalRatings1 : String!
    var internalRatings2 : String!
    var internalRatings3 : String!
    var internalRatings4 : String!
    var internalRemarks : String!
    var jobRequestId : Int!
    var jobScheduleDateTime : String!
    var overallRatingByCustomer : String!
    var ratingsByTechnician : String!
    var ratingsType : String!
    var remarksByCustomer : String!
    var remarksByTechnician : String!
    var schedulingDiscount : String!
    var signature : String!
    var slotId : Int!
    var slotTime : String!
    var su1AssignChangeTrigger : String!
    var su1AssignDateTime : String!
    var su2AssignChangeTrigger : String!
    var su2AssignDateTime : String!
    var su3AssignChangeTrigger : String!
    var su3AssignDateTime : String!
    var updatedAt : String!
    var updatedBy : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        actualExecutionTime = json["actual_execution_time"].stringValue
        actualInspectionTime = json["actual_inspection_time"].stringValue
        actualMaterialProcurementTime = json["actual_material_procurement_time"].stringValue
        actualTravelTime = json["actual_travel_time"].stringValue
        additionalSuForHelp = json["additional_su_for_help"].stringValue
        assignedSu1Name = json["assigned_su1_name"].stringValue
        assignedSu2Name = json["assigned_su2_name"].stringValue
        assignedSu3Name = json["assigned_su3_name"].stringValue
        cacellationReason = json["cacellation_reason"].stringValue
        cacellationRemarks = json["cacellation_remarks"].stringValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].stringValue
        estimatedExecutionTime = json["estimated_execution_time"].stringValue
        estimatedInspectionTime = json["estimated_inspection_time"].stringValue
        estimatedMaterialProcurementTime = json["estimated_material_procurement_time"].stringValue
        estimatedTravelTime = json["estimated_travel_time"].stringValue
        executionDateTime = json["execution_date_time"].stringValue
        id = json["id"].intValue
        internalRatings1 = json["internal_ratings_1"].stringValue
        internalRatings2 = json["internal_ratings_2"].stringValue
        internalRatings3 = json["internal_ratings_3"].stringValue
        internalRatings4 = json["internal_ratings_4"].stringValue
        internalRemarks = json["internal_remarks"].stringValue
        jobRequestId = json["job_request_id"].intValue
        jobScheduleDateTime = json["job_schedule_date_time"].stringValue
        overallRatingByCustomer = json["overall_rating_by_customer"].stringValue
        ratingsByTechnician = json["ratings_by_technician"].stringValue
        ratingsType = json["ratings_type"].stringValue
        remarksByCustomer = json["remarks_by_customer"].stringValue
        remarksByTechnician = json["remarks_by_technician"].stringValue
        schedulingDiscount = json["scheduling_discount"].stringValue
        signature = json["signature"].stringValue
        slotId = json["slot_id"].intValue
        slotTime = json["slot_time"].stringValue
        su1AssignChangeTrigger = json["su1_assign_change_trigger"].stringValue
        su1AssignDateTime = json["su1_assign_date_time"].stringValue
        su2AssignChangeTrigger = json["su2_assign_change_trigger"].stringValue
        su2AssignDateTime = json["su2_assign_date_time"].stringValue
        su3AssignChangeTrigger = json["su3_assign_change_trigger"].stringValue
        su3AssignDateTime = json["su3_assign_date_time"].stringValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if actualExecutionTime != nil{
            dictionary["actual_execution_time"] = actualExecutionTime
        }
        if actualInspectionTime != nil{
            dictionary["actual_inspection_time"] = actualInspectionTime
        }
        if actualMaterialProcurementTime != nil{
            dictionary["actual_material_procurement_time"] = actualMaterialProcurementTime
        }
        if actualTravelTime != nil{
            dictionary["actual_travel_time"] = actualTravelTime
        }
        if additionalSuForHelp != nil{
            dictionary["additional_su_for_help"] = additionalSuForHelp
        }
        if assignedSu1Name != nil{
            dictionary["assigned_su1_name"] = assignedSu1Name
        }
        if assignedSu2Name != nil{
            dictionary["assigned_su2_name"] = assignedSu2Name
        }
        if assignedSu3Name != nil{
            dictionary["assigned_su3_name"] = assignedSu3Name
        }
        if cacellationReason != nil{
            dictionary["cacellation_reason"] = cacellationReason
        }
        if cacellationRemarks != nil{
            dictionary["cacellation_remarks"] = cacellationRemarks
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if estimatedExecutionTime != nil{
            dictionary["estimated_execution_time"] = estimatedExecutionTime
        }
        if estimatedInspectionTime != nil{
            dictionary["estimated_inspection_time"] = estimatedInspectionTime
        }
        if estimatedMaterialProcurementTime != nil{
            dictionary["estimated_material_procurement_time"] = estimatedMaterialProcurementTime
        }
        if estimatedTravelTime != nil{
            dictionary["estimated_travel_time"] = estimatedTravelTime
        }
        if executionDateTime != nil{
            dictionary["execution_date_time"] = executionDateTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if internalRatings1 != nil{
            dictionary["internal_ratings_1"] = internalRatings1
        }
        if internalRatings2 != nil{
            dictionary["internal_ratings_2"] = internalRatings2
        }
        if internalRatings3 != nil{
            dictionary["internal_ratings_3"] = internalRatings3
        }
        if internalRatings4 != nil{
            dictionary["internal_ratings_4"] = internalRatings4
        }
        if internalRemarks != nil{
            dictionary["internal_remarks"] = internalRemarks
        }
        if jobRequestId != nil{
            dictionary["job_request_id"] = jobRequestId
        }
        if jobScheduleDateTime != nil{
            dictionary["job_schedule_date_time"] = jobScheduleDateTime
        }
        if overallRatingByCustomer != nil{
            dictionary["overall_rating_by_customer"] = overallRatingByCustomer
        }
        if ratingsByTechnician != nil{
            dictionary["ratings_by_technician"] = ratingsByTechnician
        }
        if ratingsType != nil{
            dictionary["ratings_type"] = ratingsType
        }
        if remarksByCustomer != nil{
            dictionary["remarks_by_customer"] = remarksByCustomer
        }
        if remarksByTechnician != nil{
            dictionary["remarks_by_technician"] = remarksByTechnician
        }
        if schedulingDiscount != nil{
            dictionary["scheduling_discount"] = schedulingDiscount
        }
        if signature != nil{
            dictionary["signature"] = signature
        }
        if slotId != nil{
            dictionary["slot_id"] = slotId
        }
        if slotTime != nil{
            dictionary["slot_time"] = slotTime
        }
        if su1AssignChangeTrigger != nil{
            dictionary["su1_assign_change_trigger"] = su1AssignChangeTrigger
        }
        if su1AssignDateTime != nil{
            dictionary["su1_assign_date_time"] = su1AssignDateTime
        }
        if su2AssignChangeTrigger != nil{
            dictionary["su2_assign_change_trigger"] = su2AssignChangeTrigger
        }
        if su2AssignDateTime != nil{
            dictionary["su2_assign_date_time"] = su2AssignDateTime
        }
        if su3AssignChangeTrigger != nil{
            dictionary["su3_assign_change_trigger"] = su3AssignChangeTrigger
        }
        if su3AssignDateTime != nil{
            dictionary["su3_assign_date_time"] = su3AssignDateTime
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if updatedBy != nil{
            dictionary["updated_by"] = updatedBy
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         actualExecutionTime = aDecoder.decodeObject(forKey: "actual_execution_time") as? String
         actualInspectionTime = aDecoder.decodeObject(forKey: "actual_inspection_time") as? String
         actualMaterialProcurementTime = aDecoder.decodeObject(forKey: "actual_material_procurement_time") as? String
         actualTravelTime = aDecoder.decodeObject(forKey: "actual_travel_time") as? String
         additionalSuForHelp = aDecoder.decodeObject(forKey: "additional_su_for_help") as? String
         assignedSu1Name = aDecoder.decodeObject(forKey: "assigned_su1_name") as? String
         assignedSu2Name = aDecoder.decodeObject(forKey: "assigned_su2_name") as? String
         assignedSu3Name = aDecoder.decodeObject(forKey: "assigned_su3_name") as? String
         cacellationReason = aDecoder.decodeObject(forKey: "cacellation_reason") as? String
         cacellationRemarks = aDecoder.decodeObject(forKey: "cacellation_remarks") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         createdBy = aDecoder.decodeObject(forKey: "created_by") as? String
         estimatedExecutionTime = aDecoder.decodeObject(forKey: "estimated_execution_time") as? String
         estimatedInspectionTime = aDecoder.decodeObject(forKey: "estimated_inspection_time") as? String
         estimatedMaterialProcurementTime = aDecoder.decodeObject(forKey: "estimated_material_procurement_time") as? String
         estimatedTravelTime = aDecoder.decodeObject(forKey: "estimated_travel_time") as? String
         executionDateTime = aDecoder.decodeObject(forKey: "execution_date_time") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         internalRatings1 = aDecoder.decodeObject(forKey: "internal_ratings_1") as? String
         internalRatings2 = aDecoder.decodeObject(forKey: "internal_ratings_2") as? String
         internalRatings3 = aDecoder.decodeObject(forKey: "internal_ratings_3") as? String
         internalRatings4 = aDecoder.decodeObject(forKey: "internal_ratings_4") as? String
         internalRemarks = aDecoder.decodeObject(forKey: "internal_remarks") as? String
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         jobScheduleDateTime = aDecoder.decodeObject(forKey: "job_schedule_date_time") as? String
         overallRatingByCustomer = aDecoder.decodeObject(forKey: "overall_rating_by_customer") as? String
         ratingsByTechnician = aDecoder.decodeObject(forKey: "ratings_by_technician") as? String
         ratingsType = aDecoder.decodeObject(forKey: "ratings_type") as? String
         remarksByCustomer = aDecoder.decodeObject(forKey: "remarks_by_customer") as? String
         remarksByTechnician = aDecoder.decodeObject(forKey: "remarks_by_technician") as? String
         schedulingDiscount = aDecoder.decodeObject(forKey: "scheduling_discount") as? String
         signature = aDecoder.decodeObject(forKey: "signature") as? String
         slotId = aDecoder.decodeObject(forKey: "slot_id") as? Int
         slotTime = aDecoder.decodeObject(forKey: "slot_time") as? String
         su1AssignChangeTrigger = aDecoder.decodeObject(forKey: "su1_assign_change_trigger") as? String
         su1AssignDateTime = aDecoder.decodeObject(forKey: "su1_assign_date_time") as? String
         su2AssignChangeTrigger = aDecoder.decodeObject(forKey: "su2_assign_change_trigger") as? String
         su2AssignDateTime = aDecoder.decodeObject(forKey: "su2_assign_date_time") as? String
         su3AssignChangeTrigger = aDecoder.decodeObject(forKey: "su3_assign_change_trigger") as? String
         su3AssignDateTime = aDecoder.decodeObject(forKey: "su3_assign_date_time") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if actualExecutionTime != nil{
            aCoder.encode(actualExecutionTime, forKey: "actual_execution_time")
        }
        if actualInspectionTime != nil{
            aCoder.encode(actualInspectionTime, forKey: "actual_inspection_time")
        }
        if actualMaterialProcurementTime != nil{
            aCoder.encode(actualMaterialProcurementTime, forKey: "actual_material_procurement_time")
        }
        if actualTravelTime != nil{
            aCoder.encode(actualTravelTime, forKey: "actual_travel_time")
        }
        if additionalSuForHelp != nil{
            aCoder.encode(additionalSuForHelp, forKey: "additional_su_for_help")
        }
        if assignedSu1Name != nil{
            aCoder.encode(assignedSu1Name, forKey: "assigned_su1_name")
        }
        if assignedSu2Name != nil{
            aCoder.encode(assignedSu2Name, forKey: "assigned_su2_name")
        }
        if assignedSu3Name != nil{
            aCoder.encode(assignedSu3Name, forKey: "assigned_su3_name")
        }
        if cacellationReason != nil{
            aCoder.encode(cacellationReason, forKey: "cacellation_reason")
        }
        if cacellationRemarks != nil{
            aCoder.encode(cacellationRemarks, forKey: "cacellation_remarks")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if estimatedExecutionTime != nil{
            aCoder.encode(estimatedExecutionTime, forKey: "estimated_execution_time")
        }
        if estimatedInspectionTime != nil{
            aCoder.encode(estimatedInspectionTime, forKey: "estimated_inspection_time")
        }
        if estimatedMaterialProcurementTime != nil{
            aCoder.encode(estimatedMaterialProcurementTime, forKey: "estimated_material_procurement_time")
        }
        if estimatedTravelTime != nil{
            aCoder.encode(estimatedTravelTime, forKey: "estimated_travel_time")
        }
        if executionDateTime != nil{
            aCoder.encode(executionDateTime, forKey: "execution_date_time")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if internalRatings1 != nil{
            aCoder.encode(internalRatings1, forKey: "internal_ratings_1")
        }
        if internalRatings2 != nil{
            aCoder.encode(internalRatings2, forKey: "internal_ratings_2")
        }
        if internalRatings3 != nil{
            aCoder.encode(internalRatings3, forKey: "internal_ratings_3")
        }
        if internalRatings4 != nil{
            aCoder.encode(internalRatings4, forKey: "internal_ratings_4")
        }
        if internalRemarks != nil{
            aCoder.encode(internalRemarks, forKey: "internal_remarks")
        }
        if jobRequestId != nil{
            aCoder.encode(jobRequestId, forKey: "job_request_id")
        }
        if jobScheduleDateTime != nil{
            aCoder.encode(jobScheduleDateTime, forKey: "job_schedule_date_time")
        }
        if overallRatingByCustomer != nil{
            aCoder.encode(overallRatingByCustomer, forKey: "overall_rating_by_customer")
        }
        if ratingsByTechnician != nil{
            aCoder.encode(ratingsByTechnician, forKey: "ratings_by_technician")
        }
        if ratingsType != nil{
            aCoder.encode(ratingsType, forKey: "ratings_type")
        }
        if remarksByCustomer != nil{
            aCoder.encode(remarksByCustomer, forKey: "remarks_by_customer")
        }
        if remarksByTechnician != nil{
            aCoder.encode(remarksByTechnician, forKey: "remarks_by_technician")
        }
        if schedulingDiscount != nil{
            aCoder.encode(schedulingDiscount, forKey: "scheduling_discount")
        }
        if signature != nil{
            aCoder.encode(signature, forKey: "signature")
        }
        if slotId != nil{
            aCoder.encode(slotId, forKey: "slot_id")
        }
        if slotTime != nil{
            aCoder.encode(slotTime, forKey: "slot_time")
        }
        if su1AssignChangeTrigger != nil{
            aCoder.encode(su1AssignChangeTrigger, forKey: "su1_assign_change_trigger")
        }
        if su1AssignDateTime != nil{
            aCoder.encode(su1AssignDateTime, forKey: "su1_assign_date_time")
        }
        if su2AssignChangeTrigger != nil{
            aCoder.encode(su2AssignChangeTrigger, forKey: "su2_assign_change_trigger")
        }
        if su2AssignDateTime != nil{
            aCoder.encode(su2AssignDateTime, forKey: "su2_assign_date_time")
        }
        if su3AssignChangeTrigger != nil{
            aCoder.encode(su3AssignChangeTrigger, forKey: "su3_assign_change_trigger")
        }
        if su3AssignDateTime != nil{
            aCoder.encode(su3AssignDateTime, forKey: "su3_assign_date_time")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if updatedBy != nil{
            aCoder.encode(updatedBy, forKey: "updated_by")
        }

    }

}
