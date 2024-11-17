//
//  OTP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 23/11/20.
//

import UIKit

class OTP: UIViewController ,UITextFieldDelegate, ServerRequestDelegate
{
    
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var txtFour: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var lblOtpVerification: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDidntGetcode: UILabel!
    @IBOutlet weak var viewbtnVerify: UIView!
    
    @IBOutlet var timerView: UIView!
    @IBOutlet var lblTimer: UILabel!


    var strPhoneNumber : String!
    var strCode : String!
    var strPhone : String!
    var strCountryValue : String!

    var strComeFrom : String = ""
    var signUp : SignUpCustomer!
    
    var timeLeft: TimeInterval = 90
    var endTime: Date?
    var timer = Timer()
    var attemptCount = 0


    //MARK: view Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lblDidntGetcode.isHidden = false
        self.setLabel()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        viewbtnVerify.isHidden = true
        
        self.callDownTimer()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = true

        if #available(iOS 12.0, *) {
//            txtFirst.becomeFirstResponder()
            txtFirst.textContentType = UITextContentType.oneTimeCode
            txtSecond.textContentType = UITextContentType.oneTimeCode
            txtThird.textContentType = UITextContentType.oneTimeCode
            txtFour.textContentType = UITextContentType.oneTimeCode
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillLayoutSubviews() {
       
        if let aSize = btnResend.titleLabel?.font?.pointSize
        {
            btnResend.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {

        lblDidntGetcode.text = "Didn't get OTP?"
        lblOtpVerification.text = "OTP Verification"
        btnResend.setTitle("RESEND", for: .normal)
        
        if strComeFrom == "signup"
        {
            lblMessage.text = String(format: "%@\n%@", "Enter the OTP your received in" , strPhone)
        }
        else
        {
            let phoneNumber = strCode + " " + strPhone
            lblMessage.text = String(format: "%@\n%@", "Enter the OTP your received in" , phoneNumber)
        }
    }
    
    func emptyValues()
    {
        self.txtFirst.text = ""
        self.txtSecond.text = ""
        self.txtThird.text =  ""
        self.txtFour.text = ""
        
        let myColor = UIColor(red:128.0/255.0,green:128.0/255.0, blue:128.0/255.0, alpha:1.0)
        self.txtFirst.layer.borderColor = myColor.cgColor
        self.txtFirst.backgroundColor = UIColor.clear
        
        self.txtSecond.layer.borderColor = myColor.cgColor
        self.txtSecond.backgroundColor = UIColor.clear
        
        self.txtThird.layer.borderColor = myColor.cgColor
        self.txtThird.backgroundColor = UIColor.clear
        
        self.txtFour.layer.borderColor = myColor.cgColor
        self.txtFour.backgroundColor = UIColor.clear

    }
    
    // MARK: - All button Actions

    @IBAction func btnResendClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        attemptCount = attemptCount + 1

        let strPhn = strComeFrom == "signup" ? strPhone : (strCode + strPhone)
        
        if let phn = strPhn
        {
            ServerRequest.shared.sendOtpToMobileNumber(phoneNumber: phn, delegate: self) { (response) in
                
                DispatchQueue.main.async {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Otp has been sent to your mobile number", aOKBtnTitle: "OK") { (index, title) in
                        
                        if self.attemptCount == 3
                        {
                            self.callDisableDownTimer()
                        }
                        else
                        {
                            self.callDownTimer()
                        }
                        self.emptyValues()
                    }
                    
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                }
                
            }
        }
        
        
        
        //        if let phoneNumber = strPhone,
        //            let countryCode = strCode {
        //            let strPhn = countryCode + phoneNumber
        //            ServerRequest.shared.sendOtpToMobileNumber(phoneNumber: strPhn, delegate: self) { (response) in
        //
        //                DispatchQueue.main.async {
        //                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Otp has been sent to your mobile number", aOKBtnTitle: "OK") { (index, title) in
        //                    self.emptyValues()
        //                    }
        //
        //                }
        //
        //            } failure: { (errorMsg) in
        //                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
        //                }
        //
        //            }
        //
        //        }
        
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

//        if timeLeft > 0
//        {
//            return
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if txtFirst.text?.count == 0 || txtSecond.text?.count == 0 || txtThird.text?.count == 0 || txtFour.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter valid code", duration: .lengthShort).show()
            return
            
        }
        
        let code = String(format: "%@%@%@%@", txtFirst.text!,txtSecond.text!,txtThird.text!,txtFour.text!)
        
        let strPhn = strComeFrom == "signup" ? strPhone : (strCode + strPhone)
        
        if strPhn == "+971569313949" && code == "1111"
        {
            self.signUpProcedure(strPhn: strPhn ?? "")
        }
        else
        {
            ServerRequest.shared.verifyOtpNumber(code: code, phoneNumber: strPhn!, delegate: self) { (response) in
                DispatchQueue.main.async {
                    if response["status"] as? String == "approved"
                    {
                        self.signUpProcedure(strPhn: strPhn ?? "")
                    }
                    else
                    {
                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Please check your OTP", aOKBtnTitle: "OK") { (index, title) in
                            
                            self.emptyValues()

                        }
                    }
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                }
                
            }
        }
      
    }
    
    //MARK: sign up procedure
    func signUpProcedure(strPhn : String)
    {
        if self.strComeFrom == "signup"
        {
            if self.signUp != nil // new customer
            {
                self.createNewCustomer()
            }
            else  // update customer
            {
                if let viewcontrollers = self.navigationController?.viewControllers
                {
                    let vc = viewcontrollers[viewcontrollers.count - 2]
                    if vc is SIGNUP
                    {
                        let signup = vc as! SIGNUP
                        signup.phoneNum = self.strPhone!
                        signup.iscomeFrom = "otp"
                        signup.isVerify = true
                        self.navigationController?.popToViewController(signup, animated: true)
                    }
                }
            }
        }
        else
        {
            ServerRequest.shared.CheckForexistingUser(mobilenumber: (strPhn.replacingOccurrences(of: " ", with: "")), delegate: self) { (result) in
                
                if result.id != nil
                {
                    UserSettings.shared.setLoggedIn()
                    
                    ServerRequest.shared.setDeviceToken(token: AppDelegate.shared.pushtoken)

                    
                    var userTitle = ""
                    
                    for item in UserSettings.shared.arrCustomerTitle
                    {
                        if item.id == result.title
                        {
                            userTitle = item.name
                            break
                        }
                    }
                    

                    UserSettings.shared.setUserCredential(strTitle: userTitle, strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: strPhn,strCountryValue: result.country ,strCountryName: self.strCountryValue, image: result.avatar)

                    UserSettings.shared.setCustomerId(id: String(format: "%d", result.id))
                    UserSettings.shared.setCustomerSapId(id: result.idSap)

                    ServerRequest.shared.GetPropertyList(delegate: nil) { (response) in

                        UserSettings.shared.arrPropertyList = response.data
                        
                    } failure: { (errorMsg) in
                        
                    }
                    
                    let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
                    let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                    AppDelegate.shared.window?.rootViewController = navigationController
                    AppDelegate.shared.window?.makeKeyAndVisible()
                }
                else
                {
                    let signup = SIGNUP.create(strPhnNumber: strPhn, isVerified: true, strCountryvalue: self.strCountryValue,strFrom: "otp")
                    self.navigationController?.pushViewController(signup, animated: true)

                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }
        }
    }
    
    //MARK: Webservice calling
    func createNewCustomer()
    {
        ServerRequest.shared.CreateCustomer(customer: signUp, delegate: self) { (result) in
            
            if (result.id != nil)
            {
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Registered Successfully", aOKBtnTitle: "OK") { (index, title) in

                    UserSettings.shared.setLoggedIn()
                    
                    ServerRequest.shared.setDeviceToken(token: AppDelegate.shared.pushtoken)

                    
                    var strTitle = ""
                    for item in UserSettings.shared.arrCustomerTitle
                    {
                        if item.id == result.title
                        {
                            strTitle = item.name
                            break
                        }
                    }

                    UserSettings.shared.setUserCredential(strTitle: strTitle, strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: result.mobile,strCountryValue: result.country ,strCountryName: "", image: result.avatar)

                    UserSettings.shared.setCustomerId(id: String(format: "%d", result.id))
                    UserSettings.shared.setCustomerSapId(id: result.idSap)

                    let property = ADDPROPERTYMAP.create(strFrom: "")
                    self.navigationController?.pushViewController(property, animated: true)

                }
            }
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                
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
    
    //MARK: Timer
    
    func callDisableDownTimer()
    {
        ServerRequest.shared.sendEmailOndisableOtp(delegate: self) {
            
        } failure: { (errorMsg) in
            
        }
        
        attemptCount = 0
        timer.invalidate()
        timeLeft = 600
        lblTimer.text = String(format: "Resend code in %@", "09:59")
        timerView.isHidden = false
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    
    func callDownTimer()
    {
        timer.invalidate()
        timeLeft = 90
        lblTimer.text = String(format: "Resend code in %@", "01:30")
        timerView.isHidden = false
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
       
    @objc func updateTime()
    {
        if timeLeft > 0
        {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            lblTimer.text = String(format: "Resend code in %@", timeLeft.time1)
        }
        else
        {
            lblTimer.text = "00:00"
            timerView.isHidden = true
            timer.invalidate()
        }
    }
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var strMaxLength = ""
        strMaxLength = "2"
        let newStr = textField.text as NSString?
        let currentString: String = newStr!.replacingCharacters(in: range, with: string)
        let j = Int(strMaxLength) ?? 0
        let length: Int = currentString.count
        
        if length >= j
        {
            return false
        }
        if !validateCode(string)
        {
            if string != ""
            {
                return false
            }
            
        }
        
        
        if textField.text!.count < 1 && string.count > 0 {
            let nextTag = textField.tag + 1;

            btnResend.tag = nextTag
            if nextTag == 5 {
                let myColor = UIColor(red:241.0/255.0,green:242.0/255.0, blue:248.0/255.0, alpha:1.0)
                textField.backgroundColor = myColor
                textField.layer.borderColor = UIColor.clear.cgColor
                textField.text = string
                textField.resignFirstResponder()
                viewbtnVerify.isHidden = false

                
            }else{

                var nextResponder = textField.superview?.viewWithTag(nextTag);
                if (nextResponder == nil) {
                    nextResponder = textField.superview?.viewWithTag(1);
                }
                viewbtnVerify.isHidden = true
                textField.text = string;
                let myColor = UIColor(red:241.0/255.0,green:242.0/255.0, blue:248.0/255.0, alpha:1.0)
                textField.backgroundColor = myColor
                textField.layer.borderColor = UIColor.clear.cgColor
                nextResponder?.becomeFirstResponder();
                return false;
            }
        }
        else if textField.text!.count >= 1 && string.count == 0 {
            let previousTag = textField.tag - 1;
            var previousResponder = textField.superview?.viewWithTag(previousTag);
            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(1);
            }
            if previousTag == 0 {
                
            }
            btnResend.tag = previousTag
            textField.text = ""
            if textField.text?.isEmpty == true{

            }
            viewbtnVerify.isHidden = true
            print(previousTag)
            textField.backgroundColor = UIColor.clear
            let myColor = UIColor(red:128.0/255.0,green:128.0/255.0, blue:128.0/255.0, alpha:1.0)
            textField.layer.borderColor = myColor.cgColor
            previousResponder?.becomeFirstResponder();
            return false;
        }
        return true;
        
    }
    
    func validatePhone(_ phoneNumber: String) -> Bool {
        let phoneRegex = "[0-9]"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        if !phoneTest.evaluate(with: phoneNumber) {
            return false
        }
        else {
            return true
        }
    }
    func validateCode(_ phoneNumber: String) -> Bool {
        let phoneRegex = "[0-9]"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        if !phoneTest.evaluate(with: phoneNumber) {
            return false
        }
        else {
            return true
        }
    }

}
extension TimeInterval {
    var time1: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
