//
//  SPLASH.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 03/11/20.
//

import UIKit
import RadarSDK

class SPLASH: UIViewController,ServerRequestDelegate {

    @IBOutlet var imgLogo: UIImageView!
    
    var arrCountry: [[String:Any]]!
    
    var currentDictionary: [String: Any]? // the current dictionary
    var currentValue: String?                // the current value for one of the keys in the dictionary

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if UserDefaults.standard.bool(forKey: "arabic")
        {
            imgLogo.image = UIImage(named: "splash_logo_ar")
        }
        else
        {
            imgLogo.image = UIImage(named: "splash_logo")
        }
        
        DispatchQueue.main.async {
            
            ServerRequest.shared.GetInitialData()
            
            if UserSettings.shared.isLoggedIn()
            {
                ServerRequest.shared.GetPropertyList(delegate: nil) { (response) in
                    

                    UserSettings.shared.arrPropertyList = response.data
                    
                } failure: { (errorMsg) in
                    
                }
            }
            
            ServerRequest.shared.GetCountryList(delegate: nil) { (countryResp) in
                
                // radar sdk Configuaration
                Radar.initialize(publishableKey: radar_PublishKey)

                
                UserSettings.shared.arrCountry = countryResp.data
                self.redirectionManage()

            } failure: { (errorMsg) in
                
            }
            
        }
        
       
    
    }
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func redirectionManage()
    {
        if UserSettings.shared.isLoggedIn()
        {
            ServerRequest.shared.GetCustomerInfo(delegate: nil) { (result) in
                                
                if result.id != nil
                {
                    var countryname = ""
                    let arrfilter = UserSettings.shared.arrCountry.filter{$0.countryCode == result.country}
                    if arrfilter.count > 0
                    {
                        let dict = arrfilter[0]
                        countryname = dict.countryName
                    }
                    
                    var userTitle = ""
                    
                    for item in UserSettings.shared.arrCustomerTitle
                    {
                        if item.id == result.title
                        {
                            userTitle = item.name
                            break
                        }
                    }
                    
                    UserSettings.shared.setUserCredential(strTitle: userTitle ,strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: result.mobile,strCountryValue: result.country ,strCountryName: countryname, image: result.avatar)
                    
                }
                
                if AppDelegate.shared.isPush == false
                {
                    let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
                    let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                    AppDelegate.shared.window?.rootViewController = navigationController
                    AppDelegate.shared.window?.makeKeyAndVisible()
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }
            
        }
        else
        {
            let selectionVc = self.storyboard?.instantiateViewController(withIdentifier: "SELECTION") as! SELECTION
            self.navigationController?.pushViewController(selectionVc, animated: false)

        }
    }
    
}

