//
//  PopOverView.swift
//  HomeFinchCrew
//
//  Created by Mac on 7/21/21.
//

import UIKit

class PopOverView: UIViewController ,UIPopoverPresentationControllerDelegate {
    
    static func create(status: String?,sender:UIImageView) -> PopOverView {
        let popvc = PopOverView.instantiate(fromImShStoryboard: .Other)
        popvc.strStatus = status
        return popvc
    }
    
    static func createOnLbl(status: String?,sender:UILabel) -> PopOverView {
        let popvc = PopOverView.instantiate(fromImShStoryboard: .Other)
        popvc.strStatus = status
        return popvc
    }
    
    @IBOutlet weak var lblStatus: UILabel!
    
    
    var strStatus : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.lblStatus.text = strStatus
    }


    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.none
    }

}
