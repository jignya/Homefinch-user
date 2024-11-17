//
//  Utils.swift
//
//  Copyright © 2016 Twilio. All rights reserved.
//

import Foundation

// Helper to determine if we're running on simulator or device
struct PlatformUtils {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

struct TokenUtils {
    
    static func retrieveToken(url: String , identity : String, completion: @escaping (String?, String?, Error?) -> Void) {
        if let requestURL = URL(string: url) {
            let parameterDictionary = ["email" : identity,"roleId":"1"]
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.allHTTPHeaderFields = ["platform" : "ios" , "app_version" : "1.0"]
            
            print(request.debugDescription)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let tokenData = json as? [String: String] {
                            print(tokenData)
                            let token = tokenData["token"]
                            let identity = tokenData["identity"]
                            completion(token, identity, error)
                        } else {
                            completion(nil, nil, nil)
                        }
                    } catch let error as NSError {
                        completion(nil, nil, error)
                    }
                } else {
                    completion(nil, nil, error)
                }

            }.resume()

        }
    }

//    static func retrieveToken(url: String, completion: @escaping (String?, String?, Error?) -> Void) {
//        if let requestURL = URL(string: url) {
//            let session = URLSession(configuration: URLSessionConfiguration.default)
//            let task = session.dataTask(with: requestURL, completionHandler: { (data, _, error) in
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        if let tokenData = json as? [String: String] {
//                            let token = tokenData["token"]
//                            let identity = tokenData["identity"]
//                            completion(token, identity, error)
//                        } else {
//                            completion(nil, nil, nil)
//                        }
//                    } catch let error as NSError {
//                        completion(nil, nil, error)
//                    }
//                } else {
//                    completion(nil, nil, error)
//                }
//            })
//            task.resume()
//        }
//    }
}
