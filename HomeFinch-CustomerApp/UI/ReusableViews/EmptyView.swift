//
//  EmptyView.swift
//  Omahat
//
//  Created by Imran Mohammed on 5/18/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    // MARK: OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var buttonLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        contentView.fixInView(container: self)
    }
    
    func setup(title: String, buttonTitle: String, image: UIImage?) {
        icon.image = image
        titleLbl.text = title
        buttonLbl.text = buttonTitle
    }
    
}
