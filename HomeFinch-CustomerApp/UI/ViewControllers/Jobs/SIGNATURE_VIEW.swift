//
//  SIGNATURE_VIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 05/01/21.
//

import UIKit

class SIGNATURE_VIEW: UIViewController {
    
    static func create(image:String!) -> SIGNATURE_VIEW {
        let selection = SIGNATURE_VIEW.instantiate(fromImShStoryboard: .Jobs)
        selection.strImg = image
        return selection
    }
       
    //MARK:Outlets
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imgSignature: UIImageView!
    @IBOutlet weak var lblsignature: UILabel!

    var strImg : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.setLabel()
        
        self.imgSignature.clipsToBounds = true
        self.imgSignature.contentMode = .scaleAspectFit
        self.imgSignature.setImage(url: strImg?.getURL, placeholder: UIImage.image(type: .Placeholder))

    }
    
    func setLabel()
    {
        lblsignature.text = "Signature"

    }
    override func viewWillLayoutSubviews() {
        
        viewInfo.roundCorners(corners: [.topLeft,.topRight] , radius: 25.0)
    }
    
    //MARK: Buttton Methods
    
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
