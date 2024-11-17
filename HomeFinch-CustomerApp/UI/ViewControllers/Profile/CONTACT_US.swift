//
//  HELP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit
import SkyFloatingLabelTextField

class CONTACT_US: UIViewController {
    
    static func create() -> CONTACT_US {
        return CONTACT_US.instantiate(fromImShStoryboard: .Profile)
    }
    
    
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblCall : UILabel!
    @IBOutlet weak var lblWebsite : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Contact Us"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()
        
    }
    
    
    
    //    MARK: Button Methods
   
    @IBAction func btnEmailClick(_ sender: Any)
    {
    }
    @IBAction func btnCallClick(_ sender: Any)
    {
    }
    
    @IBAction func btnWebsiteClick(_ sender: Any) {
        
    }
    
}

