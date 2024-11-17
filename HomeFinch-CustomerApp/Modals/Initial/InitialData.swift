//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class InitialData : NSObject, NSCoding{
    
    var contactType : [CustomerType]!
    var cuFeedbackOptions1 : [CustomerType]!
    var cuFeedbackOptions2 : [CustomerType]!
    var cuFeedbackOptions3 : [CustomerType]!
    var cuFeedbackOptions4 : [CustomerType]!
    var cuFeedbackOptions5 : [CustomerType]!
    var cuFeedbackTitle : [CustomerType]!
    var cuTextBeforeFeedbackOptions : [CustomerType]!
    var customerAccountType : [CustomerType]!
    var customerTitle : [CustomerTitle]!
    var customerType : [CustomerType]!
    var executionStarted : [CustomerType]!
    var expenseType : [CustomerType]!
    var issueStatusColorList : [CustomerType]!
    var issueStatusIconList : [CustomerType]!
    var issueStatusList : [CustomerType]!
    var jobRequestStatus : [CustomerType]!
    var jobRequestStatusAlert : [CustomerType]!
    var jobRequetSubColorStatus : [CustomerType]!
    var jobRequetSubStatus : [CustomerType]!
    var pages : [CustomerTitle]!
    var paytabsClientKey : String!
    var paytabsProfileId : String!
    var paytabsServerKey : String!
    var paytabsSdkClientKey : String!
    var paytabsSdkServerKey : String!
    var propertyType : [CustomerType]!
    var radarPublisherKey : String!
    var radarSecretKey : String!
    var reasonForAbandon : [CustomerType]!
    var reasonForAbandonNextStep : [CustomerType]!
    var reasonForAbandonType : [CustomerType]!
    var reasonForAbandonWithType : [CustomerType]!
    var reasonForPause : [CustomerType]!
    var roomFeature : [CustomerType]!
    var roomType : [CustomerType]!
    var serviceRatingsType : [CustomerType]!
    var settleUpType : [CustomerType]!
    var stockTransferStatus : [CustomerType]!
    var timerMinutes : String!
    var socialLogin : Bool!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        contactType = [CustomerType]()
        let contactTypeArray = json["contact_type"].arrayValue
        for contactTypeJson in contactTypeArray{
            let value = CustomerType(fromJson: contactTypeJson)
            contactType.append(value)
        }
        cuFeedbackOptions1 = [CustomerType]()
        let cuFeedbackOptions1Array = json["cu_feedback_options_1"].arrayValue
        for cuFeedbackOptions1Json in cuFeedbackOptions1Array{
            let value = CustomerType(fromJson: cuFeedbackOptions1Json)
            cuFeedbackOptions1.append(value)
        }
        cuFeedbackOptions2 = [CustomerType]()
        let cuFeedbackOptions2Array = json["cu_feedback_options_2"].arrayValue
        for cuFeedbackOptions2Json in cuFeedbackOptions2Array{
            let value = CustomerType(fromJson: cuFeedbackOptions2Json)
            cuFeedbackOptions2.append(value)
        }
        cuFeedbackOptions3 = [CustomerType]()
        let cuFeedbackOptions3Array = json["cu_feedback_options_3"].arrayValue
        for cuFeedbackOptions3Json in cuFeedbackOptions3Array{
            let value = CustomerType(fromJson: cuFeedbackOptions3Json)
            cuFeedbackOptions3.append(value)
        }
        cuFeedbackOptions4 = [CustomerType]()
        let cuFeedbackOptions4Array = json["cu_feedback_options_4"].arrayValue
        for cuFeedbackOptions4Json in cuFeedbackOptions4Array{
            let value = CustomerType(fromJson: cuFeedbackOptions4Json)
            cuFeedbackOptions4.append(value)
        }
        cuFeedbackOptions5 = [CustomerType]()
        let cuFeedbackOptions5Array = json["cu_feedback_options_5"].arrayValue
        for cuFeedbackOptions5Json in cuFeedbackOptions5Array{
            let value = CustomerType(fromJson: cuFeedbackOptions5Json)
            cuFeedbackOptions5.append(value)
        }
        cuFeedbackTitle = [CustomerType]()
        let cuFeedbackTitleArray = json["cu_feedback_title"].arrayValue
        for cuFeedbackTitleJson in cuFeedbackTitleArray{
            let value = CustomerType(fromJson: cuFeedbackTitleJson)
            cuFeedbackTitle.append(value)
        }
        cuTextBeforeFeedbackOptions = [CustomerType]()
        let cuTextBeforeFeedbackOptionsArray = json["cu_text_before_feedback_options"].arrayValue
        for cuTextBeforeFeedbackOptionsJson in cuTextBeforeFeedbackOptionsArray{
            let value = CustomerType(fromJson: cuTextBeforeFeedbackOptionsJson)
            cuTextBeforeFeedbackOptions.append(value)
        }
        customerAccountType = [CustomerType]()
        let customerAccountTypeArray = json["customer_account_type"].arrayValue
        for customerAccountTypeJson in customerAccountTypeArray{
            let value = CustomerType(fromJson: customerAccountTypeJson)
            customerAccountType.append(value)
        }
        customerTitle = [CustomerTitle]()
        let customerTitleArray = json["customer_title"].arrayValue
        for customerTitleJson in customerTitleArray{
            let value = CustomerTitle(fromJson: customerTitleJson)
            customerTitle.append(value)
        }
        customerType = [CustomerType]()
        let customerTypeArray = json["customer_type"].arrayValue
        for customerTypeJson in customerTypeArray{
            let value = CustomerType(fromJson: customerTypeJson)
            customerType.append(value)
        }
        executionStarted = [CustomerType]()
        let executionStartedArray = json["execution_started"].arrayValue
        for executionStartedJson in executionStartedArray{
            let value = CustomerType(fromJson: executionStartedJson)
            executionStarted.append(value)
        }
        expenseType = [CustomerType]()
        let expenseTypeArray = json["expense_type"].arrayValue
        for expenseTypeJson in expenseTypeArray{
            let value = CustomerType(fromJson: expenseTypeJson)
            expenseType.append(value)
        }
        issueStatusColorList = [CustomerType]()
        let issueStatusColorListArray = json["issue_status_color_list"].arrayValue
        for issueStatusColorListJson in issueStatusColorListArray{
            let value = CustomerType(fromJson: issueStatusColorListJson)
            issueStatusColorList.append(value)
        }
        issueStatusIconList = [CustomerType]()
        let issueStatusIconListArray = json["issue_status_icon_list"].arrayValue
        for issueStatusIconListJson in issueStatusIconListArray{
            let value = CustomerType(fromJson: issueStatusIconListJson)
            issueStatusIconList.append(value)
        }
        issueStatusList = [CustomerType]()
        let issueStatusListArray = json["issue_status_list"].arrayValue
        for issueStatusListJson in issueStatusListArray{
            let value = CustomerType(fromJson: issueStatusListJson)
            issueStatusList.append(value)
        }
        jobRequestStatus = [CustomerType]()
        let jobRequestStatusArray = json["job_request_status"].arrayValue
        for jobRequestStatusJson in jobRequestStatusArray{
            let value = CustomerType(fromJson: jobRequestStatusJson)
            jobRequestStatus.append(value)
        }
        jobRequestStatusAlert = [CustomerType]()
        let jobRequestStatusAlertArray = json["job_request_status_alert"].arrayValue
        for jobRequestStatusAlertJson in jobRequestStatusAlertArray{
            let value = CustomerType(fromJson: jobRequestStatusAlertJson)
            jobRequestStatusAlert.append(value)
        }
        jobRequetSubColorStatus = [CustomerType]()
        let jobRequetSubColorStatusArray = json["job_requet_sub_color_status"].arrayValue
        for jobRequetSubColorStatusJson in jobRequetSubColorStatusArray{
            let value = CustomerType(fromJson: jobRequetSubColorStatusJson)
            jobRequetSubColorStatus.append(value)
        }
        jobRequetSubStatus = [CustomerType]()
        let jobRequetSubStatusArray = json["job_requet_sub_status"].arrayValue
        for jobRequetSubStatusJson in jobRequetSubStatusArray{
            let value = CustomerType(fromJson: jobRequetSubStatusJson)
            jobRequetSubStatus.append(value)
        }
        pages = [CustomerTitle]()
        let pagesArray = json["pages"].arrayValue
        for pagesJson in pagesArray{
            let value = CustomerTitle(fromJson: pagesJson)
            pages.append(value)
        }
        paytabsClientKey = json["paytabs_client_key"].stringValue
        paytabsProfileId = json["paytabs_profile_id"].stringValue
        paytabsServerKey = json["paytabs_server_key"].stringValue
        paytabsSdkClientKey = json["paytabs_sdk_client_key"].stringValue
        paytabsSdkServerKey = json["paytabs_sdk_server_key"].stringValue
        
        propertyType = [CustomerType]()
        let propertyTypeArray = json["property_type"].arrayValue
        for propertyTypeJson in propertyTypeArray{
            let value = CustomerType(fromJson: propertyTypeJson)
            propertyType.append(value)
        }
        radarPublisherKey = json["radar_publisher_key"].stringValue
        radarSecretKey = json["radar_secret_key"].stringValue
        reasonForAbandon = [CustomerType]()
        let reasonForAbandonArray = json["reason_for_abandon"].arrayValue
        for reasonForAbandonJson in reasonForAbandonArray{
            let value = CustomerType(fromJson: reasonForAbandonJson)
            reasonForAbandon.append(value)
        }
        reasonForAbandonType = [CustomerType]()
        let reasonForAbandonTypeArray = json["reason_for_abandon_type"].arrayValue
        for reasonForAbandonTypeJson in reasonForAbandonTypeArray{
            let value = CustomerType(fromJson: reasonForAbandonTypeJson)
            reasonForAbandonType.append(value)
        }
        reasonForAbandonNextStep = [CustomerType]()
        let reasonForAbandonNextStepArray = json["reason_for_abandon_next_step"].arrayValue
        for reasonForAbandonNextStepJson in reasonForAbandonNextStepArray{
            let value = CustomerType(fromJson: reasonForAbandonNextStepJson)
            reasonForAbandonNextStep.append(value)
        }
        reasonForAbandonWithType = [CustomerType]()
        let reasonForAbandonWithTypeArray = json["reason_for_abandon_with_type"].arrayValue
        for reasonForAbandonWithTypeJson in reasonForAbandonWithTypeArray{
            let value = CustomerType(fromJson: reasonForAbandonWithTypeJson)
            reasonForAbandonWithType.append(value)
        }
        reasonForPause = [CustomerType]()
        let reasonForPauseArray = json["reason_for_pause"].arrayValue
        for reasonForPauseJson in reasonForPauseArray{
            let value = CustomerType(fromJson: reasonForPauseJson)
            reasonForPause.append(value)
        }
        roomFeature = [CustomerType]()
        let roomFeatureArray = json["room_feature"].arrayValue
        for roomFeatureJson in roomFeatureArray{
            let value = CustomerType(fromJson: roomFeatureJson)
            roomFeature.append(value)
        }
        roomType = [CustomerType]()
        let roomTypeArray = json["room_type"].arrayValue
        for roomTypeJson in roomTypeArray{
            let value = CustomerType(fromJson: roomTypeJson)
            roomType.append(value)
        }
        serviceRatingsType = [CustomerType]()
        let serviceRatingsTypeArray = json["service_ratings_type"].arrayValue
        for serviceRatingsTypeJson in serviceRatingsTypeArray{
            let value = CustomerType(fromJson: serviceRatingsTypeJson)
            serviceRatingsType.append(value)
        }
        settleUpType = [CustomerType]()
        let settleUpTypeArray = json["settle_up_type"].arrayValue
        for settleUpTypeJson in settleUpTypeArray{
            let value = CustomerType(fromJson: settleUpTypeJson)
            settleUpType.append(value)
        }
        stockTransferStatus = [CustomerType]()
        let stockTransferStatusArray = json["stock_transfer_status"].arrayValue
        for stockTransferStatusJson in stockTransferStatusArray{
            let value = CustomerType(fromJson: stockTransferStatusJson)
            stockTransferStatus.append(value)
        }
        timerMinutes = json["timer_minutes"].stringValue
        socialLogin = json["social_login"].boolValue
        
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if contactType != nil{
            var dictionaryElements = [[String:Any]]()
            for contactTypeElement in contactType {
                dictionaryElements.append(contactTypeElement.toDictionary())
            }
            dictionary["contact_type"] = dictionaryElements
        }
        if cuFeedbackOptions1 != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackOptions1Element in cuFeedbackOptions1 {
                dictionaryElements.append(cuFeedbackOptions1Element.toDictionary())
            }
            dictionary["cu_feedback_options_1"] = dictionaryElements
        }
        if cuFeedbackOptions2 != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackOptions2Element in cuFeedbackOptions2 {
                dictionaryElements.append(cuFeedbackOptions2Element.toDictionary())
            }
            dictionary["cu_feedback_options_2"] = dictionaryElements
        }
        if cuFeedbackOptions3 != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackOptions3Element in cuFeedbackOptions3 {
                dictionaryElements.append(cuFeedbackOptions3Element.toDictionary())
            }
            dictionary["cu_feedback_options_3"] = dictionaryElements
        }
        if cuFeedbackOptions4 != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackOptions4Element in cuFeedbackOptions4 {
                dictionaryElements.append(cuFeedbackOptions4Element.toDictionary())
            }
            dictionary["cu_feedback_options_4"] = dictionaryElements
        }
        if cuFeedbackOptions5 != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackOptions5Element in cuFeedbackOptions5 {
                dictionaryElements.append(cuFeedbackOptions5Element.toDictionary())
            }
            dictionary["cu_feedback_options_5"] = dictionaryElements
        }
        if cuFeedbackTitle != nil{
            var dictionaryElements = [[String:Any]]()
            for cuFeedbackTitleElement in cuFeedbackTitle {
                dictionaryElements.append(cuFeedbackTitleElement.toDictionary())
            }
            dictionary["cu_feedback_title"] = dictionaryElements
        }
        if cuTextBeforeFeedbackOptions != nil{
            var dictionaryElements = [[String:Any]]()
            for cuTextBeforeFeedbackOptionsElement in cuTextBeforeFeedbackOptions {
                dictionaryElements.append(cuTextBeforeFeedbackOptionsElement.toDictionary())
            }
            dictionary["cu_text_before_feedback_options"] = dictionaryElements
        }
        if customerAccountType != nil{
            var dictionaryElements = [[String:Any]]()
            for customerAccountTypeElement in customerAccountType {
                dictionaryElements.append(customerAccountTypeElement.toDictionary())
            }
            dictionary["customer_account_type"] = dictionaryElements
        }
        if customerTitle != nil{
            var dictionaryElements = [[String:Any]]()
            for customerTitleElement in customerTitle {
                dictionaryElements.append(customerTitleElement.toDictionary())
            }
            dictionary["customer_title"] = dictionaryElements
        }
        if customerType != nil{
            var dictionaryElements = [[String:Any]]()
            for customerTypeElement in customerType {
                dictionaryElements.append(customerTypeElement.toDictionary())
            }
            dictionary["customer_type"] = dictionaryElements
        }
        if executionStarted != nil{
            var dictionaryElements = [[String:Any]]()
            for executionStartedElement in executionStarted {
                dictionaryElements.append(executionStartedElement.toDictionary())
            }
            dictionary["execution_started"] = dictionaryElements
        }
        if expenseType != nil{
            var dictionaryElements = [[String:Any]]()
            for expenseTypeElement in expenseType {
                dictionaryElements.append(expenseTypeElement.toDictionary())
            }
            dictionary["expense_type"] = dictionaryElements
        }
        if issueStatusColorList != nil{
            var dictionaryElements = [[String:Any]]()
            for issueStatusColorListElement in issueStatusColorList {
                dictionaryElements.append(issueStatusColorListElement.toDictionary())
            }
            dictionary["issue_status_color_list"] = dictionaryElements
        }
        if issueStatusIconList != nil{
            var dictionaryElements = [[String:Any]]()
            for issueStatusIconListElement in issueStatusIconList {
                dictionaryElements.append(issueStatusIconListElement.toDictionary())
            }
            dictionary["issue_status_icon_list"] = dictionaryElements
        }
        if issueStatusList != nil{
            var dictionaryElements = [[String:Any]]()
            for issueStatusListElement in issueStatusList {
                dictionaryElements.append(issueStatusListElement.toDictionary())
            }
            dictionary["issue_status_list"] = dictionaryElements
        }
        if jobRequestStatus != nil{
            var dictionaryElements = [[String:Any]]()
            for jobRequestStatusElement in jobRequestStatus {
                dictionaryElements.append(jobRequestStatusElement.toDictionary())
            }
            dictionary["job_request_status"] = dictionaryElements
        }
        if jobRequestStatusAlert != nil{
            var dictionaryElements = [[String:Any]]()
            for jobRequestStatusAlertElement in jobRequestStatusAlert {
                dictionaryElements.append(jobRequestStatusAlertElement.toDictionary())
            }
            dictionary["job_request_status_alert"] = dictionaryElements
        }
        if jobRequetSubColorStatus != nil{
            var dictionaryElements = [[String:Any]]()
            for jobRequetSubColorStatusElement in jobRequetSubColorStatus {
                dictionaryElements.append(jobRequetSubColorStatusElement.toDictionary())
            }
            dictionary["job_requet_sub_color_status"] = dictionaryElements
        }
        if jobRequetSubStatus != nil{
            var dictionaryElements = [[String:Any]]()
            for jobRequetSubStatusElement in jobRequetSubStatus {
                dictionaryElements.append(jobRequetSubStatusElement.toDictionary())
            }
            dictionary["job_requet_sub_status"] = dictionaryElements
        }
        if pages != nil{
            var dictionaryElements = [[String:Any]]()
            for pagesElement in pages {
                dictionaryElements.append(pagesElement.toDictionary())
            }
            dictionary["pages"] = dictionaryElements
        }
        if paytabsClientKey != nil{
            dictionary["paytabs_client_key"] = paytabsClientKey
        }
        if paytabsProfileId != nil{
            dictionary["paytabs_profile_id"] = paytabsProfileId
        }
        if paytabsServerKey != nil{
            dictionary["paytabs_server_key"] = paytabsServerKey
        }
        if paytabsSdkClientKey != nil{
            dictionary["paytabs_sdk_client_key"] = paytabsSdkClientKey
        }
        if paytabsSdkServerKey != nil{
            dictionary["paytabs_sdk_server_key"] = paytabsSdkServerKey
        }
        if propertyType != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyTypeElement in propertyType {
                dictionaryElements.append(propertyTypeElement.toDictionary())
            }
            dictionary["property_type"] = dictionaryElements
        }
        if radarPublisherKey != nil{
            dictionary["radar_publisher_key"] = radarPublisherKey
        }
        if radarSecretKey != nil{
            dictionary["radar_secret_key"] = radarSecretKey
        }
        if reasonForAbandon != nil{
            var dictionaryElements = [[String:Any]]()
            for reasonForAbandonElement in reasonForAbandon {
                dictionaryElements.append(reasonForAbandonElement.toDictionary())
            }
            dictionary["reason_for_abandon"] = dictionaryElements
        }
        if reasonForAbandonNextStep != nil{
            var dictionaryElements = [[String:Any]]()
            for reasonForAbandonNextStepElement in reasonForAbandonNextStep {
                dictionaryElements.append(reasonForAbandonNextStepElement.toDictionary())
            }
            dictionary["reason_for_abandon_next_step"] = dictionaryElements
        }
        if reasonForAbandonType != nil{
            var dictionaryElements = [[String:Any]]()
            for reasonForAbandonTypeElement in reasonForAbandonType {
                dictionaryElements.append(reasonForAbandonTypeElement.toDictionary())
            }
            dictionary["reason_for_abandon_type"] = dictionaryElements
        }
        if reasonForAbandonWithType != nil{
            var dictionaryElements = [[String:Any]]()
            for reasonForAbandonWithTypeElement in reasonForAbandonWithType {
                dictionaryElements.append(reasonForAbandonWithTypeElement.toDictionary())
            }
            dictionary["reason_for_abandon_with_type"] = dictionaryElements
        }
        if reasonForPause != nil{
            var dictionaryElements = [[String:Any]]()
            for reasonForPauseElement in reasonForPause {
                dictionaryElements.append(reasonForPauseElement.toDictionary())
            }
            dictionary["reason_for_pause"] = dictionaryElements
        }
        if roomFeature != nil{
            var dictionaryElements = [[String:Any]]()
            for roomFeatureElement in roomFeature {
                dictionaryElements.append(roomFeatureElement.toDictionary())
            }
            dictionary["room_feature"] = dictionaryElements
        }
        if roomType != nil{
            var dictionaryElements = [[String:Any]]()
            for roomTypeElement in roomType {
                dictionaryElements.append(roomTypeElement.toDictionary())
            }
            dictionary["room_type"] = dictionaryElements
        }
        if serviceRatingsType != nil{
            var dictionaryElements = [[String:Any]]()
            for serviceRatingsTypeElement in serviceRatingsType {
                dictionaryElements.append(serviceRatingsTypeElement.toDictionary())
            }
            dictionary["service_ratings_type"] = dictionaryElements
        }
        if settleUpType != nil{
            var dictionaryElements = [[String:Any]]()
            for settleUpTypeElement in settleUpType {
                dictionaryElements.append(settleUpTypeElement.toDictionary())
            }
            dictionary["settle_up_type"] = dictionaryElements
        }
        if stockTransferStatus != nil{
            var dictionaryElements = [[String:Any]]()
            for stockTransferStatusElement in stockTransferStatus {
                dictionaryElements.append(stockTransferStatusElement.toDictionary())
            }
            dictionary["stock_transfer_status"] = dictionaryElements
        }
        if timerMinutes != nil{
            dictionary["timer_minutes"] = timerMinutes
        }
        if socialLogin != nil{
            dictionary["social_login"] = socialLogin
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        contactType = aDecoder.decodeObject(forKey: "contact_type") as? [CustomerType]
        cuFeedbackOptions1 = aDecoder.decodeObject(forKey: "cu_feedback_options_1") as? [CustomerType]
        cuFeedbackOptions2 = aDecoder.decodeObject(forKey: "cu_feedback_options_2") as? [CustomerType]
        cuFeedbackOptions3 = aDecoder.decodeObject(forKey: "cu_feedback_options_3") as? [CustomerType]
        cuFeedbackOptions4 = aDecoder.decodeObject(forKey: "cu_feedback_options_4") as? [CustomerType]
        cuFeedbackOptions5 = aDecoder.decodeObject(forKey: "cu_feedback_options_5") as? [CustomerType]
        cuFeedbackTitle = aDecoder.decodeObject(forKey: "cu_feedback_title") as? [CustomerType]
        cuTextBeforeFeedbackOptions = aDecoder.decodeObject(forKey: "cu_text_before_feedback_options") as? [CustomerType]
        customerAccountType = aDecoder.decodeObject(forKey: "customer_account_type") as? [CustomerType]
        customerTitle = aDecoder.decodeObject(forKey: "customer_title") as? [CustomerTitle]
        customerType = aDecoder.decodeObject(forKey: "customer_type") as? [CustomerType]
        executionStarted = aDecoder.decodeObject(forKey: "execution_started") as? [CustomerType]
        expenseType = aDecoder.decodeObject(forKey: "expense_type") as? [CustomerType]
        issueStatusColorList = aDecoder.decodeObject(forKey: "issue_status_color_list") as? [CustomerType]
        issueStatusIconList = aDecoder.decodeObject(forKey: "issue_status_icon_list") as? [CustomerType]
        issueStatusList = aDecoder.decodeObject(forKey: "issue_status_list") as? [CustomerType]
        jobRequestStatus = aDecoder.decodeObject(forKey: "job_request_status") as? [CustomerType]
        jobRequestStatusAlert = aDecoder.decodeObject(forKey: "job_request_status_alert") as? [CustomerType]
        jobRequetSubColorStatus = aDecoder.decodeObject(forKey: "job_requet_sub_color_status") as? [CustomerType]
        jobRequetSubStatus = aDecoder.decodeObject(forKey: "job_requet_sub_status") as? [CustomerType]
        pages = aDecoder.decodeObject(forKey: "pages") as? [CustomerTitle]
        paytabsClientKey = aDecoder.decodeObject(forKey: "paytabs_client_key") as? String
        paytabsProfileId = aDecoder.decodeObject(forKey: "paytabs_profile_id") as? String
        paytabsServerKey = aDecoder.decodeObject(forKey: "paytabs_server_key") as? String
        paytabsSdkClientKey = aDecoder.decodeObject(forKey: "paytabs_sdk_client_key") as? String
        paytabsSdkServerKey = aDecoder.decodeObject(forKey: "paytabs_sdk_server_key") as? String
        
        propertyType = aDecoder.decodeObject(forKey: "property_type") as? [CustomerType]
        radarPublisherKey = aDecoder.decodeObject(forKey: "radar_publisher_key") as? String
        radarSecretKey = aDecoder.decodeObject(forKey: "radar_secret_key") as? String
        reasonForAbandon = aDecoder.decodeObject(forKey: "reason_for_abandon") as? [CustomerType]
        reasonForAbandonNextStep = aDecoder.decodeObject(forKey: "reason_for_abandon_next_step") as? [CustomerType]
        reasonForAbandonType = aDecoder.decodeObject(forKey: "reason_for_abandon_type") as? [CustomerType]
        reasonForAbandonWithType = aDecoder.decodeObject(forKey: "reason_for_abandon_with_type") as? [CustomerType]
        reasonForPause = aDecoder.decodeObject(forKey: "reason_for_pause") as? [CustomerType]
        roomFeature = aDecoder.decodeObject(forKey: "room_feature") as? [CustomerType]
        roomType = aDecoder.decodeObject(forKey: "room_type") as? [CustomerType]
        serviceRatingsType = aDecoder.decodeObject(forKey: "service_ratings_type") as? [CustomerType]
        settleUpType = aDecoder.decodeObject(forKey: "settle_up_type") as? [CustomerType]
        
        stockTransferStatus = aDecoder.decodeObject(forKey: "stock_transfer_status") as? [CustomerType]
        timerMinutes = aDecoder.decodeObject(forKey: "timer_minutes") as? String
        socialLogin = aDecoder.decodeObject(forKey: "social_login") as? Bool
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if contactType != nil{
            aCoder.encode(contactType, forKey: "contact_type")
        }
        if cuFeedbackOptions1 != nil{
            aCoder.encode(cuFeedbackOptions1, forKey: "cu_feedback_options_1")
        }
        if cuFeedbackOptions2 != nil{
            aCoder.encode(cuFeedbackOptions2, forKey: "cu_feedback_options_2")
        }
        if cuFeedbackOptions3 != nil{
            aCoder.encode(cuFeedbackOptions3, forKey: "cu_feedback_options_3")
        }
        if cuFeedbackOptions4 != nil{
            aCoder.encode(cuFeedbackOptions4, forKey: "cu_feedback_options_4")
        }
        if cuFeedbackOptions5 != nil{
            aCoder.encode(cuFeedbackOptions5, forKey: "cu_feedback_options_5")
        }
        if cuFeedbackTitle != nil{
            aCoder.encode(cuFeedbackTitle, forKey: "cu_feedback_title")
        }
        if cuTextBeforeFeedbackOptions != nil{
            aCoder.encode(cuTextBeforeFeedbackOptions, forKey: "cu_text_before_feedback_options")
        }
        if customerAccountType != nil{
            aCoder.encode(customerAccountType, forKey: "customer_account_type")
        }
        if customerTitle != nil{
            aCoder.encode(customerTitle, forKey: "customer_title")
        }
        if customerType != nil{
            aCoder.encode(customerType, forKey: "customer_type")
        }
        if executionStarted != nil{
            aCoder.encode(executionStarted, forKey: "execution_started")
        }
        if expenseType != nil{
            aCoder.encode(expenseType, forKey: "expense_type")
        }
        if issueStatusColorList != nil{
            aCoder.encode(issueStatusColorList, forKey: "issue_status_color_list")
        }
        if issueStatusIconList != nil{
            aCoder.encode(issueStatusIconList, forKey: "issue_status_icon_list")
        }
        if issueStatusList != nil{
            aCoder.encode(issueStatusList, forKey: "issue_status_list")
        }
        if jobRequestStatus != nil{
            aCoder.encode(jobRequestStatus, forKey: "job_request_status")
        }
        if jobRequestStatusAlert != nil{
            aCoder.encode(jobRequestStatusAlert, forKey: "job_request_status_alert")
        }
        if jobRequetSubColorStatus != nil{
            aCoder.encode(jobRequetSubColorStatus, forKey: "job_requet_sub_color_status")
        }
        if jobRequetSubStatus != nil{
            aCoder.encode(jobRequetSubStatus, forKey: "job_requet_sub_status")
        }
        if pages != nil{
            aCoder.encode(pages, forKey: "pages")
        }
        if paytabsClientKey != nil{
            aCoder.encode(paytabsClientKey, forKey: "paytabs_client_key")
        }
        if paytabsProfileId != nil{
            aCoder.encode(paytabsProfileId, forKey: "paytabs_profile_id")
        }
        if paytabsServerKey != nil{
            aCoder.encode(paytabsServerKey, forKey: "paytabs_server_key")
        }
        if paytabsSdkClientKey != nil{
            aCoder.encode(paytabsSdkClientKey, forKey: "paytabs_sdk_client_key")
        }
        if paytabsSdkServerKey != nil{
            aCoder.encode(paytabsSdkServerKey, forKey: "paytabs_sdk_server_key")
        }
        if propertyType != nil{
            aCoder.encode(propertyType, forKey: "property_type")
        }
        if radarPublisherKey != nil{
            aCoder.encode(radarPublisherKey, forKey: "radar_publisher_key")
        }
        if radarSecretKey != nil{
            aCoder.encode(radarSecretKey, forKey: "radar_secret_key")
        }
        if reasonForAbandon != nil{
            aCoder.encode(reasonForAbandon, forKey: "reason_for_abandon")
        }
        if reasonForAbandonNextStep != nil{
            aCoder.encode(reasonForAbandonNextStep, forKey: "reason_for_abandon_next_step")
        }
        if reasonForAbandonType != nil{
            aCoder.encode(reasonForAbandonType, forKey: "reason_for_abandon_type")
        }
        if reasonForAbandonWithType != nil{
            aCoder.encode(reasonForAbandonWithType, forKey: "reason_for_abandon_with_type")
        }
        if reasonForPause != nil{
            aCoder.encode(reasonForPause, forKey: "reason_for_pause")
        }
        if roomFeature != nil{
            aCoder.encode(roomFeature, forKey: "room_feature")
        }
        if roomType != nil{
            aCoder.encode(roomType, forKey: "room_type")
        }
        if serviceRatingsType != nil{
            aCoder.encode(serviceRatingsType, forKey: "service_ratings_type")
        }
        if settleUpType != nil{
            aCoder.encode(settleUpType, forKey: "settle_up_type")
        }
        if stockTransferStatus != nil{
            aCoder.encode(stockTransferStatus, forKey: "stock_transfer_status")
        }
        if timerMinutes != nil{
            aCoder.encode(timerMinutes, forKey: "timer_minutes")
        }
        if socialLogin != nil{
            aCoder.encode(socialLogin, forKey: "social_login")
        }
        
    }
    
}
