//
//  ApiConfig.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation

class ApiConfig: NSObject {
    
    static let shared = ApiConfig()
    
    private override init() {}

    //MARK: viitor cloud URL and path

//    fileprivate func getApiBaseLink(path:String) -> String {
//        let language = ImShLanguage.shared.get()
//        switch language {
//        case .english:
//            return String(format: "https://hf-%@.viitor.cloud/api", path)
//        case .arabic:
//            return String(format: "https://hf-%@.viitor.cloud/api", path)
//        }
//    }
    
    //MARK: Staging URL and path
    
    let baseUrl = "https://staging.homefinch.com/api"
    let baseUrl1 = "https://staging.homefinch.com"

    fileprivate func getApiBaseLink(path:String) -> String {
        let language = ImShLanguage.shared.get()
        switch language {
        case .english:
            return "https://staging.homefinch.com/api"
        case .arabic:
            return "https://staging.homefinch.com/api"
        }
    }
    
    //MARK: Production URL and path

//    let baseUrl = "https://admin.homefinch.com/api"
//    let baseUrl1 = "https://admin.homefinch.com"
//
//    fileprivate func getApiBaseLink(path:String) -> String {
//        let language = ImShLanguage.shared.get()
//        switch language {
//        case .english:
//            return "https://admin.homefinch.com/api"
//        case .arabic:
//            return "https://admin.homefinch.com/api"
//        }
//    }
    
    func getApiURL(_ apiPath: ApiPath ,mainPath: String ,route: ApiRoute? = nil) -> URL {
        if let r = route
        {
            let urlStr = "\(getApiBaseLink(path: mainPath))/\(r.rawValue)/\(apiPath.rawValue)"
            return urlStr.getURL!
        }
        else
        {
            let urlStr = "\(getApiBaseLink(path: mainPath))/\(apiPath.rawValue)"
            return urlStr.getURL!
        }
    }
    
    func getApiURL(_ apiPath: ApiPath ,mainPath: String ,route: ApiRoute? = nil, subDir: [String]) -> URL {
        var urlStr = getApiURL(apiPath, mainPath: mainPath, route: route).absoluteString
        for dir in subDir {
            urlStr += "/\(dir)"
        }
        return urlStr.getURL!
    }
    
    
    
    func getApiURL(_ apiPath: ApiPath ,mainPath: String , route: ApiRoute? = nil, subDir: [String], params: [String: String]) -> URL {
        var urlStr = getApiURL(apiPath, mainPath: mainPath, route: route, subDir: subDir).absoluteString
        for (index, param) in params.enumerated() {
            if index == 0 {
                urlStr += "?"
            }
            urlStr += "\(param.key)=\(param.value)&"
        }
        if params.count > 0
        {
            urlStr.removeLast()
        }
        return urlStr.getURL!
    }
    
    
//    func getProductUrl(tail: String) -> URL? {
//        return (baseUrl + "pub/media/catalog/product/" + tail).getURL
//    }
//
//    func getCategoryUrl(tail: String) -> URL?{
//        return (baseUrl + "pub/media/catalog/category/" + tail).getURL
//
//    }

    
}
