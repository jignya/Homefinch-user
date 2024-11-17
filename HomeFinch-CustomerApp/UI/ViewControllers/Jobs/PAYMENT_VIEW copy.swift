//
//  PAYMENT_VIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 25/02/21.
//

import UIKit
import TelrSDK

class PAYMENT_VIEW: UIViewController {
    
    static func create(strAmount:String, isNew : Bool , dict:[String:Any]) -> PAYMENT_VIEW {
        let view = PAYMENT_VIEW.instantiate(fromImShStoryboard: .Jobs)
        view.strAmount = strAmount
        view.isNewCard = isNew
        view.dictCard = dict
        return view
    }
    
    
    let tabbyKEY:String = "pk_test_d878b6de-9f6f-4c2c-bc8c-fde1b249b9c4"

    let KEY:String = " jT4F2^PjBp-n8jbr" // TODO fill key
    let STOREID:String = "24717"  // TODO fill store id - 25250
    let EMAIL:String = "test@test.com" // TODO fill email id

    var paymentRequest:PaymentRequest?
    var strAmount : String!
    var isNewCard : Bool!

    var dictCard : [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Payment"
        }
        
        if isNewCard
        {
            paymentForNewCard()
        }
        else
        {
            paymentforsavedCard()
        }
    }
    
    func paymentForNewCard()
    {
        paymentRequest = preparePaymentRequest()
        let telrController = TelrController()
        telrController.delegate = self
        telrController.paymentRequest = paymentRequest!
//        self.navigationController?.pushViewController(telrController, animated: false)
        
        addChild(telrController)
        telrController.view.frame = self.view.bounds
        view.addSubview(telrController.view)
        telrController.didMove(toParent: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func paymentforsavedCard()
    {
        paymentRequest = preparePaymentRequestSaveCard()
        let telrController = TelrController()
        telrController.delegate = self
        telrController.paymentRequest = paymentRequest!
//        let nav = UINavigationController(rootViewController: telrController)
//        self.navigationController?.present(nav, animated: true, completion: nil)
        
        addChild(telrController)
        telrController.view.frame = self.view.bounds
        view.addSubview(telrController.view)
        telrController.didMove(toParent: self)

    }
    
    //MARK:- GET & DISPLAY Saved cards
  
//    private func getSavedData(key:String) -> [[String:Any]]
//    {
//        let defaults = UserDefaults.standard
//        return defaults.value(forKey: "cards") as? [[String:Any]] ?? []
//
//    }
    
    private func saveData(key:String, value:[[String:Any]]){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    private func showAlert(message:String,type:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            let alert = UIAlertController(title: type, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
            self.present(alert, animated: true, completion: nil)
            
        }
       
    }
    

}
extension PAYMENT_VIEW:TelrControllerDelegate{
    func didPaymentFail(messge: String) {
        self.showAlert(message: "didPaymentFail", type: "Fail")
    }
    
    //Mark:- This method call when user click on back button
    func didPaymentCancel() {
        print("didPaymentCancel")
        self.showAlert(message: "didPaymentCancel", type: "Cancel")
    }
    
    //Mark:- This method call when payment done successfully
    func didPaymentSuccess(response: TelrResponseModel) {
        
        print("didPaymentSuccess")
           
        print("Trace \(String(describing: response.trace))")
        
        print("Status \(String(describing: response.status))")
        
        print("Avs \(String(describing: response.avs))")
        
        print("Code \(String(describing: response.code))")
        
        print("Ca_valid \(String(describing: response.ca_valid))")
        
        print("Card Code \(String(describing: response.cardCode))")
        
        print("Card Last4 \(String(describing: response.cardLast4))")
        
        print("CVV \(String(describing: response.cvv))")
        
        print("TranRef \(String(describing: response.transRef))")
        
        
        //Mark:- Save card management it save only one card at time.
        //For save the card you need to store tranRef and when you are going to make second trans using thistranRef
        
        var dict = [String:Any]()
//        let data = UserDefaults.standard.value(forKey: "cards")
        
        let arr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
        
        var cardArr = arr
        if let ref = response.transRef{
            dict["ref"] = ref
        }
        if let last4 = response.cardLast4{
            dict["last4"] = last4
        }
        
        if let code = response.cardCode{
            dict["code"] = code
        }
        
        if let year = response.year{
            dict["year"] = year
        }
        
        if let name = response.billingFName{
            dict["name"] = name
        }
        
        
        if !cardArr.contains(where: {$0["last4"] as? String == dict["last4"] as? String})
        {
            cardArr.append(dict)
        }
        
        CommonFunction.shared.SaveArrayDatainTextFile(fileName: "card.txt", arrData: cardArr)
        
//        UserDefaults.standard.setValue(cardArr, forKey: "cards")
//
//        saveData(key: "cards", value: cardArr)
        self.showAlert(message: "didPaymentSuccess", type: "Success")
    }
    
    
    func didCancelPayment() {
        print("didCancelPayment")
    }
    
    
}


//Mark:- Payment Request Builder
extension PAYMENT_VIEW{
    
     private func preparePaymentRequest() -> PaymentRequest{
     
     
         let paymentReq = PaymentRequest()
     
         paymentReq.key = KEY
     
         paymentReq.store = STOREID
     
         paymentReq.appId = "123456789"
    
         paymentReq.appName = "HomeFinch"
     
         paymentReq.appUser = "123456"
     
         paymentReq.appVersion = "0.0.1"
     
         paymentReq.transTest = "1"
    
         paymentReq.transType = "auth"
    
         paymentReq.transClass = "paypage"
     
         paymentReq.transCartid = String(arc4random())
     
         paymentReq.transDesc = "Test API"
     
         paymentReq.transCurrency = "AED"
     
         paymentReq.transAmount = strAmount
     
         paymentReq.billingEmail = EMAIL
     
         paymentReq.billingFName = "Hany"
     
         paymentReq.billingLName = "Sakr"
     
         paymentReq.billingTitle = "Mr"
     
         paymentReq.city = "Dubai"
     
         paymentReq.country = "AE"
     
         paymentReq.region = "Dubai"
     
         paymentReq.address = "line 1"
     
         paymentReq.language = "en"
     
         return paymentReq

     }


    private func preparePaymentRequestSaveCard() -> PaymentRequest{
        
        let paymentReq = PaymentRequest()
        
        paymentReq.key = KEY
        
        paymentReq.store = STOREID
        
        paymentReq.appId = "123456789"
        
        paymentReq.appName = "HomeFinch"
        
        paymentReq.appUser = "123456"
        
        paymentReq.appVersion = "0.0.1"
        
        paymentReq.transTest = "1"
        
        paymentReq.transType = "paypage"
        
        paymentReq.transClass = "ecom"
        
        paymentReq.transCartid = String(arc4random())
        
        paymentReq.transDesc = "Test API"
        
        paymentReq.transCurrency = "AED"
        
        paymentReq.billingFName = "Hany"
        
        paymentReq.billingLName = "Sakr"
        
        paymentReq.billingTitle = "Mr"
        
        paymentReq.city = "Dubai"
        
        paymentReq.country = "AE"
        
        paymentReq.region = "Dubai"
        
        paymentReq.address = "line 1"
        
        paymentReq.transAmount = strAmount
        
        paymentReq.transFirstRef = self.dictCard["ref"] as! String
        
        paymentReq.transRef = self.dictCard["ref"] as! String
        
        paymentReq.billingEmail = EMAIL
        
        paymentReq.language = "en"
        
        return paymentReq
        
    }
}
