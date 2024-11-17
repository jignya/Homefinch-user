//
//  SETTING.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit

class SETTING: UIViewController {
    
    static func create() -> SETTING {
        return SETTING.instantiate(fromImShStoryboard: .Profile)
    }
    
    @IBOutlet weak var lblCountryLanguage: UILabel!
    @IBOutlet weak var lblOtherSettings: UILabel!
    @IBOutlet weak var ViewOtherSettings: UIView!
    @IBOutlet weak var tblSetting: UITableView!
    @IBOutlet weak var contblSettingHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!

    @IBOutlet weak var lblCountryValue: UILabel!
    @IBOutlet weak var lblLanguageValue: UILabel!

    @IBOutlet weak var lblVersion: UILabel!

    var arrSetting = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Settings"
        }


//        setLabel()
        self.ImShSetLayout()
        
        let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String //CFBundleVersion
        lblVersion.text = String(format: "HomeFinch : v%@", buildNumber)

    }
    
    override func ImShSetLayout()
    {
        arrSetting = [["title":"Notification Settings"],["title":"Rate the App"],["title":"About Us"],["title":"Privacy Policy"],["title":"Refund & Cancellation Policy"],["title":"Terms & Conditions"]] //,["title":"Contact Us"]]
        
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        tblSetting.register(delegate: self, dataSource: self, cellNibWithReuseId: "SettingCell1")

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    


}
extension SETTING: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell1", for: indexPath) as! SettingCell


        let dict = arrSetting[indexPath.row]
        cell.lblName.text = dict["title"] as? String
        
        self.contblSettingHeight.constant = CGFloat(arrSetting.count * 60)
        self.tblSetting.updateConstraintsIfNeeded()
        self.tblSetting.layoutIfNeeded()
      
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let not = NOTIFICATION_SETTING .create()
            self.navigationController?.pushViewController(not, animated: true)

        }
        else if indexPath.row == 1
        {
            let rate = RATEAPP.create()
            self.navigationController?.pushViewController(rate, animated: true)

        }
        else if indexPath.row == 2
        {
            let cms = CMS.create(title: "About Us")
            self.navigationController?.pushViewController(cms, animated: true)

        }
        else if indexPath.row == 3
        {
            let cms = CMS.create(title: "Privacy Policy")
            self.navigationController?.pushViewController(cms, animated: true)

        }
        else if indexPath.row == 4
        {
            let cms = CMS.create(title: "Refund & Cancellation Policy")
            self.navigationController?.pushViewController(cms, animated: true)
        }
        else if indexPath.row == 5
        {
            let cms = CMS.create(title: "Terms & conditions")
            self.navigationController?.pushViewController(cms, animated: true)

        }
        else if indexPath.row == 6
        {
            let contact = CONTACT_US.create()
            self.navigationController?.pushViewController(contact, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
