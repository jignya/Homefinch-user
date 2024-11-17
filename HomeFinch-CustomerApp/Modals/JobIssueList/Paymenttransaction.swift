//
//	Paymenttransaction.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Paymenttransaction : NSObject, NSCoding{

	var createdAt : String!
	var customerId : Int!
	var employeeId : Int!
	var id : Int!
	var jobRequestId : Int!
	var paymentAt : String!
	var paymentLink : String!
	var paymentMode : String!
	var paymentRequestDetails : String!
	var paymentTransactionDetails : String!
	var status : String!
	var statusCode : String!
	var transactionReference : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createdAt = json["created_at"].stringValue
		customerId = json["customer_id"].intValue
		employeeId = json["employee_id"].intValue
		id = json["id"].intValue
		jobRequestId = json["job_request_id"].intValue
		paymentAt = json["payment_at"].stringValue
		paymentLink = json["payment_link"].stringValue
		paymentMode = json["payment_mode"].stringValue
		paymentRequestDetails = json["payment_request_details"].stringValue
		paymentTransactionDetails = json["payment_transaction_details"].stringValue
		status = json["status"].stringValue
		statusCode = json["status_code"].stringValue
		transactionReference = json["transaction_reference"].stringValue
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
		if customerId != nil{
			dictionary["customer_id"] = customerId
		}
		if employeeId != nil{
			dictionary["employee_id"] = employeeId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if jobRequestId != nil{
			dictionary["job_request_id"] = jobRequestId
		}
		if paymentAt != nil{
			dictionary["payment_at"] = paymentAt
		}
		if paymentLink != nil{
			dictionary["payment_link"] = paymentLink
		}
		if paymentMode != nil{
			dictionary["payment_mode"] = paymentMode
		}
		if paymentRequestDetails != nil{
			dictionary["payment_request_details"] = paymentRequestDetails
		}
		if paymentTransactionDetails != nil{
			dictionary["payment_transaction_details"] = paymentTransactionDetails
		}
		if status != nil{
			dictionary["status"] = status
		}
		if statusCode != nil{
			dictionary["status_code"] = statusCode
		}
		if transactionReference != nil{
			dictionary["transaction_reference"] = transactionReference
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
         customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
         employeeId = aDecoder.decodeObject(forKey: "employee_id") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
         paymentAt = aDecoder.decodeObject(forKey: "payment_at") as? String
         paymentLink = aDecoder.decodeObject(forKey: "payment_link") as? String
         paymentMode = aDecoder.decodeObject(forKey: "payment_mode") as? String
         paymentRequestDetails = aDecoder.decodeObject(forKey: "payment_request_details") as? String
         paymentTransactionDetails = aDecoder.decodeObject(forKey: "payment_transaction_details") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         statusCode = aDecoder.decodeObject(forKey: "status_code") as? String
         transactionReference = aDecoder.decodeObject(forKey: "transaction_reference") as? String
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
		if customerId != nil{
			aCoder.encode(customerId, forKey: "customer_id")
		}
		if employeeId != nil{
			aCoder.encode(employeeId, forKey: "employee_id")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if jobRequestId != nil{
			aCoder.encode(jobRequestId, forKey: "job_request_id")
		}
		if paymentAt != nil{
			aCoder.encode(paymentAt, forKey: "payment_at")
		}
		if paymentLink != nil{
			aCoder.encode(paymentLink, forKey: "payment_link")
		}
		if paymentMode != nil{
			aCoder.encode(paymentMode, forKey: "payment_mode")
		}
		if paymentRequestDetails != nil{
			aCoder.encode(paymentRequestDetails, forKey: "payment_request_details")
		}
		if paymentTransactionDetails != nil{
			aCoder.encode(paymentTransactionDetails, forKey: "payment_transaction_details")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if statusCode != nil{
			aCoder.encode(statusCode, forKey: "status_code")
		}
		if transactionReference != nil{
			aCoder.encode(transactionReference, forKey: "transaction_reference")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}
