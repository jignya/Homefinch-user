//
//  StepperView.swift
//  Omahat
//
//  Created by Imran Mohammed on 2/20/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

class SmileyRateView: UIView {

    // MARK:- OUTLETS
    @IBOutlet weak var contentView: UIStackView!

    @IBOutlet weak var btnrate1: UIButton!
    @IBOutlet weak var btnrate2: UIButton!
    @IBOutlet weak var btnrate3: UIButton!
    @IBOutlet weak var btnrate4: UIButton!
    @IBOutlet weak var btnrate5: UIButton!

    @IBOutlet weak var lblrate1: UILabel!
    @IBOutlet weak var lblrate2: UILabel!
    @IBOutlet weak var lblrate3: UILabel!
    @IBOutlet weak var lblrate4: UILabel!
    @IBOutlet weak var lblrate5: UILabel!

    var ratingId : Int!

    public var isDisplay: String!

    // MARK: PUBLIC
    weak var delegate: SmileyRateViewDelegate? = nil
    
    var dataPassed: String! {
        didSet {
            isDisplay = dataPassed
        }
    }
    
    var currentCount: Int = 1 {
        didSet {
            self.setRateCount(count: currentCount)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        commonInit()
    }
    
    func commonInit() {
        
        if isDisplay == "yes"
        {
            Bundle.main.loadNibNamed("SmileyRateView1", owner: self, options: nil)
            contentView.fixInView(container: self)

            self.btnrate1.isUserInteractionEnabled = false
            self.btnrate2.isUserInteractionEnabled = false
            self.btnrate3.isUserInteractionEnabled = false
            self.btnrate4.isUserInteractionEnabled = false
            self.btnrate5.isUserInteractionEnabled = false
        }
        else
        {
            Bundle.main.loadNibNamed("SmileyRateView", owner: self, options: nil)
            contentView.fixInView(container: self)

            lblrate1.text = "VERY BAD"
            lblrate2.text = "POOR"
            lblrate3.text = "FAIR"
            lblrate4.text = "GOOD"
            lblrate5.text = "EXECLLENT"
        }

    }
   
    private func setRateCount(count: Int) {
        
        if count == 1
        {
            btnrate1.isSelected = true
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if count == 2
        {
            btnrate1.isSelected = false
            btnrate2.isSelected = true
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if count == 3
        {
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = true
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if count == 4
        {
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = true
            btnrate5.isSelected = false
        }
        else if count == 5
        {
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = true
        }
    }
    
    // MARK: ACTION HANDLERS
    @IBAction func btnEmojiClick(_ sender: Any)
    {
        let btn = sender as! UIButton

        if btn.tag == 1
        {
            ratingId = 1
            btnrate1.isSelected = true
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 2
        {
            ratingId = 2
            btnrate1.isSelected = false
            btnrate2.isSelected = true
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 3
        {
            ratingId = 3
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = true
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        else if btn.tag == 4
        {
            ratingId = 4
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = true
            btnrate5.isSelected = false
        }
        else if btn.tag == 5
        {
            ratingId = 5
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = true
        }
        else
        {
            btnrate1.isSelected = false
            btnrate2.isSelected = false
            btnrate3.isSelected = false
            btnrate4.isSelected = false
            btnrate5.isSelected = false
        }
        
        lblrate1.isHidden = !btnrate1.isSelected
        lblrate2.isHidden = !btnrate2.isSelected
        lblrate3.isHidden = !btnrate3.isSelected
        lblrate4.isHidden = !btnrate4.isSelected
        lblrate5.isHidden = !btnrate5.isSelected
        
        self.delegate?.ratingUpdated(count: ratingId)
        
    }
}

protocol SmileyRateViewDelegate: class {
    func ratingUpdated(count: Int)
}
