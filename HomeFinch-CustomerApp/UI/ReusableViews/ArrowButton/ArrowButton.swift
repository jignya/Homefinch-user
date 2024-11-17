//
//  ArrowButton.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/8/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

class ArrowButton: UIView {

    // MARK: OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    
    // MARK: REQUIRED
    weak var delegate: ArrowButtonDelegate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ArrowButton", owner: self, options: nil)
        contentView.fixInView(container: self)
    }

    // MARK: PUBLIC
    func setup(title: String?, delegate: ArrowButtonDelegate?) {
        
        if title == UserSettings.shared.getLabelValue(Id: "56")
        {
            imgIcon.image = UIImage(named: "Location")
        }
        else
        {
            imgIcon.image = UIImage(named: "Language")
        }
        self.titleLbl.text = title
        self.delegate = delegate
    }
    
    func updateTitle(title: String?) {
        self.titleLbl.text = title
    }
    
    // MARK: ACTION HANDLERS
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.delegate?.arrowBtnTapped(tag: self.tag)
    }
    
}

protocol ArrowButtonDelegate: class {
    func arrowBtnTapped(tag: Int)
}
