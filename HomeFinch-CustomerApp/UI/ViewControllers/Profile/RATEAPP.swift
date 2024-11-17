//
//  RATEAPP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit

class RATEAPP: UIViewController {

    static func create() -> RATEAPP {
        return RATEAPP.instantiate(fromImShStoryboard: .Profile)
    }
        
    @IBOutlet weak var lblSendFeedback : UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var txtFeedback: UITextView!

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!

    @IBOutlet weak var btnSend: UIButton!
    var isSelected = false
    var rating : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = ""
        }
        
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = true
        lbl4.isHidden = false
        lbl5.isHidden = true
        
        self.rating = 4
        self.btnSelection(is1: false, is2: false, is3: false, is4: true, is5: false)


        setLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()
        
    }
    
    func setLabel()
    {
        btnSend.setTitle(("Send").uppercased(), for: .normal)
        lblSendFeedback.text = "Send Feedback"
        lblMessage.text = "Let us know how satisfied you are with our App. Your feedback is greatly appreciated!"
        lblFeedback.text = "  Feedback"
        txtFeedback.placeholder1 = "Write your feedback here"
        
        lbl1.text = "Very poor"
        lbl2.text = "Poor"
        lbl3.text = "Average"
        lbl4.text = "Good"
        lbl5.text = "Very Good"

    }
    
    func btnSelection(is1:Bool,is2:Bool,is3:Bool,is4:Bool,is5:Bool)
    {
        btn1.isSelected = is1
        btn2.isSelected = is2
        btn3.isSelected = is3
        btn4.isSelected = is4
        btn5.isSelected = is5
        
        lbl1.isHidden = !is1
        lbl2.isHidden = !is2
        lbl3.isHidden = !is3
        lbl4.isHidden = !is4
        lbl5.isHidden = !is5


    }
    
    //    MARK: Button Methods
    @IBAction func btnSendClick(_ sender: Any)
    {
        self.view.endEditing(true)
        
        if txtFeedback.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter your feedback", duration: .lengthShort).show()
            return

        }
//        else if isSelected == false
//        {
//            SnackBar.make(in: self.view, message: "Please select your ex", duration: .lengthShort).show()
//            return
//        }
        else
        {
            ServerRequest.shared.updateAppRating(rating: self.rating, comment: txtFeedback.text, delegate: self) {
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Thank you for rating application", aOKBtnTitle: "OK") { (index, title) in
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
            } failure: { (errorMsg) in
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                }
            }

        }
        
    }
    @IBAction func btnClick(_ sender: Any)
    {
        let btn = sender as! UIButton
        isSelected = true
        if btn.tag == 0
        {
            self.rating = 1
            self.btnSelection(is1: true, is2: false, is3: false, is4: false, is5: false)
        }
        else if btn.tag == 1
        {
            self.rating = 2
            self.btnSelection(is1: false, is2: true, is3: false, is4: false, is5: false)
        }
        else if btn.tag == 2
        {
            self.rating = 3
            self.btnSelection(is1: false, is2: false, is3: true, is4: false, is5: false)
        }
        else if btn.tag == 3
        {
            self.rating = 4
            self.btnSelection(is1: false, is2: false, is3: false, is4: true, is5: false)
        }
        else
        {
            self.rating = 5
            self.btnSelection(is1: false, is2: false, is3: false, is4: false, is5: true)
        }
    }
   

}
extension RATEAPP : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
