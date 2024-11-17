//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class JobIssueList : NSObject, NSCoding{
    
    var confirmed : Int!
    var createdAt : String!
    var createdBy : Int!
    var currencyCode : String!
    var discount : String!
    var discountPercentage : String!
    var extraHours : String!
    var goodwillPercentage : String!
    var id : Int!
    var isExtra : Int!
    var jobRequestId : Int!
    var jobRequestItemId : Int!
    var jobrequestitem : Jobrequestitem!
    var jobservice : Jobservice!
    var materialName : String!
    var materialPrice : String!
    var materialQuantity : String!
    var materialTotalPrice : String!
    var recommended : Int!
    var referenceId : Int!
    var serviceId : Int!
    var type : Int!
    var updatedAt : String!
    var updatedBy : String!
    var warrantyEndDate : String!
    var warrantyPercentage : String!
    var additinalComment : String!
    var appVersion : String!
    var customerData : CustomerData!
    var customerId : Int!
    var customerMobile : String!
    var customerName : String!
    var distributionChannel : String!
    var employeeData : EmployeeData!
    var employeeId : Int!
    var endDate : String!
    var expectedValue : String!
    var enableSelectSlotSkip : String!
    var issueCount : Int!
    var jobQuotationData : [JobQuotationData]!
    var jobattachments : [Jobattachment]!
    var jobotherservices : [Jobotherservice]!
    var jobquote : Jobquote!
    var jobrequestadditionalinfo : Jobrequestadditionalinfo!
    var jobrequestitems : [Jobrequestitem]!
    var paymenttransaction : [Paymenttransaction]!
    var priority : String!
    var propertyData : PropertyData!
    var propertyId : Int!
    var registeredProductId : String!
    var requestedMaterials : [RequestedMaterial]!
    var salesUnit : String!
    var sourceFrom : Int!
    var sourceInfo : String!
    var sourceIp : String!
    var startDate : String!
    var status : Int!
    var subStatus : Int!
    var successPercentage : String!
    var title : String!
    var vatPercentage : Int!
    var webStatus : String!
    var skipGeneratePaymentLink : String!
    var slotSkipped : Int!

    
    override init() {
        
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        confirmed = json["confirmed"].intValue
        createdAt = json["created_at"].stringValue
        createdBy = json["created_by"].intValue
        currencyCode = json["currency_code"].stringValue
        discount = json["discount"].stringValue
        discountPercentage = json["discount_percentage"].stringValue
        extraHours = json["extra_hours"].stringValue
        goodwillPercentage = json["goodwill_percentage"].stringValue
        id = json["id"].intValue
        isExtra = json["is_extra"].intValue
        jobRequestId = json["job_request_id"].intValue
        jobRequestItemId = json["job_request_item_id"].intValue
        let jobrequestitemsJson = json["jobrequestitems"]
        if !jobrequestitemsJson.isEmpty{
            jobrequestitem = Jobrequestitem(fromJson: jobrequestitemsJson)
        }
        let jobserviceJson = json["jobservice"]
        if !jobserviceJson.isEmpty{
            jobservice = Jobservice(fromJson: jobserviceJson)
        }
        materialName = json["material_name"].stringValue
        materialPrice = json["material_price"].stringValue
        materialQuantity = json["material_quantity"].stringValue
        materialTotalPrice = json["material_total_price"].stringValue
        recommended = json["recommended"].intValue
        referenceId = json["reference_id"].intValue
        serviceId = json["service_id"].intValue
        type = json["type"].intValue
        updatedAt = json["updated_at"].stringValue
        updatedBy = json["updated_by"].stringValue
        warrantyEndDate = json["warranty_end_date"].stringValue
        warrantyPercentage = json["warranty_percentage"].stringValue
        additinalComment = json["additinal_comment"].stringValue
        appVersion = json["app_version"].stringValue
        let customerDataJson = json["customer_data"]
        if !customerDataJson.isEmpty{
            customerData = CustomerData(fromJson: customerDataJson)
        }
        customerId = json["customer_id"].intValue
        customerMobile = json["customer_mobile"].stringValue
        customerName = json["customer_name"].stringValue
        distributionChannel = json["distribution_channel"].stringValue
        let employeeDataJson = json["employee_data"]
        if !employeeDataJson.isEmpty{
            employeeData = EmployeeData(fromJson: employeeDataJson)
        }
        employeeId = json["employee_id"].intValue
        endDate = json["end_date"].stringValue
        expectedValue = json["expected_value"].stringValue
        enableSelectSlotSkip = json["enable_select_slot_skip"].stringValue
        issueCount = json["issue_count"].intValue
        jobQuotationData = [JobQuotationData]()
        let jobQuotationDataArray = json["job_quotation_data"].arrayValue
        for jobQuotationDataJson in jobQuotationDataArray{
            let value = JobQuotationData(fromJson: jobQuotationDataJson)
            jobQuotationData.append(value)
        }
        jobattachments = [Jobattachment]()
        let jobattachmentsArray = json["jobattachments"].arrayValue
        for jobattachmentsJson in jobattachmentsArray{
            let value = Jobattachment(fromJson: jobattachmentsJson)
            jobattachments.append(value)
        }
        jobotherservices = [Jobotherservice]()
        let jobotherservicesArray = json["jobotherservices"].arrayValue
        for jobotherservicesJson in jobotherservicesArray{
            let value = Jobotherservice(fromJson: jobotherservicesJson)
            jobotherservices.append(value)
        }
        let jobquoteJson = json["jobquote"]
        if !jobquoteJson.isEmpty{
            jobquote = Jobquote(fromJson: jobquoteJson)
        }
        let jobrequestadditionalinfoJson = json["jobrequestadditionalinfo"]
        if !jobrequestadditionalinfoJson.isEmpty{
            jobrequestadditionalinfo = Jobrequestadditionalinfo(fromJson: jobrequestadditionalinfoJson)
        }
        jobrequestitems = [Jobrequestitem]()
        let jobrequestitemsArray = json["jobrequestitems"].arrayValue
        for jobrequestitemsJson in jobrequestitemsArray{
            let value = Jobrequestitem(fromJson: jobrequestitemsJson)
            jobrequestitems.append(value)
        }
        paymenttransaction = [Paymenttransaction]()
        let paymenttransactionArray = json["paymenttransaction"].arrayValue
        for paymenttransactionJson in paymenttransactionArray{
            let value = Paymenttransaction(fromJson: paymenttransactionJson)
            paymenttransaction.append(value)
        }
        priority = json["priority"].stringValue
        let propertyDataJson = json["property_data"]
        if !propertyDataJson.isEmpty{
            propertyData = PropertyData(fromJson: propertyDataJson)
        }
        propertyId = json["property_id"].intValue
        registeredProductId = json["registered_product_id"].stringValue
        requestedMaterials = [RequestedMaterial]()
        let requestedMaterialsArray = json["requestedMaterials"].arrayValue
        for requestedMaterialsJson in requestedMaterialsArray{
            let value = RequestedMaterial(fromJson: requestedMaterialsJson)
            requestedMaterials.append(value)
        }
        salesUnit = json["sales_unit"].stringValue
        sourceFrom = json["source_from"].intValue
        sourceInfo = json["source_info"].stringValue
        sourceIp = json["source_ip"].stringValue
        startDate = json["start_date"].stringValue
        status = json["status"].intValue
        subStatus = json["sub_status"].intValue
        successPercentage = json["success_percentage"].stringValue
        title = json["title"].stringValue
        vatPercentage = json["vat_percentage"].intValue
        webStatus = json["web_status"].stringValue
        skipGeneratePaymentLink = json["skip_generate_payment_link"].stringValue
        slotSkipped = json["slot_skipped"].intValue

    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if confirmed != nil{
            dictionary["confirmed"] = confirmed
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if createdBy != nil{
            dictionary["created_by"] = createdBy
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if discount != nil{
            dictionary["discount"] = discount
        }
        if discountPercentage != nil{
            dictionary["discount_percentage"] = discountPercentage
        }
        if extraHours != nil{
            dictionary["extra_hours"] = extraHours
        }
        if goodwillPercentage != nil{
            dictionary["goodwill_percentage"] = goodwillPercentage
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isExtra != nil{
            dictionary["is_extra"] = isExtra
        }
        if jobRequestId != nil{
            dictionary["job_request_id"] = jobRequestId
        }
        if jobRequestItemId != nil{
            dictionary["job_request_item_id"] = jobRequestItemId
        }
        if jobrequestitems != nil{
            var dictionaryElements = [[String:Any]]()
            for jobrequestitemsElement in jobrequestitems {
                dictionaryElements.append(jobrequestitemsElement.toDictionary())
            }
            dictionary["jobrequestitems"] = dictionaryElements
        }
        if jobservice != nil{
            dictionary["jobservice"] = jobservice.toDictionary()
        }
        if materialName != nil{
            dictionary["material_name"] = materialName
        }
        if materialPrice != nil{
            dictionary["material_price"] = materialPrice
        }
        if materialQuantity != nil{
            dictionary["material_quantity"] = materialQuantity
        }
        if materialTotalPrice != nil{
            dictionary["material_total_price"] = materialTotalPrice
        }
        if recommended != nil{
            dictionary["recommended"] = recommended
        }
        if referenceId != nil{
            dictionary["reference_id"] = referenceId
        }
        if serviceId != nil{
            dictionary["service_id"] = serviceId
        }
        if type != nil{
            dictionary["type"] = type
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if updatedBy != nil{
            dictionary["updated_by"] = updatedBy
        }
        if warrantyEndDate != nil{
            dictionary["warranty_end_date"] = warrantyEndDate
        }
        if warrantyPercentage != nil{
            dictionary["warranty_percentage"] = warrantyPercentage
        }
        if additinalComment != nil{
            dictionary["additinal_comment"] = additinalComment
        }
        if appVersion != nil{
            dictionary["app_version"] = appVersion
        }
        if customerData != nil{
            dictionary["customer_data"] = customerData.toDictionary()
        }
        if customerId != nil{
            dictionary["customer_id"] = customerId
        }
        if customerMobile != nil{
            dictionary["customer_mobile"] = customerMobile
        }
        if customerName != nil{
            dictionary["customer_name"] = customerName
        }
        if distributionChannel != nil{
            dictionary["distribution_channel"] = distributionChannel
        }
        if employeeData != nil{
            dictionary["employee_data"] = employeeData.toDictionary()
        }
        if employeeId != nil{
            dictionary["employee_id"] = employeeId
        }
        if endDate != nil{
            dictionary["end_date"] = endDate
        }
        if expectedValue != nil{
            dictionary["expected_value"] = expectedValue
        }
        if enableSelectSlotSkip != nil{
            dictionary["enable_select_slot_skip"] = enableSelectSlotSkip
        }
        if issueCount != nil{
            dictionary["issue_count"] = issueCount
        }
        if jobQuotationData != nil{
            var dictionaryElements = [[String:Any]]()
            for jobQuotationDataElement in jobQuotationData {
                dictionaryElements.append(jobQuotationDataElement.toDictionary())
            }
            dictionary["job_quotation_data"] = dictionaryElements
        }
        if jobattachments != nil{
            var dictionaryElements = [[String:Any]]()
            for jobattachmentsElement in jobattachments {
                dictionaryElements.append(jobattachmentsElement.toDictionary())
            }
            dictionary["jobattachments"] = dictionaryElements
        }
        if jobotherservices != nil{
            var dictionaryElements = [[String:Any]]()
            for jobotherservicesElement in jobotherservices {
                dictionaryElements.append(jobotherservicesElement.toDictionary())
            }
            dictionary["jobotherservices"] = dictionaryElements
        }
        if jobquote != nil{
            dictionary["jobquote"] = jobquote.toDictionary()
        }
        if jobrequestadditionalinfo != nil{
            dictionary["jobrequestadditionalinfo"] = jobrequestadditionalinfo.toDictionary()
        }
        if jobrequestitems != nil{
            var dictionaryElements = [[String:Any]]()
            for jobrequestitemsElement in jobrequestitems {
                dictionaryElements.append(jobrequestitemsElement.toDictionary())
            }
            dictionary["jobrequestitems"] = dictionaryElements
        }
        if paymenttransaction != nil{
            var dictionaryElements = [[String:Any]]()
            for paymenttransactionElement in paymenttransaction {
                dictionaryElements.append(paymenttransactionElement.toDictionary())
            }
            dictionary["paymenttransaction"] = dictionaryElements
        }
        if priority != nil{
            dictionary["priority"] = priority
        }
        if propertyData != nil{
            dictionary["property_data"] = propertyData.toDictionary()
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if registeredProductId != nil{
            dictionary["registered_product_id"] = registeredProductId
        }
        if requestedMaterials != nil{
            var dictionaryElements = [[String:Any]]()
            for requestedMaterialsElement in requestedMaterials {
                dictionaryElements.append(requestedMaterialsElement.toDictionary())
            }
            dictionary["requestedMaterials"] = dictionaryElements
        }
        if salesUnit != nil{
            dictionary["sales_unit"] = salesUnit
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
        if startDate != nil{
            dictionary["start_date"] = startDate
        }
        if status != nil{
            dictionary["status"] = status
        }
        if subStatus != nil{
            dictionary["sub_status"] = subStatus
        }
        if successPercentage != nil{
            dictionary["success_percentage"] = successPercentage
        }
        if title != nil{
            dictionary["title"] = title
        }
        if vatPercentage != nil{
            dictionary["vat_percentage"] = vatPercentage
        }
        if webStatus != nil{
            dictionary["web_status"] = webStatus
        }
        if skipGeneratePaymentLink != nil{
            dictionary["skip_generate_payment_link"] = skipGeneratePaymentLink
        }
        if slotSkipped != nil{
            dictionary["slot_skipped"] = slotSkipped
        }

        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        confirmed = aDecoder.decodeObject(forKey: "confirmed") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        createdBy = aDecoder.decodeObject(forKey: "created_by") as? Int
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
        discount = aDecoder.decodeObject(forKey: "discount") as? String
        discountPercentage = aDecoder.decodeObject(forKey: "discount_percentage") as? String
        extraHours = aDecoder.decodeObject(forKey: "extra_hours") as? String
        goodwillPercentage = aDecoder.decodeObject(forKey: "goodwill_percentage") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isExtra = aDecoder.decodeObject(forKey: "is_extra") as? Int
        jobRequestId = aDecoder.decodeObject(forKey: "job_request_id") as? Int
        jobRequestItemId = aDecoder.decodeObject(forKey: "job_request_item_id") as? Int
        jobservice = aDecoder.decodeObject(forKey: "jobservice") as? Jobservice
        materialName = aDecoder.decodeObject(forKey: "material_name") as? String
        materialPrice = aDecoder.decodeObject(forKey: "material_price") as? String
        materialQuantity = aDecoder.decodeObject(forKey: "material_quantity") as? String
        materialTotalPrice = aDecoder.decodeObject(forKey: "material_total_price") as? String
        recommended = aDecoder.decodeObject(forKey: "recommended") as? Int
        referenceId = aDecoder.decodeObject(forKey: "reference_id") as? Int
        serviceId = aDecoder.decodeObject(forKey: "service_id") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        updatedBy = aDecoder.decodeObject(forKey: "updated_by") as? String
        warrantyEndDate = aDecoder.decodeObject(forKey: "warranty_end_date") as? String
        warrantyPercentage = aDecoder.decodeObject(forKey: "warranty_percentage") as? String
        additinalComment = aDecoder.decodeObject(forKey: "additinal_comment") as? String
        appVersion = aDecoder.decodeObject(forKey: "app_version") as? String
        customerData = aDecoder.decodeObject(forKey: "customer_data") as? CustomerData
        customerId = aDecoder.decodeObject(forKey: "customer_id") as? Int
        customerMobile = aDecoder.decodeObject(forKey: "customer_mobile") as? String
        customerName = aDecoder.decodeObject(forKey: "customer_name") as? String
        distributionChannel = aDecoder.decodeObject(forKey: "distribution_channel") as? String
        employeeData = aDecoder.decodeObject(forKey: "employee_data") as? EmployeeData
        employeeId = aDecoder.decodeObject(forKey: "employee_id") as? Int
        endDate = aDecoder.decodeObject(forKey: "end_date") as? String
        expectedValue = aDecoder.decodeObject(forKey: "expected_value") as? String
        enableSelectSlotSkip = aDecoder.decodeObject(forKey: "enable_select_slot_skip") as? String
        
        issueCount = aDecoder.decodeObject(forKey: "issue_count") as? Int
        jobQuotationData = aDecoder.decodeObject(forKey: "job_quotation_data") as? [JobQuotationData]
        jobattachments = aDecoder.decodeObject(forKey: "jobattachments") as? [Jobattachment]
        jobotherservices = aDecoder.decodeObject(forKey: "jobotherservices") as? [Jobotherservice]
        jobquote = aDecoder.decodeObject(forKey: "jobquote") as? Jobquote
        jobrequestadditionalinfo = aDecoder.decodeObject(forKey: "jobrequestadditionalinfo") as? Jobrequestadditionalinfo
        jobrequestitems = aDecoder.decodeObject(forKey: "jobrequestitems") as? [Jobrequestitem]
        paymenttransaction = aDecoder.decodeObject(forKey: "paymenttransaction") as? [Paymenttransaction]
        priority = aDecoder.decodeObject(forKey: "priority") as? String
        propertyData = aDecoder.decodeObject(forKey: "property_data") as? PropertyData
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int
        registeredProductId = aDecoder.decodeObject(forKey: "registered_product_id") as? String
        requestedMaterials = aDecoder.decodeObject(forKey: "requestedMaterials") as? [RequestedMaterial]
        salesUnit = aDecoder.decodeObject(forKey: "sales_unit") as? String
        sourceFrom = aDecoder.decodeObject(forKey: "source_from") as? Int
        sourceInfo = aDecoder.decodeObject(forKey: "source_info") as? String
        sourceIp = aDecoder.decodeObject(forKey: "source_ip") as? String
        startDate = aDecoder.decodeObject(forKey: "start_date") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        subStatus = aDecoder.decodeObject(forKey: "sub_status") as? Int
        successPercentage = aDecoder.decodeObject(forKey: "success_percentage") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        vatPercentage = aDecoder.decodeObject(forKey: "vat_percentage") as? Int
        webStatus = aDecoder.decodeObject(forKey: "web_status") as? String
        skipGeneratePaymentLink = aDecoder.decodeObject(forKey: "skip_generate_payment_link") as? String
        slotSkipped = aDecoder.decodeObject(forKey: "slot_skipped") as? Int

    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if confirmed != nil{
            aCoder.encode(confirmed, forKey: "confirmed")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if createdBy != nil{
            aCoder.encode(createdBy, forKey: "created_by")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if discount != nil{
            aCoder.encode(discount, forKey: "discount")
        }
        if discountPercentage != nil{
            aCoder.encode(discountPercentage, forKey: "discount_percentage")
        }
        if extraHours != nil{
            aCoder.encode(extraHours, forKey: "extra_hours")
        }
        if goodwillPercentage != nil{
            aCoder.encode(goodwillPercentage, forKey: "goodwill_percentage")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isExtra != nil{
            aCoder.encode(isExtra, forKey: "is_extra")
        }
        if jobRequestId != nil{
            aCoder.encode(jobRequestId, forKey: "job_request_id")
        }
        if jobRequestItemId != nil{
            aCoder.encode(jobRequestItemId, forKey: "job_request_item_id")
        }
        if jobrequestitems != nil{
            aCoder.encode(jobrequestitems, forKey: "jobrequestitems")
        }
        if jobservice != nil{
            aCoder.encode(jobservice, forKey: "jobservice")
        }
        if materialName != nil{
            aCoder.encode(materialName, forKey: "material_name")
        }
        if materialPrice != nil{
            aCoder.encode(materialPrice, forKey: "material_price")
        }
        if materialQuantity != nil{
            aCoder.encode(materialQuantity, forKey: "material_quantity")
        }
        if materialTotalPrice != nil{
            aCoder.encode(materialTotalPrice, forKey: "material_total_price")
        }
        if recommended != nil{
            aCoder.encode(recommended, forKey: "recommended")
        }
        if referenceId != nil{
            aCoder.encode(referenceId, forKey: "reference_id")
        }
        if serviceId != nil{
            aCoder.encode(serviceId, forKey: "service_id")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if updatedBy != nil{
            aCoder.encode(updatedBy, forKey: "updated_by")
        }
        if warrantyEndDate != nil{
            aCoder.encode(warrantyEndDate, forKey: "warranty_end_date")
        }
        if warrantyPercentage != nil{
            aCoder.encode(warrantyPercentage, forKey: "warranty_percentage")
        }
        if additinalComment != nil{
            aCoder.encode(additinalComment, forKey: "additinal_comment")
        }
        if appVersion != nil{
            aCoder.encode(appVersion, forKey: "app_version")
        }
        
        if customerData != nil{
            aCoder.encode(customerData, forKey: "customer_data")
        }
        if customerId != nil{
            aCoder.encode(customerId, forKey: "customer_id")
        }
        if customerMobile != nil{
            aCoder.encode(customerMobile, forKey: "customer_mobile")
        }
        if customerName != nil{
            aCoder.encode(customerName, forKey: "customer_name")
        }
        if distributionChannel != nil{
            aCoder.encode(distributionChannel, forKey: "distribution_channel")
        }
        if employeeData != nil{
            aCoder.encode(employeeData, forKey: "employee_data")
        }
        if employeeId != nil{
            aCoder.encode(employeeId, forKey: "employee_id")
        }
        if endDate != nil{
            aCoder.encode(endDate, forKey: "end_date")
        }
        if expectedValue != nil{
            aCoder.encode(expectedValue, forKey: "expected_value")
        }
        if enableSelectSlotSkip != nil{
            aCoder.encode(enableSelectSlotSkip, forKey: "enable_select_slot_skip")
        }
        if issueCount != nil{
            aCoder.encode(issueCount, forKey: "issue_count")
        }
        if jobQuotationData != nil{
            aCoder.encode(jobQuotationData, forKey: "job_quotation_data")
        }
        if jobattachments != nil{
            aCoder.encode(jobattachments, forKey: "jobattachments")
        }
        if jobotherservices != nil{
            aCoder.encode(jobotherservices, forKey: "jobotherservices")
        }
        if jobquote != nil{
            aCoder.encode(jobquote, forKey: "jobquote")
        }
        if jobrequestadditionalinfo != nil{
            aCoder.encode(jobrequestadditionalinfo, forKey: "jobrequestadditionalinfo")
        }
        if jobrequestitems != nil{
            aCoder.encode(jobrequestitems, forKey: "jobrequestitems")
        }
        if paymenttransaction != nil{
            aCoder.encode(paymenttransaction, forKey: "paymenttransaction")
        }
        if priority != nil{
            aCoder.encode(priority, forKey: "priority")
        }
        if propertyData != nil{
            aCoder.encode(propertyData, forKey: "property_data")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if registeredProductId != nil{
            aCoder.encode(registeredProductId, forKey: "registered_product_id")
        }
        if requestedMaterials != nil{
            aCoder.encode(requestedMaterials, forKey: "requestedMaterials")
        }
        if salesUnit != nil{
            aCoder.encode(salesUnit, forKey: "sales_unit")
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
        if startDate != nil{
            aCoder.encode(startDate, forKey: "start_date")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if subStatus != nil{
            aCoder.encode(subStatus, forKey: "sub_status")
        }
        if successPercentage != nil{
            aCoder.encode(successPercentage, forKey: "success_percentage")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if vatPercentage != nil{
            aCoder.encode(vatPercentage, forKey: "vat_percentage")
        }
        if webStatus != nil{
            aCoder.encode(webStatus, forKey: "web_status")
        }
        if skipGeneratePaymentLink != nil{
            aCoder.encode(skipGeneratePaymentLink, forKey: "skip_generate_payment_link")
        }
        if slotSkipped != nil{
            aCoder.encode(slotSkipped, forKey: "slot_skipped")
        }
        
    }
    
}
