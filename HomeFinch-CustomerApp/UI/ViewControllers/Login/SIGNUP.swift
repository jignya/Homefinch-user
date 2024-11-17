//
//  SIGNUP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 26/11/20.
//

import UIKit
import SkyFloatingLabelTextField
import Amplitude_iOS

class SIGNUP: UIViewController ,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, ServerRequestDelegate,cameracaptureDelegate
{
    static func create(strPhnNumber : String , isVerified :Bool , strCountryvalue : String ,strFrom:String = "") -> SIGNUP {
        let signup = SIGNUP.instantiate(fromImShStoryboard: .Login)
        signup.iscomeFrom = strFrom
        signup.phoneNum = strPhnNumber
        signup.isVerify = isVerified
        signup.strCountryValue = strCountryvalue
        return signup
    }
    
    @IBOutlet weak var viewLogo: UIView!
    @IBOutlet weak var conViewLogoHeight: NSLayoutConstraint!

    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var viewDesc : UIView!

    @IBOutlet weak var btnTitle: UIButton!
    
    @IBOutlet weak var btnNationality: UIButton!
    @IBOutlet weak var btnsaveChanges: UIButton!
    @IBOutlet weak var btnPrivacy: UIButton!


    @IBOutlet weak var txtTitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtNationality: SkyFloatingLabelTextField!
    
    @IBOutlet weak var viewTerms: UIView!
    @IBOutlet weak var lblAgree: UILabel!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var viewBtnNext: UIView!
    @IBOutlet weak var viewDataContains: UIView!
    
    @IBOutlet weak var btnTermsSelection: UIButton!

    
    @IBOutlet weak var viewVerified: UIView!
    @IBOutlet weak var lblVerify: UILabel!
    
    @IBOutlet weak var viewprofile : UIView!
    @IBOutlet weak var viewBtnSave : UIView!

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!

    
    var iscomeFrom : String!
    
    var strFisrtName : String!
    var strLastName : String!
    var strEmail : String!
    var isVerify : Bool = false
    var phoneNum : String!
    var strCountryValue : String = ""
    var strInitialValue : String = ""

    var arrInitials = [CustomerTitle]()
    var currentDictionary: [String: Any]?
    var currentValue: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)


        self.setLabel()
        self.updateLayout()
        
        txtMobileNumber.delegate = self
        
        conViewLogoHeight.constant = 100
        viewDataContains.layer.borderWidth = 0.5
        viewBtnNext.isHidden = false
        viewTerms.isHidden = false
        viewDesc.isHidden = false
        viewBtnSave.isHidden = true
        viewprofile.isHidden = true
        
        txtFirstName.autocapitalizationType = .sentences
        txtLastName.autocapitalizationType = .sentences
        
        txtFirstName.keyboardType = .asciiCapable
        txtLastName.keyboardType = .asciiCapable
        txtEmail.keyboardType = .emailAddress

        self.txtMobileNumber.text = "+971"  // static for now as set for Dubai only
        
        arrInitials = UserSettings.shared.arrCustomerTitle
        
        if iscomeFrom == "edit" || iscomeFrom == "list"
        {
            txtMobileNumber.addTarget(self, action: #selector(valueComparing(_:)), for: .editingChanged)
            isVerify = true
            viewVerified.isHidden = false

            conViewLogoHeight.constant = 0
            viewDataContains.layer.borderWidth = 0.0
            viewBtnNext.isHidden = true
            viewTerms.isHidden = true
            viewDesc.isHidden = true
            viewBtnSave.isHidden = false
            viewprofile.isHidden = false
            txtMobileNumber.isUserInteractionEnabled = true
            
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationItem.hidesBackButton = false
            self.navigationController?.navigationItem.backButtonTitle = ""
        
            DispatchQueue.main.async{
                self.navigationController?.navigationBar.topItem?.title = "My Profile"
            }
            
            ServerRequest.shared.GetCustomerInfo(delegate: self) { (result) in
                
                if result.id != nil
                {
                    self.phoneNum = result.mobile
                    self.txtFirstName.text = result.firstName
                    self.txtLastName.text = result.lastName
                    self.txtEmail.text = result.email
                    self.txtMobileNumber.text = result.mobile
                    
                    let arrfilter = UserSettings.shared.arrCountry.filter{$0.countryCode == result.country}
                    if arrfilter.count > 0
                    {
                        let dict = arrfilter[0]
                        self.txtNationality.text = dict.countryName
                        self.strCountryValue = dict.countryCode
                    }
                    
                    if result.avatar != ""
                    {
                        self.imgProfile.setImage(url: (result.avatar)?.getURL, placeholder: UIImage.image(type: .Placeholder))
                    }
                    
                    for item in self.arrInitials
                    {
                        if item.id == result.title
                        {
                            self.txtTitle.text = item.name
                            self.strInitialValue = result.title
                            break
                        }
                    }
                    
                    UserSettings.shared.setUserCredential(strTitle: self.txtTitle.text ?? "", strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: self.txtMobileNumber.text!,strCountryValue: result.country ,strCountryName: self.txtNationality.text!, image: result.avatar)
                    
                }
                
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
            }

         
        }
        
    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        txtTitle.placeholder = "Title"
        txtFirstName.placeholder = "First Name"
        txtLastName.placeholder = "Last Name"
        txtEmail.placeholder = "Email"
        txtMobileNumber.placeholder = "Mobile Number"
        txtNationality.placeholder = "Nationality"
        
        if strFisrtName != nil
        {
            txtFirstName.text = strFisrtName
            txtEmail.text = strEmail
            txtLastName.text = strLastName

            return
        }
    }
    
    func updateLayout()
    {
        viewVerified.isHidden = true
        txtEmail.keyboardType = .emailAddress
        txtMobileNumber.keyboardType = .phonePad
                
        txtTitle.titleFont = UIFont.roboto(size: 12)!
        txtFirstName.titleFont = UIFont.roboto(size: 12)!
        txtLastName.titleFont = UIFont.roboto(size: 12)!
        txtEmail.titleFont = UIFont.roboto(size: 12)!
        txtMobileNumber.titleFont = UIFont.roboto(size: 12)!
        txtNationality.titleFont = UIFont.roboto(size: 12)!
        
        txtTitle.font = UIFont.roboto(size: 16, weight: .Medium)
        txtFirstName.font = UIFont.roboto(size: 16, weight: .Medium)
        txtLastName.font = UIFont.roboto(size: 16, weight: .Medium)
        txtEmail.font = UIFont.roboto(size: 16, weight: .Medium)
        txtMobileNumber.font = UIFont.roboto(size: 16, weight: .Medium)
        txtNationality.font = UIFont.roboto(size: 16, weight: .Medium)

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = true
        
        if iscomeFrom == "otp"
        {
            txtMobileNumber.addTarget(self, action: #selector(valueComparing(_:)), for: .editingChanged)
            isVerify = true
            viewVerified.isHidden = false
            txtMobileNumber.text = phoneNum
        }
        else if iscomeFrom == "edit" || iscomeFrom == "list"
        {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.hideBottomHairline()

            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationItem.hidesBackButton = false
            self.navigationController?.navigationItem.backButtonTitle = ""
        
            DispatchQueue.main.async{
                self.navigationController?.navigationBar.topItem?.title = "My Profile"
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
       
        if let aSize = btnsaveChanges.titleLabel?.font?.pointSize
        {
            btnsaveChanges.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
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

    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtMobileNumber
        {
            textField.typingAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
            let protectedRange = NSMakeRange(0, 4)
            let intersection = NSIntersectionRange(protectedRange, range)
            if intersection.length > 0 {

                return false
            }
            if range.location == 3 {
                return true
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
        else if textField == txtFirstName || textField == txtLastName
        {
            var strMaxLength = ""
            strMaxLength = "21"
            let newStr = textField.text as NSString?
            let currentString: String = newStr!.replacingCharacters(in: range, with: string)
            let j = Int(strMaxLength) ?? 0
            let length: Int = currentString.count
            
            if length >= j
            {
                return false
            }
            
            if !string.canBeConverted(to: String.Encoding.ascii){
                   return false
               }

        }
        else if textField == txtEmail
        {
            if !string.canBeConverted(to: String.Encoding.ascii){
                   return false
               }
        }
        
        return true
        
    }
    
    @objc func valueComparing(_ sender : Any)
    {
//        print(txtMobileNumber.text)
//        print(phoneNum)

        if txtMobileNumber.text == phoneNum
        {
            isVerify = true
            viewVerified.isHidden = false
        }
        else
        {
            isVerify = false
            viewVerified.isHidden = true
        }
    }



    // MARK: - All button Actions
    @IBAction func btnTitleClick(_ sender: Any) {
        
        self.view.endEditing(true)

        let alertvc = IMSH_CUSTOM_SELECTION.createwithInitials(title: "", data: self.arrInitials, type: "initial" , delegate: self)
        alertvc.present(from: self)

    }
    
    @IBAction func btnTermsClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let cms = CMS.create(title: "Terms & condition")
        self.navigationController?.pushViewController(cms, animated: true)
    }
    
    @IBAction func btnPrivacyClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let cms = CMS.create(title: "Privacy Policy")
        self.navigationController?.pushViewController(cms, animated: true)
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        let views = self.navigationController?.viewControllers ?? []
         
        for vc in views
        {
            if vc is LOGIN
            {
                let login = vc as! LOGIN
                self.navigationController?.popToViewController(login, animated: true)
                break
            }
            else if vc is SELECTION
            {
                let selection = vc as! SELECTION
                self.navigationController?.popToViewController(selection, animated: true)
                break
            }
        }
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtTitle.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select initials", duration: .lengthShort).show()
            return

        }
        else if txtFirstName.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter first name", duration: .lengthShort).show()
            return

        }
        else if txtLastName.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter last name", duration: .lengthShort).show()
            return

        }
        else if txtEmail.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter email", duration: .lengthShort).show()
            return

        }
        else if txtEmail.text?.isValidEmail == false
        {
            SnackBar.make(in: self.view, message: "Please enter valid email", duration: .lengthShort).show()
            return

        }
        else if txtMobileNumber.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter mobile number", duration: .lengthShort).show()
            return
        }
//            else if txtMobileNumber.text?.count ?? 0 < 14
//            {
//                SnackBar.make(in: self.view, message: "Please enter valid mobile number", duration: .lengthShort).show()
//                return
//
//            }
        else if txtNationality.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select country", duration: .lengthShort).show()
            return

        }
        else if btnTermsSelection.isSelected == false && viewTerms.isHidden == false
        {
            SnackBar.make(in: self.view, message: "Please read and agree our terms and conditions.", duration: .lengthShort).show()
            return

        }
        else
        {
            if isVerify
            {
                if iscomeFrom == "edit" || iscomeFrom == "list"
                {
                    self.updateCustomerInfo()
                }
                else
                {
                    self.createNewCustomer()
                }
            }
            else
            {
//                let signUp = SignUpCustomer.init()
//                signUp.title = strInitialValue
//                signUp.firstName = self.txtFirstName.text
//                signUp.lastName = self.txtLastName.text
//                signUp.mobile = self.txtMobileNumber.text
//                signUp.country = strCountryValue
//                signUp.sourceFrom = 3
//                signUp.email = self.txtEmail.text
//                signUp.id = Int(UserSettings.shared.getCustomerId())

                
                if iscomeFrom == "edit" || iscomeFrom == "list"
                {
                    AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "", aStrMessage: "Are you want to change mobile number at this point ?", aCancelBtnTitle: "NO", aOtherBtnTitle: "YES", completion: { (index, title) in
                        
                        if index == 1
                        {
                            self.SetMobileVerification(userData: nil)
                        }
                    })
                    
                }
                else
                {
//                    let signUp = SignUpCustomer.init()
//                    signUp.title = strInitialValue
//                    signUp.firstName = self.txtFirstName.text
//                    signUp.lastName = self.txtLastName.text
//                    signUp.mobile = self.txtMobileNumber.text
//                    signUp.country = strCountryValue
//                    signUp.sourceFrom = 3
//                    signUp.email = self.txtEmail.text
                    
//                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Please verify your number before proceed", aOKBtnTitle: "OK") { (index, title) in
                        
                        self.SetMobileVerification(userData: nil)

//                    }
                    
                }
            }
            
           
        }
    }
    
    func SetMobileVerification(userData:SignUpCustomer? = nil)
    {
        ServerRequest.shared.sendOtpToMobileNumber(phoneNumber: self.txtMobileNumber.text!, delegate: self) { (response) in
            DispatchQueue.main.async {
                
                if response["status"] as? Int == 400
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Invalid Number", aStrMessage: "Please check your number", aOKBtnTitle: "OK") { (index, title) in
                        
                    }
                }
                else
                {
                    let otp = self.storyboard?.instantiateViewController(withIdentifier: "OTP") as! OTP
                    otp.strPhone = self.txtMobileNumber.text
                    otp.strCountryValue = self.strCountryValue
                    otp.strComeFrom = "signup"
                    otp.signUp = userData
                    self.navigationController?.pushViewController(otp, animated: true)
                }
               
                
            }
            
        } failure: { (errorMsg) in
            
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                
            }
        }
        
    }
    
    
    @IBAction func btnNationalityClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let alertvc = IMSH_CUSTOM_SELECTION.createwithCountry(title: "Select Country", data: UserSettings.shared.arrCountry, type: "country" , delegate: self)
        alertvc.present(from: self)


    }
    
    @IBAction func btnTermsSelectionClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected

    }
    
    @IBAction func btnProfileClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        let storyborad1 = UIStoryboard.init(name: "Home", bundle: nil)
        let selectionVc = storyborad1.instantiateViewController(withIdentifier: "CAMERAVIEW") as! CAMERAVIEW
        selectionVc.strCome = "profile"
        selectionVc.ImgSelectCount = 1
        selectionVc.delegate = self
        self.navigationController?.pushViewController(selectionVc, animated: false)

        
        return

        let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        action.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.camera()
        }))
        action.addAction(UIAlertAction(title:"Choose photo", style: .default, handler: {
            action in
            self.OpenPhotos()
        }))
        action.addAction(UIAlertAction(title:"Remove photo", style: .default, handler: {
            action in
            self.RemovePhotos()
        }))
        action.addAction(UIAlertAction(title:"Cancel",style: .cancel, handler: {
            action in
        }))
        self.present(action, animated: true, completion: nil)
        
    }
    
    //MARK: Customer New-Update Function
    func createNewCustomer()
    {
        let signUp = SignUpCustomer.init()
        signUp.title = strInitialValue
        signUp.firstName = self.txtFirstName.text
        signUp.lastName = self.txtLastName.text
        signUp.mobile = self.txtMobileNumber.text?.replacingOccurrences(of: " ", with: "")
        signUp.country = strCountryValue
        signUp.sourceFrom = 3
        signUp.email = self.txtEmail.text
//        signUp.createdBy = UserSettings.shared.getCustomerId()

        ServerRequest.shared.CreateCustomer(customer: signUp, delegate: self) { (result) in
            
            if (result.id != nil)
            {
                AJAlertController.initialization().showAlertWithOkButton(iscloseShow: false,isBottomShow: false, aStrTitle: "", aStrMessage: "Registered Successfully", aOKBtnTitle: "OK") { (index, title) in

                    UserSettings.shared.setLoggedIn()
                    
                    ServerRequest.shared.setDeviceToken(token: AppDelegate.shared.pushtoken)

                    UserSettings.shared.setUserCredential(strTitle: self.txtTitle.text ?? "", strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: result.mobile,strCountryValue: result.country ,strCountryName: self.txtNationality.text!, image: result.avatar)

                    UserSettings.shared.setCustomerId(id: String(format: "%d", result.id))
                    UserSettings.shared.setCustomerSapId(id: result.idSap)

                    
                    //------------------- log event ------------------
                    
                    ServerRequest.shared.GetCustomerInfo(delegate: nil) { (result) in
                        
                        if result.id != nil
                        {
                            let dictPara = ["App User ID": result.id,
                                            "Customer ID": result.id,
                                            "Customer Category":result.customerType,
                                            "Customer Property Count" : "0",
                                            "Contact ID": "",
                                            "Contact Type":""] as [String : Any]
                            
                            Amplitude.instance().logEvent("Customer - SignUp", withEventProperties: dictPara)
                        }
                    } failure: { (errorMsg) in }
                    
                    //------------------------------------------------

                    let property = ADDPROPERTYMAP.create(strFrom: "")
                    self.navigationController?.pushViewController(property, animated: true)

                }
            }
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                
            }
        }
        
    }
    
    func updateCustomerInfo()
    {
        let signUp = SignUpCustomer.init()
        signUp.title = strInitialValue
        signUp.firstName = self.txtFirstName.text
        signUp.lastName = self.txtLastName.text
        signUp.mobile = self.txtMobileNumber.text
        signUp.country = strCountryValue
        signUp.sourceFrom = 3
        signUp.email = self.txtEmail.text
        signUp.id = Int(UserSettings.shared.getCustomerId())
        signUp.updatedBy = UserSettings.shared.getCustomerId()

                        
        ServerRequest.shared.UpdateCustomerwithImage(imgProfile: self.imgProfile.image ?? nil, customer: signUp, delegate: self){ (result) in
            
            if (result.id != nil)
            {
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Customer Updated Successfully", aOKBtnTitle: "OK") { (index, title) in
                    
                    var strTitle = ""
                    for item in self.arrInitials
                    {
                        if item.id == result.title
                        {
                            strTitle = item.name
                            break
                        }
                    }
                    
                    UserSettings.shared.setUserCredential(strTitle: strTitle, strEmail: result.email, strFname: result.firstName, strLname: result.lastName, strMobile: result.mobile,strCountryValue: result.country ,strCountryName: self.txtNationality.text!, image: result.avatar)
                    
                    self.navigationController?.popViewController(animated: true)
                    
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
    
    //MARK:  For Camera , imagepicker
    func camera()
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let alertController = UIAlertController.init(title: nil, message:"Device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title:"Ok", style: .default, handler: {(alert: UIAlertAction!) in
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
//            picker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
//            picker.cameraCaptureMode = .video
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func OpenPhotos()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func RemovePhotos()
    {
        imgProfile.image = nil
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imgProfile.image = image
        imgProfile.contentMode = .scaleToFill
        
//        let imageName = String(format: "Picture_%.f.jpg", Date().timeIntervalSince1970)
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let photoURL  = NSURL(fileURLWithPath: documentDirectory)
//        let localPath = photoURL.appendingPathComponent(imageName)
//        do
//            {
//                try image?.jpegData(compressionQuality:0.5)?.write(to: localPath!)
//                let strTemp1 = String(format: "%@/%@", documentDirectory,imageName)
//
//            }
//        catch
//        {
//            print("error saving file")
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: camera capture delegate
    func didSelectProfileImage(imageProfile: UIImage) {
        imgProfile.contentMode = .scaleAspectFill
        imgProfile.clipsToBounds = true
        imgProfile.image = imageProfile
    }

    
    
}
extension SIGNUP: ImShCustomSelectionDelegate {
    
    func itemSelected(at index: Int, dict: [String : Any], title: CustomerTitle, dictType: CustomerType, type: String) {
        self.txtTitle.text = title.name
        self.strInitialValue = title.id
    }
    
    func CountrySelected(at index: Int, dict: Country, type: String) {
        self.txtNationality.text = dict.countryName
        self.strCountryValue = dict.countryCode
    }
    
}
