//
//  StepperView.swift
//  Omahat
//
//  Created by Imran Mohammed on 2/20/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

class StepperView: UIView {

    // MARK: OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var counterLbl: UILabel!
    
    // MARK: PUBLIC
    var maxCount: Int = 20
    weak var delegate: StepperViewDelegate? = nil
    var currentCount: Int = 1 {
        didSet {
            self.setCount(to: currentCount)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("StepperView", owner: self, options: nil)
        contentView.fixInView(container: self)
    }

    private func setCount(to count: Int) {
        self.counterLbl.tag = count
        self.counterLbl.text = count.toString()
    }
    
    // MARK: ACTION HANDLERS
    @IBAction func plusTapped(_ sender: Any) {
        let current = self.counterLbl.tag
        if current == maxCount { return }
        
        let next = current + 1
        self.setCount(to: next)
        self.delegate?.countUpdated(count: next, minus: false)
    }
    
    @IBAction func minusTapped(_ sender: Any) {
        let current = self.counterLbl.tag
        
        let vc = UIViewController.top!
//        if (vc is CART)
//        {
//            if current == 0
//            { return } //Hussan
//            let previous = current - 1
//            self.setCount(to: previous)
//            self.delegate?.countUpdated(count: previous, minus: true)
//        }
//        else if (vc is PRODUCT_RESULTS) || (vc is WHATS_NEW) || (vc is HOME)
//        {
//            let previous = current - 1
//            self.setCount(to: previous)
//            self.delegate?.countUpdated(count: previous, minus: true)
//        }
//        else
//        {
//            if current == 1
//            { return } //Hussan
//            let previous = current - 1
//            self.setCount(to: previous)
//            self.delegate?.countUpdated(count: previous, minus: true)
//        }
    }
}

protocol StepperViewDelegate: class {
    func countUpdated(count: Int,minus: Bool)
}
