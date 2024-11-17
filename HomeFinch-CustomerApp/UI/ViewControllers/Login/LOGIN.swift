//
//  LOGIN.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 23/11/20.
//

import UIKit

class LOGIN: UIViewController ,UITextFieldDelegate, ServerRequestDelegate
{
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var needHelp: UIButton!

    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblSignInwithMobile: UILabel!
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var imgFlag: UIImageView!

    var arrCountry: [Country]!
    var StrCountryValue: String = "AE"

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setLabel()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        txtPhone.text = ""
        txtPhone.keyboardType = .phonePad
        txtPhone.delegate = self
        
        self.arrCountry = UserSettings.shared.arrCountry
        
        let arrfilter = self.arrCountry.filter{$0.countryCode == "AE"}
        if arrfilter.count > 0
        {
            let dict = arrfilter[0]
            self.lblCountry.text = dict.countryName
            self.StrCountryValue = dict.countryCode
            
//            self.lblCountry.text = "India"
//            self.StrCountryValue = "IN"
            self.lblCode.text = "+91 "
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        needHelp.titleLabel?.font =  UIFont.roboto(size: 13, weight: .Bold)
    }
    
    //MARK: -Dynamic Labels
    func setLabel()
    {
        lblSignInwithMobile.text = "Sign In with Mobile"
        lblMessage.text = "Enter your mobile number to Sign in or Sign up with us."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -All button Actions
    
    @IBAction func btnneedHelpClick(_ sender: UIButton) {
        self.view.endEditing(true)
        let cms = CMS.create(title: "Help")
        self.navigationController?.pushViewController(cms, animated: true)
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if lblCode.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select country", duration: .lengthShort).show()
            return
        }
        else if txtPhone.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter mobile number", duration: .lengthShort).show()
            return
        }
        
        if let phoneNumber = txtPhone.text,
           let countryCode = lblCode.text {
            let strPhn = countryCode + phoneNumber
            
            
            ServerRequest.shared.sendOtpToMobileNumber(phoneNumber: strPhn, delegate: self) { (response) in
                DispatchQueue.main.async {
                    
                    if response["status"] as? Int == 400
                    {
                        AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Please check your number", aOKBtnTitle: "OK") { (index, title) in
                            
                        }
                    }
                    else
                    {
                        let otp = self.storyboard?.instantiateViewController(withIdentifier: "OTP") as! OTP
                        otp.strCode = self.lblCode.text
                        otp.strPhone = self.txtPhone.text
                        otp.strCountryValue = self.StrCountryValue
                        self.navigationController?.pushViewController(otp, animated: true)
                    }
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }
            
        }
    }
    
    @IBAction func btnCountryClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let alertvc = IMSH_CUSTOM_SELECTION.createwithCountry(title: "Select Country", data: arrCountry, type: "country" , delegate: self)
        alertvc.present(from: self)

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
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    // MARK:  -UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        
        var strMaxLength = ""
        strMaxLength = "11"
        let newStr = textField.text as NSString?
        let currentString: String = newStr!.replacingCharacters(in: range, with: string)
        let j = Int(strMaxLength) ?? 0
        let length: Int = currentString.count
        
        if length >= j
        {
            return false
        }
        if !validatePhone(string)
        {
            if string != ""
            {
                return false
            }
            
        }
        return true
    }
}

extension LOGIN: ImShCustomSelectionDelegate {
    func itemSelected(at index: Int, dict: [String : Any], title: CustomerTitle, dictType: CustomerType, type: String) {
        
    }
    
    func CountrySelected(at index: Int, dict: Country, type: String) {
        self.lblCountry.text = dict.countryName
        self.StrCountryValue = dict.countryCode
    }
   
}

