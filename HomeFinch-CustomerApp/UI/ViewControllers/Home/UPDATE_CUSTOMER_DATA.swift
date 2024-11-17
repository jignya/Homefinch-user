//
//  UPDATE_CUSTOMER_DATA.swift
//  HomeFinch-CustomerApp
//

import UIKit
import SkyFloatingLabelTextField

class UPDATE_CUSTOMER_DATA: UIViewController, UITextFieldDelegate {
    
    static func create(delegate : updateCustomerDelegate? = nil,jobreqData : JobIssueList? = nil) -> UPDATE_CUSTOMER_DATA {
        
        let update = UPDATE_CUSTOMER_DATA.instantiate(fromImShStoryboard: .Home)
        update.delegate = delegate
        update.jobreqData = jobreqData
        return update
    }

    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var txtTitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var txtType: SkyFloatingLabelTextField!

    @IBOutlet weak var txtCustomerFName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCustomerLName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCustomerMobile: SkyFloatingLabelTextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var contblListHeight: NSLayoutConstraint!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var viewFields: UIView!
    @IBOutlet weak var viewUpdate: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var viewbtnNew: UIView!
    
    @IBOutlet weak var stackdetail: UIStackView!
    @IBOutlet weak var viewAddContact: UIView!

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblAddContact: UILabel!

    private let selectionthandler = ContactlistHandler()
    weak var delegate: updateCustomerDelegate? = nil
    var jobreqData : JobIssueList!
        
    var arrCustomerData : [contactlist]!
    var strInitialValue : String = ""
    var strcontactTypevalue : String = ""

    var customerData : contactlist!
    var arrInitials = [CustomerTitle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        txtCustomerMobile.isUserInteractionEnabled = true
        txtCustomerFName.isUserInteractionEnabled = true
        txtCustomerLName.isUserInteractionEnabled = true

        txtCustomerMobile.keyboardType = .phonePad
        
        self.viewbtnNew.isHidden = true
        self.viewUpdate.isHidden = true
        self.contblListHeight.constant = 0
        self.viewAddContact.isHidden = true
        self.viewFields.isHidden = true
        self.stackdetail.borderWidth = 0

        arrInitials = UserSettings.shared.arrCustomerTitle
        
        self.tblList.setUpTable(delegate: selectionthandler, dataSource: selectionthandler, cellNibWithReuseId: ContactListCell.className)
        
        /// Handling actions
        
        selectionthandler.SelectClick = {(indexpath , isSelected) in
            
            for i in 0..<self.selectionthandler.arrList.count
            {
                self.txtCustomerLName.text = ""
                self.txtCustomerFName.text = ""
                self.txtCustomerMobile.text = "+971"

                let dict = self.selectionthandler.arrList[i]
                if i == indexpath.row
                {
                    if dict.isSelected == 0
                    {
                        dict.isSelected = 1
                        self.customerData = dict
                    }
                    else
                    {
                       dict.isSelected = 0
                        self.customerData = nil
                    }
                }
                else
                {
                   dict.isSelected = 0
                }
                
                self.selectionthandler.arrList[i] = dict
            }
            self.tblList.reloadData()
            
            self.delegate?.updateCustomerInfo(name: self.customerData.fullName, mobile: self.customerData.mobile)
            self.navigationController?.popViewController(animated: true)

        }


        self.txtCustomerMobile.text = "+971"
        txtCustomerMobile.delegate = self
        txtCustomerFName.delegate = self
        txtCustomerLName.delegate = self
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Contact Information"
        }
        setLabel()
        
        
        ServerRequest.shared.getCustomerContactList(delegate: self) { response in
            
            self.arrCustomerData = response.data
            if response.data.count > 0
            {
                self.viewbtnNew.isHidden = false

                self.selectionthandler.arrList = response.data
                
                let dict = UserSettings.shared.getUserCredential()
                
                if dict.count > 0
                {
                    let custname = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
                    let custMobile = String(format: "%@", dict["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
                    
                    let contactData = contactlist.init()
                    contactData.fullName = custname
                    contactData.mobile = custMobile
                    contactData.isSelected = 0
                    
                    self.selectionthandler.arrList.insert(contactData, at: 0)
                }
                
                //----------------------------------------------------------
                
                let dict1 = UserSettings.shared.getContactUserCredential()
                var name = ""
                var mobile = ""
                
                if dict1["name"] as? String == ""
                {
                    name = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
                    mobile = String(format: "%@", dict["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
                }
                else
                {
                    name = String(format: "%@", dict1["name"] as? String ?? "")
                    mobile = String(format: "%@", dict1["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
                }
                
                for cData in self.selectionthandler.arrList
                {
                    if cData.fullName == name && cData.mobile == mobile
                    {
                        cData.isSelected = 1
                        break
                    }
                }
                //----------------------------------------------------------

                
                self.tblList.reloadData()
                self.contblListHeight.constant =  CGFloat(self.selectionthandler.arrList.count * 55)
                self.tblList.updateConstraintsIfNeeded()
                self.tblList.layoutIfNeeded()
            }
            else
            {
                let dict = UserSettings.shared.getUserCredential()
                
                if dict.count > 0
                {
                    let custname = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
                    let custMobile = String(format: "%@", dict["mobile"] as? String ?? "").replacingOccurrences(of: " ", with: "")
                    
                    let contactData = contactlist.init()
                    contactData.fullName = custname
                    contactData.mobile = custMobile
                    contactData.isSelected = 0
                    
                    self.selectionthandler.arrList.insert(contactData, at: 0)
                }
                
                self.tblList.reloadData()
                self.contblListHeight.constant =  CGFloat(self.selectionthandler.arrList.count * 55)
                self.tblList.updateConstraintsIfNeeded()
                self.tblList.layoutIfNeeded()
                
                self.viewbtnNew.isHidden = false
                self.viewFields.isHidden = true
            }
            
        } failure: { (errorMsg) in
            
        }

    }
    func setLabel()
    {
        txtCustomerFName.placeholder = "First Name"
        txtCustomerLName.placeholder = "Last Name"
        txtCustomerMobile.placeholder = "Mobile Number"
        txtTitle.placeholder = "Title"
        txtType.placeholder = "Contact Type"

        txtTitle.titleFont = UIFont.roboto(size: 15, weight: .Regular)!
        txtCustomerFName.titleFont = UIFont.roboto(size: 15, weight: .Regular)!
        txtCustomerLName.titleFont = UIFont.roboto(size: 15, weight: .Regular)!
        txtCustomerMobile.titleFont = UIFont.roboto(size: 15, weight: .Regular)!
        
        btnUpdate.setTitle("UPDATE", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnUpdate.titleLabel?.font?.pointSize
        {
            btnUpdate.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnNew.titleLabel?.font?.pointSize
        {
            btnNew.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Button methods
    @IBAction func btnNewClick(_ sender: Any)
    {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        
        if customerData == nil && self.viewFields.isHidden == false
        {
            if self.txtType.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please select contact type", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerFName.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please enter first name", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerLName.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please enter last name", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerMobile.text?.count ?? 0 < 12
            {
                SnackBar.make(in: self.view, message: "Please enter valid mobile number", duration: .lengthShort).show()
                return
            }
            
            let fname = self.txtCustomerFName.text?.collapseWhitespace()
            let lname = self.txtCustomerLName.text?.collapseWhitespace()

            
            if self.arrCustomerData.contains(where: {$0.firstName == fname && $0.lastName == lname && $0.mobile == self.txtCustomerMobile.text})
            {
                self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                self.navigationController?.popViewController(animated: true)

            }
            else
            {
                AJAlertController.initialization().showAlert(iscloseShow: true, isBottomShow: false, aStrTitle: "", aStrMessage:"Are you sure you want to save contact information for future?" , aCancelBtnTitle: "NO", aOtherBtnTitle: "YES") { (index, title) in
                    
                    if index == 1 // Confirm
                    {
                        let dictdata = ["customer_id":UserSettings.shared.getCustomerId(),"first_name" : fname ,"last_name" : lname,"mobile":self.txtCustomerMobile.text,"title":self.strInitialValue,"contact_type":self.strcontactTypevalue] as [String:Any]
                                    
                        ServerRequest.shared.setCustomerStore(dictPara: dictdata, delegate: self) {
                            
                            self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                            self.navigationController?.popViewController(animated: true)
                            
                        } failure: { (errorMsg) in
                            
                        }
                    }
                    else
                    {
                        self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        else
        {
            self.customerData = nil
            for i in 0..<self.selectionthandler.arrList.count
            {
                let dict = self.selectionthandler.arrList[i]
                dict.isSelected = 0
                self.selectionthandler.arrList[i] = dict
            }
            self.tblList.reloadData()
            
            self.viewAddContact.isHidden = false
            self.viewFields.isHidden = false
            self.stackdetail.borderWidth = 0.5
        }
        
    }
    
    @IBAction func btnTitleClick(_ sender: Any) {
        
        self.view.endEditing(true)

        let alertvc = IMSH_CUSTOM_SELECTION.createwithInitials(title: "", data: self.arrInitials, type: "initial" , delegate: self)
        alertvc.present(from: self)
    }
    
    @IBAction func btnTypeClick(_ sender: Any) {
        
        self.view.endEditing(true)

        let alertvc = IMSH_CUSTOM_SELECTION.createwithTypes(title: "", data: UserSettings.shared.initialData.contactType, type: "contact" , delegate: self)
        alertvc.present(from: self)
    }
    
    @IBAction func btnCloseClick(_ sender: Any)
    {
        self.viewAddContact.isHidden = true
        self.viewFields.isHidden = true
        self.stackdetail.borderWidth = 0

        self.txtCustomerLName.text = ""
        self.txtCustomerFName.text = ""
        self.txtCustomerMobile.text = "+971"
    }
    
    @IBAction func btUpdateClick(_ sender: Any)
    {
        self.view.endEditing(true)
        
        if customerData == nil && self.viewFields.isHidden == false
        {
            if self.txtType.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please select contact type", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerFName.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please enter first name", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerLName.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please enter last name", duration: .lengthShort).show()
                return
            }
            else if self.txtCustomerMobile.text?.count ?? 0 < 12
            {
                SnackBar.make(in: self.view, message: "Please enter valid mobile number", duration: .lengthShort).show()
                return
            }
            
            let fname = self.txtCustomerFName.text?.collapseWhitespace()
            let lname = self.txtCustomerLName.text?.collapseWhitespace()

            
            if self.arrCustomerData.contains(where: {$0.firstName == fname && $0.lastName == lname && $0.mobile == self.txtCustomerMobile.text})
            {
                self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                self.navigationController?.popViewController(animated: true)

            }
            else
            {
                AJAlertController.initialization().showAlert(isBottomShow: false, aStrTitle: "", aStrMessage:"Are you want to save contact information for future?" , aCancelBtnTitle: "NO", aOtherBtnTitle: "YES") { (index, title) in
                    
                    if index == 1 // Confirm
                    {
                        let dictdata = ["customer_id":UserSettings.shared.getCustomerId(),"first_name" : fname ,"last_name" : lname,"mobile":self.txtCustomerMobile.text,"title":self.strInitialValue,"contact_type":self.strcontactTypevalue] as [String:Any]
                                    
                        ServerRequest.shared.setCustomerStore(dictPara: dictdata, delegate: self) {
                            
                            self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                            self.navigationController?.popViewController(animated: true)
                            
                        } failure: { (errorMsg) in
                            
                        }
                    }
                    else
                    {
                        self.delegate?.updateCustomerInfo(name: (self.txtCustomerFName.text! + " " + self.txtCustomerLName.text!), mobile: self.txtCustomerMobile.text!)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        else if customerData == nil && self.viewFields.isHidden == true
        {
            if self.txtCustomerFName.text?.count == 0
            {
                SnackBar.make(in: self.view, message: "Please select customer information", duration: .lengthShort).show()
                return
            }
        }
        else
        {
            self.delegate?.updateCustomerInfo(name: self.customerData.fullName, mobile: self.customerData.mobile)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtCustomerMobile
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
            
            var strMaxLength = ""
            strMaxLength = "15"
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
        else if textField == txtCustomerFName || textField == txtCustomerLName
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
        }
        
        return true
        
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
   

    
}
protocol updateCustomerDelegate : class {
    func updateCustomerInfo(name:String,mobile:String)
}

extension UPDATE_CUSTOMER_DATA : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
extension UPDATE_CUSTOMER_DATA: ImShCustomSelectionDelegate {
    
    func itemSelected(at index: Int, dict: [String : Any], title: CustomerTitle, dictType: CustomerType, type: String) {
        self.txtType.text = dictType.name
        self.strcontactTypevalue = dictType.id.toString()
    }
    
    func CountrySelected(at index: Int, dict: Country, type: String) {
    }
    
}
