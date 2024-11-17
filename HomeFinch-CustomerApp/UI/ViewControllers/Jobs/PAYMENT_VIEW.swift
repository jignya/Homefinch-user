//
//  PAYMENT_VIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 25/02/21.
//

import UIKit
import PaymentSDK

class PAYMENT_VIEW: UIViewController {
    
    static func create(strAmount:String, isNew : Bool , dict:[String:Any],comeFrom:String) -> PAYMENT_VIEW {
        let view = PAYMENT_VIEW.instantiate(fromImShStoryboard: .Jobs)
        view.strAmount = strAmount
        view.isNewCard = isNew
        view.dictCard = dict
        view.strComeFrom = comeFrom
        return view
    }
    
    
    
    var billingDetails: PaymentSDKBillingDetails!
    var shippingDetails: PaymentSDKShippingDetails!


    var strAmount : String!
    var isNewCard : Bool!
    var strComeFrom : String!

    var dictCard : [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Payment"
        }
        
        billingDetails = PaymentSDKBillingDetails(name: "John Smith",
                                                  email: "email@test.com",
                                                  phone: "+97311111111",
                                                  addressLine: "Street1",
                                                  city: "Dubai",
                                                  state: "Dubai",
                                                  countryCode: "ae",
                                                  zip: "12345")
        
        shippingDetails = PaymentSDKShippingDetails(name: "John Smith",
                                                    email: "email@test.com",
                                                    phone: "+9731111111",
                                                    addressLine: "Street1",
                                                    city: "Dubai",
                                                    state: "Dubai",
                                                    countryCode: "ae",
                                                    zip: "12345")
        
       
        paymentForCard()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        if strComeFrom != "profile"
        {
            self.navigationController?.navigationBar.isHidden = true
        }
    }

    //MARK: Payment Window
    func paymentForCard()
    {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "homefinch-Black")
        
        theme.secondaryColor = UserSettings.shared.themeColor()
        theme.titleFontColor = UserSettings.shared.themeColor()
        theme.buttonColor = UserSettings.shared.themeColor()
        theme.titleFontColor = UserSettings.shared.themeColor2()
        theme.secondaryFontColor = UserSettings.shared.themeColor2()
        
        theme.titleFont = UIFont.roboto(size: 15, weight: .Medium)
        theme.buttonFont = UIFont.roboto(size: 15, weight: .Medium)
        theme.secondaryFont = UIFont.roboto(size: 13, weight: .Medium)

        
        let configuration1 = PaymentSDKConfiguration(profileID: pt_profileID,
                                            serverKey: pt_serverKey,
                                            clientKey: pt_clientKey,
                                            cartID: "12345",
                                            currency: "AED",
                                            amount: 5.0,
                                            cartDescription: "test",
                                            merchantCountryCode: "AE", // ISO alpha 2
                                            showBillingInfo: false,
                                            screenTitle: "Pay with Card",
                                            hideCardScanner: true,
                                            billingDetails: billingDetails)

        configuration1.theme = theme
        configuration1.tokeniseType = .userOptinoal
        configuration1.tokenFormat = .digit16
        
        if !dictCard.isEmpty && isNewCard == false
        {
            configuration1.transactionReference = dictCard["ref"] as? String ?? ""
            configuration1.token = dictCard["token"] as? String ?? ""
        }
        
        PaymentManager.startCardPayment(on: self, configuration: configuration1,
                                 delegate: self)
    }
    
    
    private func showAlert(message:String,type:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            let alert = UIAlertController(title: type, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
            self.present(alert, animated: true, completion: nil)
            
        }
       
    }
    

}
extension PAYMENT_VIEW: PaymentManagerDelegate {
    
    func paymentManager(didFinishTransaction transactionDetails: PaymentSDKTransactionDetails?, error: Error?) {
        if let transactionDetails = transactionDetails {
            print(transactionDetails.debugDescription)

            print("Response Code: " + (transactionDetails.paymentResult?.responseCode ?? ""))
            print("Result: " + (transactionDetails.paymentResult?.responseMessage ?? ""))
            print("Token: " + (transactionDetails.token ?? ""))
            print("Transaction Reference: " + (transactionDetails.transactionReference ?? ""))
            print("Transaction Time: " + (transactionDetails.paymentResult?.transactionTime ?? "" ))
            print("Card: " + (transactionDetails.cartDescription ?? "" ))
                        
            var dict = [String:Any]()
            
            let token = transactionDetails.token ?? ""
            
            if !token.isEmpty
            {
                let arr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
                
                var cardArr = arr
                if let ref = transactionDetails.transactionReference{
                    dict["ref"] = ref
                }
                if let last4 = transactionDetails.paymentInfo?.paymentDescription{
                    dict["last4"] = last4
                }
                
                if let code = transactionDetails.paymentInfo?.cardScheme{
                    dict["code"] = code
                }
                
                if let name = transactionDetails.billingDetails?.name{
                    dict["name"] = name
                }
                
                if let name = transactionDetails.token{
                    dict["token"] = name
                }
                
                if !cardArr.contains(where: {$0["last4"] as? String == dict["last4"] as? String})
                {
                    cardArr.append(dict)
                }
                
                CommonFunction.shared.SaveArrayDatainTextFile(fileName: "card.txt", arrData: cardArr)

            }
            

            
        } else if let error = error {
            showAlert(message: error.localizedDescription, type: "")
        }
    }
    
    func paymentManager(didCancelPayment error: Error?) {
        self.navigationController?.popViewController(animated: false)
    }
}


