//
//  UserSettings.swift
//  Omahat
//
//  Created by Imran Mohammed on 10/21/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class UserSettings: NSObject {
    
    static let shared = UserSettings()
    var arrLabels = [labelItem]()
    var tabbarController = CustomTabbarVC()
    var images = [[String:Any]]()
    var arrList = [[String:Any]]()
    var arrServices = [[String:Any]]()
    var arrCountry = [Country]()
    var arrCustomerTitle = [CustomerTitle]()
    var arrPages = [CustomerTitle]()
    var arrPropertyList = [PropertyList]()

    var initialData : InitialData!
    var socialLogin : Bool! = true

    
//    class google {
//        static let clientId: String = "160377968159-eeftl6cmkjdqa5t8gsrn1v77gjarnvel.apps.googleusercontent.com"
//        let ss = "com.googleusercontent.apps.160377968159-eeftl6cmkjdqa5t8gsrn1v77gjarnvel"
//    }
    
    class google {
        static let clientId: String = "218265685953-t4bldskshbjaks5b6b1s0aov7qoek2sk.apps.googleusercontent.com"
        let ss = "com.googleusercontent.apps.218265685953-t4bldskshbjaks5b6b1s0aov7qoek2sk"
    }
    
    class pushToken {
        static var token: String {
            set(newValue) {
                newValue.cache(key: "_devicePushToken")
            }
            get {
                return String.cached(key: "_devicePushToken") ?? "Not Determined"
            }
        }
    }
    
    class FcmToken {
        static var token: String {
            set(newValue) {
                newValue.cache(key: "_deviceFcmToken")
            }
            get {
                return String.cached(key: "_deviceFcmToken") ?? " "
            }
        }
    }
    
    func getHeaders() -> HTTPHeaders {

        let headers : HTTPHeaders = [
            "Accept" : "application/json",
            "app_version" : Bundle.main.buildVersionNumber,
            "platform" : "ios",
            "user_type":"customer"

        ]
        print("Accessed headers \(headers)")
        return headers
    }
    
    func getHeaders1() -> HTTPHeaders {

        let headers : HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "app_version" : Bundle.main.buildVersionNumber,
            "platform" : "ios",
            "user_type":"customer"

        ]
        print("Accessed headers \(headers)")
        return headers
    }
    
    func getCustomerId() -> String {
        return String.cached(key: "CustomerId") ?? "0"
    }
    
    func setCustomerId(id: String) {
        id.cache(key: "CustomerId")
        print("Customer id set \(id)")
    }
    
    func getCustomerSapId() -> String {
        return String.cached(key: "CustomersapId") ?? "0"
    }
    
    func setCustomerSapId(id: String) {
        id.cache(key: "CustomersapId")
        print("Customer id set \(id)")
    }
    
    /// User related functions
    func setLoggedIn() {
        true.cache(key: "authUserIsLoggedIn")
        
        // Post notification
        NotificationCenter.default.post(name: Notification.Name.ImShLoginStatusChanged, object: nil, userInfo: nil)
    }

    func setLoggedOut() {
        
        false.cache(key: "authUserIsLoggedIn")
        setCustomerId(id: "0")
        
        // Post notification
        NotificationCenter.default.post(name: Notification.Name.ImShLoginStatusChanged, object: nil, userInfo: nil)
    }
    
    func isLoggedIn() -> Bool {
        return Bool.cached(key: "authUserIsLoggedIn")
    }
    
    
    /// To save the country selected by user
    /// Format: "KW/Kuwait"
    /// - Parameter country: CountriesData
//    func setCountry(country: CountriesData) {
//        let formattedCountry = "\(country.twoLetterAbbreviation.explicit)/\(country.country_name.explicit)"
//        let userDef = UserDefaults.standard
//        userDef.set(formattedCountry, forKey: "userSelectedCountry")
//        userDef.synchronize()
//    }
//
//    func getCountrySelected() -> CountriesData? {
//        guard let savedCountry = UserDefaults.standard.string(forKey: "userSelectedCountry") else { return nil }
//        let components = savedCountry.components(separatedBy: "/")
//        if components.count < 2 { return nil }
//        return CountriesData.init(ISO2: components.at(index: 0), name: components.at(index: 1))
//    }
    
    /// Three letter code. Ex: KWD
    func setCurrency(currCode: String) {
        let userDef = UserDefaults.standard
        userDef.set(currCode, forKey: "userSelectedCurrency")
        userDef.synchronize()
    }
    
    func getCurrencyCode() -> String {
        return UserDefaults.standard.string(forKey: "userSelectedCurrency") ?? "KWD"
    }
    
    func getwalletbalance() -> String {
        return String.cached(key: "wallet") ?? "AED 0.00"
    }
    
    func setwalletbalance(balance: String) {
        balance.cache(key: "wallet")
    }

    func setUserCredential(strTitle: String,strEmail: String, strFname: String, strLname: String, strMobile: String, strCountryValue: String, strCountryName: String,image:String) {
        let userDef = UserDefaults.standard
        userDef.set(strTitle, forKey: "userLoginTitle")
        userDef.set(strEmail, forKey: "userLoginEmail")
        userDef.set(strFname, forKey: "userLoginFName")
        userDef.set(strLname, forKey: "userLoginLName")
        userDef.set(strMobile, forKey: "userLoginNumber")
        userDef.set(strCountryValue, forKey: "userLoginCCode")
        userDef.set(strCountryName, forKey: "userLoginCName")
        userDef.set(image, forKey: "userImage")
        userDef.synchronize()
    }
    
    func getUserCredential() -> Dictionary<String, Any> {

        let strTitle = UserDefaults.standard.string(forKey: "userLoginTitle") ?? ""
        let strEmail = UserDefaults.standard.string(forKey: "userLoginEmail") ?? ""
        let strFname = UserDefaults.standard.string(forKey: "userLoginFName") ?? ""
        let strLname = UserDefaults.standard.string(forKey: "userLoginLName") ?? ""
        let strMobile = UserDefaults.standard.string(forKey: "userLoginNumber") ?? ""
        let strCountryValue = UserDefaults.standard.string(forKey: "userLoginCCode") ?? ""
        let strCountryName = UserDefaults.standard.string(forKey: "userLoginCName") ?? ""
        let strImage = UserDefaults.standard.string(forKey: "userImage") ?? ""
        
        let params = [
            "title" : strTitle,
            "email": strEmail,
            "firstname": strFname,
            "lastname": strLname,
            "mobile": strMobile,
            "c_code": strCountryValue,
            "country": strCountryName,
            "avatar": strImage

        ] as Dictionary
        
        return params

        
    }
    
    func setContactUserCredential(strname: String, strMobile: String) {
        let userDef = UserDefaults.standard
        userDef.set(strname, forKey: "userContactName")
        userDef.set(strMobile, forKey: "userContactNumber")
        userDef.synchronize()
    }
    
    func getContactUserCredential() -> Dictionary<String, Any> {

        let strName = UserDefaults.standard.string(forKey: "userContactName") ?? ""
        let strMobile = UserDefaults.standard.string(forKey: "userContactNumber") ?? ""
        
        let params = [
            "name": strName,
            "mobile": strMobile

        ] as Dictionary
        
        return params

        
    }

    func themeColor() -> UIColor {
        return UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1)
    }

    func themeColor2() -> UIColor {
        return UIColor(red: 4.0/255.0, green: 14.0/255.0, blue: 69.0/255.0, alpha: 1)
    }
    
    func ScreentitleColor() -> UIColor {
        return UIColor(red: 50.0/255.0, green: 58.0/255.0, blue: 69.0/255.0, alpha: 1)
    }
    
    func ThemeGrayColor() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1)
    }
    
    func ThemeBgGroupColor() -> UIColor {
        return UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1)
    }
    
    func ThemeBorderColor() -> UIColor {
        return UIColor(red: 230.0/255.0, green: 232.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    
    
    //MARK: Get stored service count
    
    func getServiceCount() -> Int {

        arrServices = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service.rawValue)
        return arrServices.count
    }
    
    func removeSubmittedLocalStoredServices()  {
        
        var allService = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service.rawValue)
        
        let SelectedService = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service_sel.rawValue)
        
        for dict in SelectedService
        {
            if allService.contains(where: {$0["issueId"] as? Int ==  dict["issueId"] as? Int})
            {
                for dict1 in dict["images"] as? [[String:Any]] ?? []
                {
                    if dict1["videoname"] as? String != ""
                    {
                        CommonFunction.shared.clearFilesFromDirectory(filename: (dict1["videoname"] as? String)!)
                    }
                    else
                    {
                        CommonFunction.shared.clearFilesFromDirectory(filename: (dict1["imagename"] as? String)!)
                    }
                }
                
                allService.removeAll(where: {$0["issueId"] as? Int ==  dict["issueId"] as? Int})
            }
        }
        
        CommonFunction.shared.SaveArrayDatainTextFile(fileName: LocalFileName.service.rawValue , arrData: allService)
        self.images.removeAll()
        CommonFunction.shared.clearFilesFromDirectory(filename: LocalFileName.service_sel.rawValue)
        
        if allService.count == 0
        {
            removeAllLocalStoredServices()
        }
    }
    
    func removeAllLocalStoredServices()
    {
        self.images.removeAll()
        CommonFunction.shared.clearFilesFromDirectory(filename: LocalFileName.service.rawValue)
        CommonFunction.shared.clearFilesFromDirectory(filename: LocalFileName.service_sel.rawValue)
    }
    
    //MARK:  convert 24 hr time to 12 hr

    func string24To12String(time:String) -> String
    {
        var strTime = ""
        let arrTime = time.components(separatedBy: " - ")
        if arrTime.count > 1
        {
            let dateF = DateFormatter()
            dateF.dateFormat = "HH:mm"
            guard let date1 = dateF.date(from: arrTime[0]) else { return strTime }
            guard let date2 = dateF.date(from: arrTime[1]) else { return strTime }
            dateF.dateFormat = "hh:mm a"
            let strDate1 = dateF.string(from: date1)
            let strDate2 = dateF.string(from: date2)
            strTime = strDate1 + " - " + strDate2
            return strTime
        }
        
        return strTime
    }
    
    
    //MARK: Label Fetching according language
    
    func getLabelValue(Id:String) -> String
    {
        var arrlables = [[String:Any]]()
        for i in 0..<arrLabels.count
        {
            let value = arrLabels[i].toDictionary()
            arrlables.append(value)
        }
        var strLableValue = ""
        let strid = Id
        let filteredArray = arrlables.filter({ $0["label_id"] as? String == strid })
        if filteredArray.count > 0
        {
            strLableValue = filteredArray[0]["label_value"] as? String ?? ""
        }
        return strLableValue
    }
    
    //MARK: Quotation Rejected function
    func isQuotationRejected(jobRequestData : JobIssueList) -> Bool {
        
        let arrSelectedService = jobRequestData.jobrequestitems.filter({$0.status == 8 || $0.status == 11})
        if arrSelectedService.count == jobRequestData.jobrequestitems.count  //  Quotation rejected
        {
            return true
        }
        
        return false

    }

}

extension Notification.Name {
    
    static let ImShLoginStatusChanged = Notification.Name.init("ImShLoginStatusChanged")
    
}
