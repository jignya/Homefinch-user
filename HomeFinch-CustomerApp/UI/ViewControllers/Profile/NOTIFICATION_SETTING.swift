//
//  NOTIFICATION_SETTING.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit

class NOTIFICATION_SETTING: UIViewController {
    
    static func create() -> NOTIFICATION_SETTING {
        return NOTIFICATION_SETTING.instantiate(fromImShStoryboard: .Profile)
    }
    
    @IBOutlet weak var lblpush: UILabel!
    @IBOutlet weak var lblpushDesc: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblEmailDesc: UILabel!
    
    @IBOutlet weak var swPush: UISwitch!
    @IBOutlet weak var swEmail: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Notification Setting"
        }
        
        self.swPush.isOn = false
        self.swEmail.isOn = false

        setLabel()
        
        ServerRequest.shared.getNotificationSetting(delegate: nil) { (response) in
            
            if response.notification == 1
            {
                self.swPush.isOn = true
                self.swEmail.isOn = true

            }
        } failure: { (errorMsg) in
            
        }

        
    }
    
    func setLabel()
    {
        lblpush.text = "PUSH NOTIFICATION"
        lblpushDesc.text = "Allow push notification"

    }
    
    //MARK: switch value change
    @IBAction func swPushChnaged(_ sender: Any) {
        let sw = sender as! UISwitch
        if !sw.isOn
        {
            ServerRequest.shared.updateNotificationSetting(status: 0, delegate: self) {
                
            } failure: { (errorMsg) in
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                }
            }
        }
        else
        {
            ServerRequest.shared.updateNotificationSetting(status: 1, delegate: self) {
                
            } failure: { (errorMsg) in
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                }
            }
            
        }
    }
    
 
    @IBAction func swEmailChanged(_ sender: Any) {
        let sw = sender as! UISwitch
        if !sw.isOn
        {
//            self.UpdateUserSetting(pushSetting: swPush.isOn ? "1" : "0", emailSetting: "0", ispush: false, isOn: false)
        }
        else
        {
//            self.UpdateUserSetting(pushSetting: swPush.isOn ? "1" : "0", emailSetting: "1", ispush: false, isOn: true)
        }
    }
    
}
extension NOTIFICATION_SETTING : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
