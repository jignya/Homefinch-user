//
//  JobCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 18/12/20.
//

import UIKit

class JobCell: UITableViewCell {
    
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var viewDashed: RectangularDashedView!
    @IBOutlet weak var viewFixNow1: UIView!
    @IBOutlet weak var lblServiceNum: UILabel!
    @IBOutlet weak var lblserviceCount: UILabel!
    @IBOutlet weak var viewImgBg: UIView!
    @IBOutlet weak var imgService: UIImageView!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var viewRateService: UIView!
    @IBOutlet weak var lblRateService: UILabel!
//    @IBOutlet weak var viewApplyRating: FloatRatingView!
    @IBOutlet weak var btnRateService: UIButton!

    @IBOutlet weak var viewRatedService: UIView!
//    @IBOutlet weak var viewRated: FloatRatingView!
    @IBOutlet weak var lblRatedService: UILabel!
    
    @IBOutlet weak var btnCancelled: UIButton!
    @IBOutlet weak var viewCancelled: UIView!

    @IBOutlet weak var viewApplyRating: SmileyRateView!
    @IBOutlet weak var viewRated: SmileyRateView!


    
    @IBOutlet weak var lblFixNow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        if let aSize = btnCancelled.titleLabel?.font?.pointSize
        {
            btnCancelled.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
