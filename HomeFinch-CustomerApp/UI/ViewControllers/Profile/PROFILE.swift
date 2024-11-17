//
//  PROFILE.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/11/20.
//

import UIKit

class PROFILE: UIViewController , ServerRequestDelegate
{

//    MARK: Outlet
        
    @IBOutlet weak var scrollMain: UIScrollView!
    @IBOutlet weak var viewMainContain: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblInitials: UILabel!

    
    @IBOutlet weak var viewPettyCashWallet: UIView!
    @IBOutlet weak var lblPettyCashWallet: UILabel!
    @IBOutlet weak var lblLastTrasaction: UILabel!
    @IBOutlet weak var lblTrasactionAmount: UILabel!
    @IBOutlet weak var lblAEDData: UILabel!
   
    @IBOutlet weak var viewBottomContain: UIView!
    @IBOutlet weak var viewSetting: UIView!
    
    @IBOutlet weak var tblSetting: UITableView!
    @IBOutlet weak var contblSettingHeight: NSLayoutConstraint!

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblcompleteProfilePercentage: UILabel!

    @IBOutlet weak var btnCompleteProfile: UIButton!
    
    var arrSetting = [[String:Any]]()

    
    //MARK: View-life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CommonFunction.shared.addTabBar(self, tab: 3)
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)


        setLabel()
        self.ImShSetLayout()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.roboto(size: 18, weight: .Bold)]

    }
    
    
    func setData()
    {
        let dict = UserSettings.shared.getUserCredential()
        let strName = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "").replacingOccurrences(of: "  ", with: " ")
        self.lblName.text = String(format: "%@", strName)
        self.lblEmail.text = dict["email"] as? String
        
        let initials = strName.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        self.lblInitials.text = initials.uppercased()
        self.imgUser.isHidden = true
        
        if dict["avatar"] as? String != ""
        {
            self.imgUser.setImage(url: (dict["avatar"] as? String)?.getURL, placeholder: nil)
            self.imgUser.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //----------------------------------------------- data set dynamically
        self.setData()
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()

        self.GetNotifcationList()

    }
    
    
    override func viewWillLayoutSubviews()
    {
        self.viewPettyCashWallet.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.viewSetting.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.viewBottomContain.roundCorners(corners: [.topLeft, .topRight], radius: 20)

    }
    
    override func ImShSetLayout()
    {
        arrSetting = [["image":"Prpoerty","title":"My Properties"],["image":"Payment_Method","title":"Payment Methods"],["image":"Settings","title":"Settings"],["image":"Help","title":"Help"],["image":"Logout","title":"Logout"]]
        
        self.navigationItem.setNotificationBtn(target: self, action: #selector(btnNotificationTapped(_:)), tag: 0, animated: true)

        self.navigationItem.leftBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        tblSetting.register(delegate: self, dataSource: self, cellNibWithReuseId: SettingCell.className)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    
    func setLabel()
    {
        lblName.text = ""
        lblEmail.text = ""
        lblPettyCashWallet.text = "My Wallet"
//        lblLastTrasaction.text = "Last transaction:"
//        lblTrasactionAmount.text = UserSettings.shared.getwalletbalance()
        lblLastTrasaction.text = ""
        lblTrasactionAmount.text = ""
        lblAEDData.text = UserSettings.shared.getwalletbalance()
    }

    //MARK: Button Methods
    
    @IBAction func btnProfileClick(_ sender: Any)
    {
        let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "edit")
        self.navigationController?.pushViewController(signup, animated: true)
    }

    @objc func btnNotificationTapped(_ sender : Any)
    {
        if let notification = NOTIFICATION_LIST.create() {
            self.present(notification, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnMywalletClick(_ sender: Any)
    {
        let wallet = MYWALLET.create()
        self.navigationController?.pushViewController(wallet, animated: true)
    }
    
    @IBAction func btnCompleteProfileClick(_ sender: Any)
    {
        let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "edit")
        self.navigationController?.pushViewController(signup, animated: true)
    }
    
    //MARK: - webservice
    
    func GetNotifcationList()
    {
        ServerRequest.shared.GetNotificationList(delegate: self) { (response) in

            let arrNot = response.list ?? []
            let arrFilter = arrNot.filter{$0.isRead == 1}
            self.navigationItem.setBadgeCount(value: arrFilter.count)
            
        } failure: { (errorMsg) in
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
}
extension PROFILE: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.className, for: indexPath) as! SettingCell
        

        let dict = arrSetting[indexPath.row]
        cell.lblName.text = dict["title"] as? String
        cell.imgIcon.image = UIImage(named: dict["image"] as! String)
        
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
            let propertyList = PROPERTY_LIST.create(strComeFrom: "profile")
            self.navigationController?.pushViewController(propertyList, animated: true)
        }
        else if indexPath.row == 1
        {
            let payment =  PAYMENT_METHODS.createNormalFlow()
            self.navigationController?.pushViewController(payment, animated: true)

        }
        else if indexPath.row == 2
        {
            let setting = SETTING.create()
            self.navigationController?.pushViewController(setting, animated: true)

        }
        else if indexPath.row == 3
        {
            let help = HELP.create()
            self.navigationController?.pushViewController(help, animated: true)

        }
        else if indexPath.row == 4
        {
            AJAlertController.initialization1().showAlert(isBottomShow: true, aStrTitle: "Log Out", aStrMessage: "Are you sure want to logout?", aCancelBtnTitle: "NO", aOtherBtnTitle: "YES", completion: { (index, title) in
                
                if index == 1
                {
                    UserSettings.shared.setLoggedOut()
                    
                    ServerRequest.shared.deleteDeviceToken(token: AppDelegate.shared.pushtoken)
                    
                    UserSettings.shared.arrPropertyList.removeAll()
                    
                    let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
                    let navigationController = UINavigationController()
                    let login = storyboard.instantiateViewController(withIdentifier: "SELECTION") as! SELECTION
                    navigationController.setViewControllers([login], animated: true)
                    navigationController.navigationBar.isHidden = true
                    AppDelegate.shared.window?.rootViewController = navigationController
                    AppDelegate.shared.window?.makeKeyAndVisible()

                }
                
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
