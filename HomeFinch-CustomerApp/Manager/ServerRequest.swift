//
//  ServerRequest.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation
import Alamofire
import ImShExtensions
import SwiftyJSON
import Firebase
import CoreLocation


class ServerRequest {
    
    /// Singleton object
    static let shared = ServerRequest()
    
    class var isConnected: Bool {
        let manager = NetworkReachabilityManager.init(host: "www.google.com")
        return manager?.isReachable ?? false
    }

    /// - Parameters:
    ///   - delegate: ServerRequestDelegate
    ///   - completion: ()
    ///   - failure: Error msg if any, String
    
    
//    func sendOtpToMobileNumber(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
//    {
//
//        let username = "ACdfec167f0c9d74c55fc834f7eef5e660"
//        let password = "384132b0801350edb2514d94034d200e"
//        let loginString = String(format: "%@:%@", username, password)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//
//        let parameters = [
//            "Channel": "sms",
//            "To": "+918866181256"
//        ]
//
//
//
//        let urlPath = "https://verify.twilio.com/v2/Services/VAd0a3ee8c45de1118eee94f8355fc03da/Verifications"
//        var components = URLComponents(string: urlPath)!
//
//        //        var requestBody = URLComponents()
//        var queryItems = [URLQueryItem]()
//
//        for (key, value) in parameters {
//            let item = URLQueryItem(name: key, value: value)
//            queryItems.append(item)
//        }
//
//        components.queryItems = queryItems
//
//
//        let url = components.url!
//
//        var request = URLRequest(url: url)
//
//        let session: URLSession = {
//            let config = URLSessionConfiguration.default
//            return URLSession(configuration: config)
//        }()
//
//
//        //        let Url = String(format: "https://verify.twilio.com/v2/Services/VAd0a3ee8c45de1118eee94f8355fc03da/Verifications")
//        //        guard let serviceUrl = URL(string: Url) else { return }
//        //        var request = URLRequest(url: serviceUrl)
//        request.httpMethod = "POST"
//
//
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//
//        //        request.httpBody = requestBody.query?.data(using: .utf8)
//
//
//        //        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
    
    
    //MARK: twilio Api function
    
    func sendOtpToMobileNumber(phoneNumber : String , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: [String:Any]) -> Void, failure: ((String) -> Void)? = nil) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let username = TW_Account_Id1
        let password = TW_Auth_Token1
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
                
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "To", value: phoneNumber.addingPercentEncodingForQueryParameter()),URLQueryItem(name: "Channel", value: "sms")]

        let Url = String(format: "https://verify.twilio.com/v2/Services/%@/Verifications",Verify_Sercice_Id)
        guard let serviceUrl = URL(string: Url) else { return }
//        let parameterDictionary = requestInfo
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = requestBody.query?.data(using: .utf8 , allowLossyConversion: true)


        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            if error != nil
            {
                failure?(error.debugDescription)
                return
            }
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    completion(json as! [String : Any])
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    


    func verifyOtpNumber(code:String , phoneNumber : String , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: [String:Any]) -> Void, failure: ((String) -> Void)? = nil) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let username = TW_Account_Id1
        let password = TW_Auth_Token1
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
                
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "To", value: phoneNumber.addingPercentEncodingForQueryParameter()),URLQueryItem(name: "Code", value: code)]

        let Url = String(format: "https://verify.twilio.com/v2/Services/%@/VerificationCheck",Verify_Sercice_Id)
        guard let serviceUrl = URL(string: Url) else { return }  
//        let parameterDictionary = requestInfo
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = requestBody.query?.data(using: .utf8 , allowLossyConversion: true)


        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            if error != nil
            {
                failure?(error.debugDescription)
                return
            }

            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    completion(json as! [String : Any])
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func initiateCall(phoneNumber : String , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ result: Bool) -> Void) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let params = ["phone_number":phoneNumber]
       
        let Url = String(format: "https://homefinch.viitor.cloud/api/call")
        guard let serviceUrl = URL(string: Url) else { return }
//        let parameterDictionary = requestInfo
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
               return
           }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let response = json as! [String : Any]
                    completion(response["status"] as? Bool ?? false)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func sendEmailOndisableOtp(delegate: ServerRequestDelegate? = nil,
                       completion: (() -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["id" : UserSettings.shared.getCustomerId()]
        
        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["three-attempt-otp-failed-email"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func CreateSession(sessionName : String , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ sessionId:String) -> Void) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let username = TW_Account_Id1
        let password = TW_Auth_Token1
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let params = ["UniqueName":sessionName]

        let Url = String(format: "https://proxy.twilio.com/v1/Services/KS5a25c81f4fdb2ce51949fae1717779ec/Sessions")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
               return
           }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                 DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        let response = json as! [String : Any]
                        completion(response["sid"] as? String ?? "")
                    } catch {
                        print(error)
                    }
                }
            }
            

        }.resume()
    }
    
    func getMaskedNumber(friendlyName : String ,sessionSID : String ,phoneNumber : String , phoneNumberProxy: String , delegate: ServerRequestDelegate? = nil, completion:@escaping (_ number:String) -> Void) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let username = TW_Account_Id1
        let password = TW_Auth_Token1
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let Url = String(format: "https://proxy.twilio.com/v1/Services/KS5a25c81f4fdb2ce51949fae1717779ec/Sessions/%@/Participants",sessionSID)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        var requestBody = URLComponents()
        requestBody.queryItems = [URLQueryItem(name: "Identifier", value: phoneNumber.addingPercentEncodingForQueryParameter()),URLQueryItem(name: "FriendlyName", value: friendlyName),URLQueryItem(name: "ProxyIdentifier", value: phoneNumberProxy.addingPercentEncodingForQueryParameter())]

        
        request.httpBody = requestBody.query?.data(using: .utf8 , allowLossyConversion: true)
        
//        let paramDict = ["Identifier":phoneNumber,"FriendlyName":friendlyName,"ProxyIdentifier":phoneNumberProxy]
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: paramDict, options: [.fragmentsAllowed]) else {
//               return
//           }
//        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                 DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        let response = json as! [String : Any]
                        completion(response["proxy_identifier"] as? String ?? "")
                    } catch {
                        print(error)
                    }
                }
            }
            
        }.resume()
    }
    
    //MARK: -----------------  Soap Api function -----------------------------
    func GetList(requestInfo:[String:Any] , delegate: ServerRequestDelegate? = nil, completion: (_ result: [String:Any]) -> Void) -> Void
    {
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let username = "_PHIXE_TEST"
        let password = "Solex123"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        
        let soapMessage = String(format: "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:glob=\"http://sap.com/xi/SAPGlobal20/Global\"><soap:Body><glob:CodeListByIDQuery_sync><CodeListSelectionByID><SelectionByCodeDataType><Name>CountryCode</Name><NamespaceURI>http://sap.com/xi/Common/DataTypes</NamespaceURI></SelectionByCodeDataType><SelectionByLanguageCode>EN</SelectionByLanguageCode></CodeListSelectionByID></glob:CodeListByIDQuery_sync></soap:Body></soap:Envelope>")
    
        
        let soapURL = URL(string: "https://my350404.sapbydesign.com/sap/bc/srt/scs/sap/querycodelistin?sap-vhost=my350404.sapbydesign.com")!
        var request = URLRequest(url: soapURL)
        
        let msgLength = soapMessage.count
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        request.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        
//        request.addValue("http://0031178908-one-off.sap.com/xi/Common/DataTypes/QueryCodeListIn/FindCodeListByIDRequest", forHTTPHeaderField: "soapAction")
        
        request.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        
        request.httpMethod = "POST"
        request.httpBody = soapMessage.data(using: String.Encoding.utf8 , allowLossyConversion: false)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            guard error == nil && data != nil else {
                print("Connection error or data is nil !")
                return
            }
            
            if response != nil {
            }
            
//            let xmlString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)

            
//            do {
//                let xmlDictionary = try XMLReader.dictionary(forXMLData: data)
//                let dict1 = xmlDictionary["soap-env:Envelope"] as? [String:Any]
//                let dict2 = dict1?["soap-env:Body"] as? [String:Any]
//                let dict3 = dict2?["n0:CodeListByIDResponse_sync"] as? [String:Any]
//                let dict4 = dict3?["CodeList"] as? [String:Any]
//                let arrList = dict4?["Code"] as? [[String:Any]]
//
//                print(arrList?[0] as? [String:Any] ?? [:])
//
//
//            } catch let error as NSError {
//                print(error)
//            }
        })
        
        task.resume()
    }
    
    //MARK: ----------------- Multipart api function -----------------------
    
    func UpdateCustomerwithImage(imgProfile : UIImage? = nil,customer:SignUpCustomer ,delegate: ServerRequestDelegate? = nil,
                       completion: ((SignUpCustomer) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = customer.toDictionary1()
        
        let serverUrl = ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: [UserSettings.shared.getCustomerId(),"update"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in params {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            if let imgData = imgProfile?.jpegData(compressionQuality: 0)
            {
                let key = "avatar"
                multipartFormData.append(imgData as Data, withName: key, fileName: "imageProfile.jpg", mimeType: "image/jpeg")
            }

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let signupResp = SignupResp.init(fromJson: responseJson)
                        if let data = signupResp.data
                        {
                            completion?(data)
                        }
                        else
                        {
                            failure?(responseJson.getRespMsg())
                        }
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                    
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func CreateJobList(isCloneItem : String ,customerId : String ,dictPara: AddService,
                     delegate: ServerRequestDelegate? = nil,
                     completion: ((Jobrequestitem) -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        

        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store-job-list"])

        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(customerId.data(using: String.Encoding.utf8)!, withName: "customer_id")
            multipartFormData.append(dictPara.customerName.data(using: String.Encoding.utf8)!, withName: "customer_name")
            multipartFormData.append(dictPara.customerMobile.data(using: String.Encoding.utf8)!, withName: "customer_mobile")
            multipartFormData.append(dictPara.createdBy.data(using: String.Encoding.utf8)!, withName: "created_by")
            
            if isCloneItem == "1"
            {
                let issueid = String(format: "%d", dictPara.issueId)
                let jrId = String(format: "%d", dictPara.jobReqId)

                multipartFormData.append(issueid.data(using: String.Encoding.utf8)!, withName: "issue[0]")
                multipartFormData.append(jrId.data(using: String.Encoding.utf8)!, withName: "job_request_id")
                multipartFormData.append(isCloneItem.data(using: String.Encoding.utf8)!, withName: "is_clone_item")
                multipartFormData.append("1".data(using: String.Encoding.utf8)!, withName: "abandoned")
            }
            
            if let reqItem =  dictPara.issueItem
            {
                for i in 0..<reqItem.count {
                    
                    let dictIssue = dictPara.issueItem[i]
                    let categoryId  = String(format: "%d", dictIssue.categoryId)
                    let issueId  = String(format: "%d", dictIssue.issueId)

                    multipartFormData.append(categoryId.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][category_id]")
                    multipartFormData.append(issueId.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][issue_id]")
                    multipartFormData.append(dictIssue.items.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][items]")
                    multipartFormData.append(dictIssue.descriptionField.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][description]")
                    
                    for j in 0..<dictIssue.images.count {

                        let mediaFiles = dictIssue.images[j]
                        if mediaFiles.contains("jpg")
                        {
                            let imgUrl = dictIssue.GetFileUrl(Filename: mediaFiles)
                            
                            print("imageData..........\(imgUrl)")
                            
                            let key = "issue_item[\(i)][images][\(j)]"
                            multipartFormData.append(imgUrl, withName: key, fileName: mediaFiles, mimeType: "image/jpeg")

                        }
                        else
                        {
                            let videoUrl = dictIssue.GetFileUrl(Filename: mediaFiles)
                            
                            if let videoData = NSData(contentsOf: videoUrl)
                            {
                                print("videoData..........\(videoData)")

                                let key = "issue_item[\(i)][images][\(j)]"
                                multipartFormData.append(videoData as Data, withName: key, fileName: mediaFiles, mimeType: "video/mp4")

                            }

                        }

                    }
                }
            }
                        
            
            

        },to: serverUrl as URLConvertible, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let detailResp = JobIssueDetailResp.init(fromJson: responseJson)
                        completion?(detailResp.lastItemData ?? Jobrequestitem.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func createFollowupNewJobRequset(dictPara: [String:String] , jobRequestId : Int , delegate: ServerRequestDelegate? = nil,
                               completion: (([String:Any]) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId  = String(format: "%d", jobRequestId)

        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [jobId,"follow-up"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value as Any)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? [String : Any] ?? [:] )
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func CreateJobRequest(dictPara: AddService , dictIssueIds : [String:String],
                     delegate: ServerRequestDelegate? = nil,
                     completion: ((JobIssueList) -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let customerId  = UserSettings.shared.getCustomerId()
        let propertyId  = String(format: "%d", dictPara.propertyId)
        let status  = String(format: "%d", dictPara.status)
        let subStatus  = String(format: "%d", dictPara.subStatus)


        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store"])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(customerId.data(using: String.Encoding.utf8)!, withName: "customer_id")
            multipartFormData.append(dictPara.distributionChannel.data(using: String.Encoding.utf8)!, withName: "distribution_channel")
            multipartFormData.append(dictPara.customerName.data(using: String.Encoding.utf8)!, withName: "customer_name")
            multipartFormData.append(dictPara.customerMobile.data(using: String.Encoding.utf8)!, withName: "customer_mobile")
            multipartFormData.append(propertyId.data(using: String.Encoding.utf8)!, withName: "property_id")
            multipartFormData.append(dictPara.additinalComment.data(using: String.Encoding.utf8)!, withName: "additinal_comment")
            multipartFormData.append(status.data(using: String.Encoding.utf8)!, withName: "status")
            multipartFormData.append(subStatus.data(using: String.Encoding.utf8)!, withName: "sub_status")
            
            
            if dictPara.skipSlot != nil
            {
                multipartFormData.append(dictPara.skipSlot.data(using: String.Encoding.utf8)!, withName: "enable_select_slot_skip")
                multipartFormData.append(dictPara.skipPayment.data(using: String.Encoding.utf8)!, withName: "skip_generate_payment_link")
            }
            
            if dictPara.skipSlotFix != nil
            {
                multipartFormData.append(dictPara.skipSlotFix.data(using: String.Encoding.utf8)!, withName: "slot_skipped")
            }

            if dictPara.slotid != nil
            {
                multipartFormData.append(dictPara.slotdate.data(using: String.Encoding.utf8)!, withName: "slot_date")
                multipartFormData.append(dictPara.slottime.data(using: String.Encoding.utf8)!, withName: "slot_time")
                multipartFormData.append(dictPara.slotid.data(using: String.Encoding.utf8)!, withName: "slot_id")
                
                if dictPara.subsequentslotId != nil
                {
                    multipartFormData.append(dictPara.subsequentslotId.data(using: String.Encoding.utf8)!, withName: "subsequent_slot_id")
                }
            }
            
            
            for (key, value) in dictIssueIds {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        UserSettings.shared.setContactUserCredential(strname: "", strMobile: "")
                        let detailResp = JobIssueDetailResp.init(fromJson: responseJson)
                        completion?(detailResp.data)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func CreateJobRequestOld(dictPara: AddService,
                     delegate: ServerRequestDelegate? = nil,
                     completion: ((JobIssueList) -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let customerId  = UserSettings.shared.getCustomerId()
        let propertyId  = String(format: "%d", dictPara.propertyId)
        let status  = String(format: "%d", dictPara.status)
        let subStatus  = String(format: "%d", dictPara.subStatus)


        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store"])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(customerId.data(using: String.Encoding.utf8)!, withName: "customer_id")
            multipartFormData.append(dictPara.distributionChannel.data(using: String.Encoding.utf8)!, withName: "distribution_channel")
            multipartFormData.append(dictPara.customerName.data(using: String.Encoding.utf8)!, withName: "customer_name")
            multipartFormData.append(dictPara.customerMobile.data(using: String.Encoding.utf8)!, withName: "customer_mobile")
            multipartFormData.append(propertyId.data(using: String.Encoding.utf8)!, withName: "property_id")
            multipartFormData.append(dictPara.additinalComment.data(using: String.Encoding.utf8)!, withName: "additinal_comment")
            multipartFormData.append(status.data(using: String.Encoding.utf8)!, withName: "status")
            multipartFormData.append(subStatus.data(using: String.Encoding.utf8)!, withName: "sub_status")
            if dictPara.skipSlot != nil
            {
                multipartFormData.append(dictPara.skipSlot.data(using: String.Encoding.utf8)!, withName: "enable_select_slot_skip")
                multipartFormData.append(dictPara.skipPayment.data(using: String.Encoding.utf8)!, withName: "skip_generate_payment_link")
            }

            if dictPara.slotid != nil
            {
                
                multipartFormData.append(dictPara.slotdate.data(using: String.Encoding.utf8)!, withName: "slot_date")

                let slotid  = String(format: "%d", dictPara.slotid)
                multipartFormData.append(dictPara.slottime.data(using: String.Encoding.utf8)!, withName: "slot_time")
                multipartFormData.append(slotid.data(using: String.Encoding.utf8)!, withName: "slot_id")
                multipartFormData.append(dictPara.subsequentslotId.data(using: String.Encoding.utf8)!, withName: "subsequent_slot_id")
            }
            
            print(dictPara.issueItem.count)
            
            for i in 0..<dictPara.issueItem.count {
                
                let dictIssue = dictPara.issueItem[i]
                let categoryId  = String(format: "%d", dictIssue.categoryId)
                let issueId  = String(format: "%d", dictIssue.issueId)

                multipartFormData.append(categoryId.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][category_id]")
                multipartFormData.append(issueId.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][issue_id]")
                multipartFormData.append(dictIssue.items.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][items]")
                multipartFormData.append(dictIssue.descriptionField.data(using: String.Encoding.utf8)!, withName: "issue_item[\(i)][description]")
                
                for j in 0..<dictIssue.images.count {

                    let mediaFiles = dictIssue.images[j]
                    if mediaFiles.contains("jpg")
                    {
                        let imgUrl = dictIssue.GetFileUrl(Filename: mediaFiles)

//                        if let imageData = NSData(contentsOf: imgUrl) {
//
//                            let img = UIImage(data: imageData as Data)
//                            guard let imgData = img!.jpegData(compressionQuality: 0) else { return }
//                            let key = "issue_item[\(i)][images][\(j)]"
//                            multipartFormData.append(imgData as Data, withName: key, fileName: mediaFiles, mimeType: "image/jpeg")
//                        }
                        
                        let key = "issue_item[\(i)][images][\(j)]"
                        multipartFormData.append(imgUrl, withName: key, fileName: mediaFiles, mimeType: "image/jpeg")

                    }
                    else
                    {
                        let videoUrl = dictIssue.GetFileUrl(Filename: mediaFiles)
                        
                        if let videoData = NSData(contentsOf: videoUrl)
                        {
                            print("videoData..........\(videoData)")

                            let key = "issue_item[\(i)][images][\(j)]"
                            multipartFormData.append(videoData as Data, withName: key, fileName: mediaFiles, mimeType: "video/mp4")

                        }
                        
//                        multipartFormData.append(videoUrl, withName: key)
                        
//                        multipartFormData.append(videoUrl, withName:key, fileName: mediaFiles, mimeType: "video/mp4")

                    }

                }
            }
            

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        UserSettings.shared.setContactUserCredential(strname: "", strMobile: "")
                        let detailResp = JobIssueDetailResp.init(fromJson: responseJson)
                        completion?(detailResp.data)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    
    func updateIssueDetailsJobRequest(dictPara: [String:Any],images: [String],
                     delegate: ServerRequestDelegate? = nil,
                     completion: (() -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["item-store"])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            for j in 0..<images.count {

                let mediaFiles = images[j]
                if mediaFiles.contains("jpg")
                {
                    let imgUrl = self.GetFileUrl(Filename: mediaFiles)
                    print(imgUrl)
                    let key = "images[\(j)]"
                    multipartFormData.append(imgUrl, withName: key, fileName: mediaFiles, mimeType: "image/jpeg")

                }
                else
                {
                    let videoUrl = self.GetFileUrl(Filename: mediaFiles)
                    print(videoUrl)
                    if let videoData = NSData(contentsOf: videoUrl)
                    {
                        print("videoData..........\(videoData)")

                        let key = "images[\(j)]"
                        multipartFormData.append(videoData as Data, withName: key, fileName: mediaFiles, mimeType: "video/mp4")

                    }

                }

            }

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value as Any)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func createFollowupJobRequset(dictPara: [String:String] , jobRequestId : Int , delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId  = String(format: "%d", jobRequestId)

        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [jobId,"follow-up"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value as Any)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? [String : Any] ?? [:] )
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func confirmJobQuotation(jobid:Int , dictPara: [String:String],signature : UIImage? = nil,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let id  = String(format: "%d", jobid)

        
        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [id,"quote-store"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            if let imgData = signature?.jpegData(compressionQuality: 0)
            {
                let key = "signature"
                multipartFormData.append(imgData as Data, withName: key, fileName: "imageSignature.jpg", mimeType: "image/jpeg")
            }
            

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value as Any)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    
    func AddPartsToServices(dictPara: [String:String],
                     delegate: ServerRequestDelegate? = nil,
                     completion: (() -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["material-store"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }

        },to: serverUrl, usingThreshold: UInt64.init(),
              method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value as Any)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
                
        }

    }
    
    func GetcalendaerDaysSlotavailability(geoRadarid : String ,month : Int , categoryId : String,sapId : [String:Any],delegate: ServerRequestDelegate? = nil,completion: (([String]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        var dictPara = sapId
        dictPara["selected_month"] = String(format: "%d", month)
        dictPara["category_id"] = categoryId
        dictPara["geofence_id"] = geoRadarid

        let serverUrl = ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["calendar-slot-dot"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
        },to: serverUrl, usingThreshold: UInt64.init(),
        method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
                
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)

            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let timeSlotresp = DateAvailableResp.init(fromJson: responseJson)
                        completion?(timeSlotresp.data)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetTimeSlot(geoRadarid : String ,date : String , categoryId : String,sapId : [String:String] ,delegate: ServerRequestDelegate? = nil,completion: ((TimeSlotResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        var dictPara = sapId
        dictPara["slot_date"] = date
        dictPara["category_id"] = categoryId
        dictPara["geofence_id"] = geoRadarid
        

        let serverUrl = ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["available-slots"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
        },to: serverUrl, usingThreshold: UInt64.init(),
        method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)

            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let timeSlotresp = TimeSlotResp.init(fromJson: responseJson)
                        completion?(timeSlotresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func checkSlotAvailability(slot : TimeSlot, sapId : [String:String] ,delegate: ServerRequestDelegate? = nil,completion: ((TimeSlot) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let id = String(format: "%d", slot.id)
        
        var dictPara = sapId
        dictPara["id"] = id
        dictPara["subsequent_slot_id"] = slot.subsequentSlotId
        
        let serverUrl = ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["check-slot-availability"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in dictPara {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
        },to: serverUrl, usingThreshold: UInt64.init(),
        method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)
            
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let json = responseJson.dictionaryValue["data"]
                        let timeSlotresp = TimeSlot.init(fromJson: json)
                        completion?(timeSlotresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                    
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func rateServices(jobRequestId:Int , ratingType:[String], rating:Int ,comment : String ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        let requestId = String(format: "%d", jobRequestId)
        let starRating = String(format: "%d", rating)

        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["job_request_id":requestId,"overall_rating_by_customer":rating,"remarks_by_customer":comment,"ratings_type":ratingType] as [String : Any]
        
        
        let serverUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [requestId,"additional-update"])
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(requestId.data(using: String.Encoding.utf8)!, withName: "job_request_id")
            multipartFormData.append(starRating.data(using: String.Encoding.utf8)!, withName: "overall_rating_by_customer")
            multipartFormData.append(comment.data(using: String.Encoding.utf8)!, withName: "remarks_by_customer")

            
            for i in 0..<ratingType.count {
                if let strdata = (ratingType[i] as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(strdata, withName: "ratings_type[\(i)]")
                    print(strdata , "ratings_type[\(i)]")
                }
            }
            
        },to: serverUrl, usingThreshold: UInt64.init(),
        method: .post,
        headers: UserSettings.shared.getHeaders1()).response{ response in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                    
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
//    func updateNotificationReadStatus(dictPara:[String:String] ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
//
//
//        DispatchQueue.main.async {
//            delegate?.isLoading(loading: true)
//        }
//
//
//        let serverUrl = ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["notifications","update"],params: dictPara)
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//            for (key, value) in dictPara {
//                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
//                    multipartFormData.append(data, withName: key)
//                }
//            }
//
//        },to: serverUrl, usingThreshold: UInt64.init(),
//        method: .get,
//        headers: UserSettings.shared.getHeaders1()).response{ response in
//             DispatchQueue.main.async {
//                delegate?.isLoading(loading: false)
//            }
//
//            print("Requesting URL", response.request?.description ?? "")
//            print("Parameters", dictPara)
//
//            switch response.result {
//            case .success(let value):
//                let responseJson = JSON.init(value)
//                print("Response : ", responseJson)
//
//                switch response.response?.statusCode ?? 0 {
//                case 200:
//
//                    let data = responseJson.dictionaryObject
//                    if data?["success"] as? Bool == true
//                    {
//                        completion?()
//                    }
//                    else
//                    {
//                        failure?(responseJson.getRespMsg())
//                    }
//
//                default:
//                    failure?(responseJson.getRespMsg())
//                }
//            case .failure(let err):
//                failure?(err.localizedDescription)
//            }
//        }
//
//    }
        
    //MARK: ----------------- Rest Api Function -----------------------------
    
    func GetInitialData(delegate: ServerRequestDelegate? = nil,
                        completion: ((InitialResp) -> Swift.Void)? = nil,
                        failure: ((String) -> Void)? = nil) {
        
        var requestUrl: URL!
        requestUrl = ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["constants","list"])
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let initial = InitialResp.init(fromJson: responseJson)
                        UserSettings.shared.initialData = initial.data
                        UserSettings.shared.arrCustomerTitle = initial.data.customerTitle
                        UserSettings.shared.arrPages = initial.data.pages
                        UserSettings.shared.socialLogin = initial.data.socialLogin
//                        pt_profileID = initial.data.paytabsProfileId
//                        pt_clientKey = initial.data.paytabsSdkClientKey  //sdk
//                        pt_serverKey = initial.data.paytabsSdkServerKey   //sdk
//                        pt_clientapiKey = initial.data.paytabsClientKey   //api
//                        pt_serverapiKey = initial.data.paytabsServerKey   //api
//                        radar_SecretKey = initial.data.radarSecretKey
//                        radar_PublishKey = initial.data.radarPublisherKey
                        completion?(initial)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
    }
    
    func setDeviceToken(token: String,
                        delegate: ServerRequestDelegate? = nil,
                        completion: (() -> Swift.Void)? = nil,
                        failure: ((String) -> Void)? = nil) {
        
        if UserSettings.shared.getCustomerId() == "0"
        {
            return
        }
        
        var requestUrl: URL!
        requestUrl = ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["device-token","store"])
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
                
        let params = [
            "device_token": token,
            "platform": "ios",
            "user_type":"1",
            "reference_id":UserSettings.shared.getCustomerId(),
            "device_id":UUID().uuidString
        ]
        
        AF.request(requestUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            Analytics.logEvent("device_token_registered", parameters: params)
            
            print("Requesting URL", response.request?.description ?? "")
            print("Requesting PARAMETERS:", params)
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
    }
    
    func deleteDeviceToken(token: String,
                        delegate: ServerRequestDelegate? = nil,
                        completion: (() -> Swift.Void)? = nil,
                        failure: ((String) -> Void)? = nil) {
        
        if UserSettings.shared.getCustomerId() == "0"
        {
            return
        }
        
        var requestUrl: URL!
        requestUrl = ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["device-token","delete"])
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
                
        let params = [
            "device_token": token,
            "platform": "ios",
            "user_type":"1",
            "reference_id":UserSettings.shared.getCustomerId(),
            "device_id":UUID().uuidString
        ]
        
        AF.request(requestUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            Analytics.logEvent("device_token_registered", parameters: params)
            
            print("Requesting URL", response.request?.description ?? "")
            print("Requesting PARAMETERS:", params)
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
    }
    
    func GetCountryList(delegate: ServerRequestDelegate? = nil,
                       completion: ((CountryResp) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["country","list"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let countryResp = CountryResp.init(fromJson: responseJson)
                        UserSettings.shared.arrCountry = countryResp.data
                        completion?(countryResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }

    func CheckForexistingUser(mobilenumber:String ,delegate: ServerRequestDelegate? = nil,
                       completion: ((SignUpCustomer) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["check-mobile",mobilenumber]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    let loginResp = LoginResp.init(fromJson: responseJson)
                    completion?(loginResp.data ?? SignUpCustomer.init())

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func CreateCustomer(customer:SignUpCustomer ,delegate: ServerRequestDelegate? = nil,
                       completion: ((SignUpCustomer) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = customer.toDictionary()
        
        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["store"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let signupResp = SignupResp.init(fromJson: responseJson)
                        if let data = signupResp.data
                        {
                            completion?(data)
                        }
                        else
                        {
                            failure?(responseJson.getRespMsg())
                        }
                        
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                    
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func Getwalletbalance(dictPara:[String:Any]? = nil ,delegate: ServerRequestDelegate? = nil,completion: ((String) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["balance",UserSettings.shared.getCustomerId()]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? String ?? "AED 0.00")
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetwalletTransactionHistory(delegate: ServerRequestDelegate? = nil,completion: ((TransactionResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {

         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["transactions", UserSettings.shared.getCustomerId()]), method: .get , parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)

                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let listResp = TransactionResp.init(fromJson: responseJson)
                        completion?(listResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }

    }
    
    func GetCustomerInfo(delegate: ServerRequestDelegate? = nil,
                       completion: ((SignUpCustomer) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: [UserSettings.shared.getCustomerId(),"show"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let signResp = SignupResp.init(fromJson: responseJson)
                        completion?(signResp.data ?? SignUpCustomer.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    func UpdateCustomer(customer:SignUpCustomer ,delegate: ServerRequestDelegate? = nil,
                       completion: ((SignUpCustomer) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = customer.toDictionary()
        
        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: [UserSettings.shared.getCustomerId(),"update"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let signupResp = SignupResp.init(fromJson: responseJson)
                        completion?(signupResp.data ?? SignUpCustomer.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func CreateNewProperty(property:PropertyDataModel ,delegate: ServerRequestDelegate? = nil,
                       completion: ((PropertyDetailData) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = property.toDictionary()
        
        AF.request(ApiConfig.shared.getApiURL(.property, mainPath: "property", subDir: ["store"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let property = PropertyResp.init(fromJson: responseJson)
                        completion?(property.data ?? PropertyDetailData.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetPropertyList(delegate: ServerRequestDelegate? = nil,
                       completion: ((PropertyListResp) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["customer_id":UserSettings.shared.getCustomerId()]
        
        AF.request(ApiConfig.shared.getApiURL(.property, mainPath: "property", subDir: ["list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let propertyResp = PropertyListResp.init(fromJson: responseJson)
                        completion?(propertyResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func UpdateProperty(propertyId:String ,property:PropertyDataModel ,delegate: ServerRequestDelegate? = nil, completion: ((PropertyDetailData) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = property.toDictionary()
        
        AF.request(ApiConfig.shared.getApiURL(.property, mainPath: "property", subDir: [propertyId,"update"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let property = PropertyResp.init(fromJson: responseJson)
                        completion?(property.data ?? PropertyDetailData.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func getNotificationSetting(delegate: ServerRequestDelegate? = nil,completion: ((NotificationData) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["reference_id":UserSettings.shared.getCustomerId(),"user_type":"1"] as [String : Any]
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["settings","show"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let notifi = NotificationResp.init(fromJson: responseJson)
                        completion?(notifi.data ?? NotificationData.init())
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    
    func updateNotificationSetting(status:Int ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["reference_id":UserSettings.shared.getCustomerId(),"user_type":"1","notification":status] as [String : Any]
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["settings","store"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func updateNotificationReadStatus(dictPara:[String:String] ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {

        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["notifications","update"],params: dictPara), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)

                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }

    }
    
    func updateAppRating(rating:Int ,comment : String ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["reference_id":UserSettings.shared.getCustomerId(),"user_type":"1","rating":rating,"comment":comment] as [String : Any]
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["ratings","store"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }

    func GetNotificationList(delegate: ServerRequestDelegate? = nil,
                       completion: ((NotificationResp) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["receiver_id":UserSettings.shared.getCustomerId(),"user_type":"1"]
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["notifications","list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let notResp = NotificationResp.init(fromJson: responseJson)
                        completion?(notResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func ClearNotificationList(delegate: ServerRequestDelegate? = nil,
                       completion: (() -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["receiver_id":UserSettings.shared.getCustomerId(),"user_type":"1"]
        
        AF.request(ApiConfig.shared.getApiURL(.general, mainPath: "general", subDir: ["notifications","delete"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetCategoryList(delegate: ServerRequestDelegate? = nil,
                       completion: ((CategoryListResp) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["is_hide" : "1"]

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-category-list"],params:params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let catResp = CategoryListResp.init(fromJson: responseJson)
                        completion?(catResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetCategoryWiseIssueList(CatId : String ,delegate: ServerRequestDelegate? = nil,completion: ((CategoryIssueResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["category_id":CatId,"issue_type":"1"]

                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-issue-list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let categoryresp = CategoryIssueResp.init(fromJson: responseJson)
                        completion?(categoryresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetServiceWiseIssueList(serviceId : String ,delegate: ServerRequestDelegate? = nil,completion: ((CategoryIssueResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["service_id":serviceId]

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-issue-list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let categoryresp = CategoryIssueResp.init(fromJson: responseJson)
                        completion?(categoryresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    // for search screen
    func GetAllIssueList(delegate: ServerRequestDelegate? = nil,completion: ((CategoryIssueResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["issue_type":"1"] // 1 for customer

        
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-issue-list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let categoryresp = CategoryIssueResp.init(fromJson: responseJson)
                        completion?(categoryresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    
//    func GetcalendaerDaysSlotavailability(geoRadarid : String ,month : Int , categoryId : String,sapId : [String:Any],delegate: ServerRequestDelegate? = nil,completion: (([String]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
//
//        DispatchQueue.main.async {
//            delegate?.isLoading(loading: true)
//        }
//
//        var dictPara = sapId
//        dictPara["selected_month"] = month
//        dictPara["category_id"] = categoryId
//        dictPara["geofence_id"] = geoRadarid
//
//
////        let params = ["selected_month":month,"category_id":categoryId,"geofence_id":geoRadarid,"service_id_sap":sapId] as [String : Any]
//
//        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["calendar-slot-dot"]), method: .post, parameters: dictPara, encoding: URLEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
//             DispatchQueue.main.async {
//                delegate?.isLoading(loading: false)
//            }
//
//            print("Requesting URL", response.request?.description ?? "")
//            print("Parameters", dictPara)
//
//
//            switch response.result {
//            case .success(let value):
//                let responseJson = JSON.init(value)
//                print("Response : ", responseJson)
//
//                switch response.response?.statusCode ?? 0 {
//                case 200:
//                    let timeSlotresp = DateAvailableResp.init(fromJson: responseJson)
//                    completion?(timeSlotresp.data)
//
//                default:
//                    failure?(responseJson.getRespMsg())
//                }
//            case .failure(let err):
//                failure?(err.localizedDescription)
//            }
//        }
//
//    }
//
//    func GetTimeSlot(geoRadarid : String ,date : String , categoryId : String,sapId : [String:Any] ,delegate: ServerRequestDelegate? = nil,completion: ((TimeSlotResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
//
//
//        DispatchQueue.main.async {
//            delegate?.isLoading(loading: true)
//        }
//
//        var dictPara = sapId
//        dictPara["slot_date"] = date
//        dictPara["category_id"] = categoryId
//        dictPara["geofence_id"] = geoRadarid
//
//
////        let params = ["slot_date":date,"category_id":categoryId]
//
//
////        let params = ["slot_date":date,"category_id":categoryId,"geofence_id":geoRadarid,"service_id_sap":sapId]
//
//
//
//        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["available-slots"]), method: .post, parameters: dictPara, encoding: URLEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
//             DispatchQueue.main.async {
//                delegate?.isLoading(loading: false)
//            }
//
//            print("Requesting URL", response.request?.description ?? "")
//            print("Parameters", dictPara)
//
//
//            switch response.result {
//            case .success(let value):
//                let responseJson = JSON.init(value)
//                print("Response : ", responseJson)
//
//                switch response.response?.statusCode ?? 0 {
//                case 200:
//                    let timeSlotresp = TimeSlotResp.init(fromJson: responseJson)
//                    completion?(timeSlotresp)
//
//                default:
//                    failure?(responseJson.getRespMsg())
//                }
//            case .failure(let err):
//                failure?(err.localizedDescription)
//            }
//        }
//
//    }
    
//    func checkSlotAvailability(slot : TimeSlot, sapId : [String:Any] ,delegate: ServerRequestDelegate? = nil,completion: ((TimeSlot) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
//
//        DispatchQueue.main.async {
//            delegate?.isLoading(loading: true)
//        }
//
//        let id = String(format: "%d", slot.id)
//
//        var dictPara = sapId
//        dictPara["id"] = id
//        dictPara["subsequent_slot_id"] = slot.subsequentSlotId
//
//
//        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["check-slot-availability"]), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
//             DispatchQueue.main.async {
//                delegate?.isLoading(loading: false)
//            }
//
//            print("Requesting URL", response.request?.description ?? "")
//            print("Parameters", dictPara)
//
//
//            switch response.result {
//            case .success(let value):
//                let responseJson = JSON.init(value)
//                print("Response : ", responseJson)
//
//                switch response.response?.statusCode ?? 0 {
//                case 200:
//
//                    let data = responseJson.dictionaryObject
//                    if data?["success"] as? Bool == true
//                    {
//                        let json = responseJson.dictionaryValue["data"]
//                        let timeSlotresp = TimeSlot.init(fromJson: json)
//                        completion?(timeSlotresp)
//                    }
//                    else
//                    {
//                        failure?(responseJson.getRespMsg())
//                    }
//
//                default:
//                    failure?(responseJson.getRespMsg())
//                }
//            case .failure(let err):
//                failure?(err.localizedDescription)
//            }
//        }
//
//    }
    
    func BlockUnblockTimeSlot(slotId : Int , blocked : String,delegate: ServerRequestDelegate? = nil,completion: ((Bool) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["id":slotId,"blocked":blocked] as [String : Any]
                
        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["block-unblock-slot"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)

            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    
                    if let response = responseJson.dictionaryValue["data"]?.dictionaryValue
                    {
                        if response["available"]?.boolValue == true
                        {
                            completion?(true)
                        }
                        else
                        {
                            completion?(false)
                        }
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func addOnServiceHighDemand(delegate: ServerRequestDelegate? = nil,completion: ((Jobservice) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["service_id_sap":"S_OT0002"] as [String : Any]
                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["high-demand-service"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)

            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let serviceResp = serviceDataResp.init(fromJson: responseJson)
                        completion?(serviceResp.data)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }

    
    func GetJobRequestList(type : String ,delegate: ServerRequestDelegate? = nil,completion: ((JobIssueListResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["customer_id":UserSettings.shared.getCustomerId(),"type":type]

                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["list"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let issueListresp = JobIssueListResp.init(fromJson: responseJson)
                        completion?(issueListresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetJobRequestDetail(requestId : Int ,delegate: ServerRequestDelegate? = nil,completion: ((JobIssueList) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId = String(format: "%d", requestId)
        
        let params = ["job_request_id":jobId]

                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [jobId,"show"], params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            Analytics.logEvent("View Jobs", parameters: params)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let issueListresp = JobIssueDetailResp.init(fromJson: responseJson)
                        completion?(issueListresp.data)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func CancelQuotation(jobRequestId:Int , reason:String ,comment : String ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        let requestId = String(format: "%d", jobRequestId)
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["job_request_id":requestId,"cacellation_reason":reason,"cacellation_remarks":comment,"updated_by":UserSettings.shared.getCustomerId()] as [String : Any]
        
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [requestId,"additional-update"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func UpdateJobstatusApiIntegration(jobid:Int ,dictPara : [String : Any] ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let id  = String(format: "%d", jobid)
        
        var dictdata = dictPara
        dictdata["created_by"] = UserSettings.shared.getCustomerId()

                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [id,"update-job-status"]), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func UpdateJobstatusApiIntegration1(jobid:Int ,dictPara : [String : Any] ,delegate: ServerRequestDelegate? = nil,completion: ((JobIssueList) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {

         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        let id  = String(format: "%d", jobid)

        var dictdata = dictPara
        dictdata["created_by"] = UserSettings.shared.getCustomerId()
                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [id,"update-job-status"]), method: .post, parameters: dictdata, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }

            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictdata)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)

                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(JobIssueList.init(fromJson: responseJson["data"]))
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }

    }
    
    func UpdateJobIssueStatusApiIntegration(jobid:Int ,dictPara : [String : String] ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let id  = String(format: "%d", jobid)
                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [id,"item-update"]), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", dictPara)
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetServiceList(dictPara : [String:String] ,delegate: ServerRequestDelegate? = nil,completion: ((ServiceListResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
                
        AF.request(ApiConfig.shared.getApiURL(.inventory, mainPath: "inventory", subDir: ["service","list"], params: dictPara), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let serviceresp = ServiceListResp.init(fromJson: responseJson)
                        completion?(serviceresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    func jobCompleteupdate(id : Int,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let ServiceId = String(format: "%d", id)
        
        let params = ["job_complate":"1","job_request_id":ServiceId]

                
        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: [ServiceId,"job-cycle-params"]), method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func storeaddOnServices(dictPara: [String:Any],service:String ,
                     delegate: ServerRequestDelegate? = nil,
                     completion: (() -> Swift.Void)? = nil,
                     failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [service]), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    func cancelJobRequest(jobRequestId : Int , status : Int ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId = String(format: "%d", jobRequestId)
        let JRStatus = String(format: "%d", status)

                
        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["record-job-with-slot",jobId,"cancel"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func updateJobReqEstimation(jobRequestId : Int ,delegate: ServerRequestDelegate? = nil,completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId = String(format: "%d", jobRequestId)

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [jobId,"update-estimation-time"]), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    func checkforConfiguration(delegate: ServerRequestDelegate? = nil,
                               completion: (([String:Any]) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        

        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["configuration-rule/1/show"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? [String : Any] ?? [:] )
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    
    func getJobListData(delegate: ServerRequestDelegate? = nil,
                               completion: ((IssueListResp) -> Swift.Void)? = nil,
                       failure: ((String) -> Void)? = nil) {
        
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let customerId = UserSettings.shared.getCustomerId()
        
        let params = ["customer_id":customerId]
        
        let requestUrl = ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-job-list"])

        AF.request(requestUrl as! URLConvertible, method: .post, parameters: params, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("Parameters", params)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let issueListresp = IssueListResp.init(fromJson: responseJson)
                        completion?(issueListresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func updateCustomerContactInfo(JobReqId : String , dictPara : [String:Any] ,delegate: ServerRequestDelegate? = nil, completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [JobReqId, "update"]), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? [String : Any] ?? [:] )
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func removeJobIssue(JobItemId : String ,delegate: ServerRequestDelegate? = nil, completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [JobItemId, "remove-item"]), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(data?["data"] as? [String : Any] ?? [:] )
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    func getCustomerContactList(delegate: ServerRequestDelegate? = nil, completion: ((contactlistResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let params = ["customer_id" : UserSettings.shared.getCustomerId()]

        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["contact-list"] , params: params), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let contactListResp = contactlistResp.init(fromJson: responseJson)
                        completion?(contactListResp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }

    
    func setCustomerStore(dictPara:[String:Any] ,delegate: ServerRequestDelegate? = nil, completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.customer, mainPath: "customer", subDir: ["contact-store"] ), method: .post, parameters: dictPara, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func removeImageAttachment(imageId : String,delegate: ServerRequestDelegate? = nil, completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["remove-image",imageId] ), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func removeJobitem(itemId : String,delegate: ServerRequestDelegate? = nil, completion: (() -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
//        let params = ["item_id":itemId]

        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: [itemId,"remove-item"] ), method: .post, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?()
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }
                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetTopTrendingIssueList(delegate: ServerRequestDelegate? = nil,completion: ((trendingIssuelistResp) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-popular-issue-list"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        let categoryresp = trendingIssuelistResp.init(fromJson: responseJson)
                        completion?(categoryresp)
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func getJobRequestStatus(jobId:Int, delegate: ServerRequestDelegate? = nil, completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let jobId = String(format: "%d", jobId)
        
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["get-job-status",jobId]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(responseJson.dictionaryObject ?? [:])
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    
    //MARK:  PayTabs api function
    
    func CreateTransactionApi(dict:[String:Any],delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let requestURL = URL(string: String(format: "https://secure.paytabs.com/payment/request"))
        
        let headers : HTTPHeaders = ["Authorization" : pt_serverapiKey,"content-type":"application/json"]
        
        AF.request(requestURL! , method: .post, parameters: dict, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("params", dict)

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    completion?(responseJson.dictionaryObject ?? [:])

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func StoreTransactionApi(dict:[String:Any],delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
                
        AF.request(ApiConfig.shared.getApiURL(.jobrequest, mainPath: "jobrequest", subDir: ["store-payment-request"]) , method: .post, parameters: dict, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            print("params", dict)


            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(responseJson.dictionaryObject ?? [:])
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    //MARK: Radar Api
    
    func GetUserDistance(current0 : String , current1 : String,dest0 : String , dest1 : String, delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let requestURL = URL(string: String(format: "https://api.radar.io/v1/route/distance?origin=%@&destination=%@&modes=car&units=imperial","\(current0),\(current1)","\(dest0),\(dest1)"))
        
        let headers : HTTPHeaders = ["Authorization" : radar_PublishKey]
        
        AF.request(requestURL! , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    completion?(responseJson.dictionaryObject ?? [:])

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetUser(performerid : String , delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
         DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let requestURL = URL(string: String(format: "https://api.radar.io/v1/users",performerid))
        
        let headers : HTTPHeaders = ["authorization" : radar_SecretKey]
        print(headers)
        
        AF.request(requestURL! , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    completion?(responseJson.dictionaryObject ?? [:])

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetPerformerOnmapHistory(extrtnalId:String , geofenceTag:String ,delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
        
        let requestURL = URL(string: String(format: "https://api.radar.io/v1/trips?active=true&destinationGeofenceExternalId=%@", extrtnalId))
        
        let headers : HTTPHeaders = ["Authorization" : radar_SecretKey]
        
        AF.request(requestURL! , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")

            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(responseJson.dictionaryObject ?? [:])
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    func GetPerformerJourneyStatusUpdate(jobreqId:String ,delegate: ServerRequestDelegate? = nil,completion: (([String:Any]) -> Swift.Void)? = nil,failure: ((String) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            delegate?.isLoading(loading: true)
        }
                
        AF.request(ApiConfig.shared.getApiURL(.employees, mainPath: "employee", subDir: ["job-request-assignment",jobreqId,"show"]), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: UserSettings.shared.getHeaders()).responseJSON { (response) in
             DispatchQueue.main.async {
                delegate?.isLoading(loading: false)
            }
            
            print("Requesting URL", response.request?.description ?? "")
            
            switch response.result {
            case .success(let value):
                let responseJson = JSON.init(value)
                print("Response : ", responseJson)
                    
                switch response.response?.statusCode ?? 0 {
                case 200:
                    let data = responseJson.dictionaryObject
                    if data?["success"] as? Bool == true
                    {
                        completion?(responseJson.dictionaryObject ?? [:])
                    }
                    else
                    {
                        failure?(responseJson.getRespMsg())
                    }

                default:
                    failure?(responseJson.getRespMsg())
                }
            case .failure(let err):
                failure?(err.localizedDescription)
            }
        }
        
    }
    
    //MARK: Functions
    
    func GetFileUrl(Filename:String) -> URL
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let fileDataPath = documentsDirectory + "/" + Filename
        let filePathURL = URL(fileURLWithPath: fileDataPath)
        return filePathURL
    }

    
}

@objc protocol ServerRequestDelegate: class {
    func isLoading(loading: Bool)
    @objc optional func progress(value: Double)
}

extension JSON {
    func getRespMsg() -> String {
        return self["message"].stringValue
    }
}
extension String {
    public func addingPercentEncodingForQueryParameter() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)

        return allowed
    }()
}



//                var error: Error?
//                var jsonData: Data? = nil
//                do {
//                    jsonData = try JSONSerialization.data(
//                        withJSONObject: xmlDictionary,
//                        options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
//
//                    var responseDictionary: [AnyHashable : Any]? = nil
//                    do {
//                        responseDictionary = try JSONSerialization.jsonObject(
//                            with: jsonData!,
//                            options: []) as? [AnyHashable : Any]
//                    } catch {
//                    }
//
//                    print(responseDictionary)
//                }
//               catch let error as NSError {
//                               print(error)
//                           }


