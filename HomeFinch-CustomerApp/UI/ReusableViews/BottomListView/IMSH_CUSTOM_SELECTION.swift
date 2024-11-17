//
//  IMSH_CUSTOM_SELECTION.swift
//  Omahat
//
//  Created by Imran Mohammed on 5/18/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

class IMSH_CUSTOM_SELECTION: UIViewController {
    
        static func createwithCountry(title: String?,
                           data: [Country],type: String,
                           delegate: ImShCustomSelectionDelegate? = nil) -> IMSH_CUSTOM_SELECTION {
            let customselectionvc = IMSH_CUSTOM_SELECTION.instantiate(fromImShStoryboard: .Other)
            customselectionvc.titleStr = title
            customselectionvc.arrCountry = data
            customselectionvc.Typestr = type
            customselectionvc.delegate = delegate
            customselectionvc.modalPresentationStyle = .overFullScreen
            return customselectionvc
        }
        
        static func createwithInitials(title: String?,
                           data: [CustomerTitle],type: String,
                           delegate: ImShCustomSelectionDelegate? = nil) -> IMSH_CUSTOM_SELECTION {
            let customselectionvc = IMSH_CUSTOM_SELECTION.instantiate(fromImShStoryboard: .Other)
            customselectionvc.titleStr = title
            customselectionvc.arrInitials = data
            customselectionvc.Typestr = type
            customselectionvc.delegate = delegate
            customselectionvc.modalPresentationStyle = .overFullScreen
            return customselectionvc
        }
        
        static func createwithTypes(title: String?,
                           data: [CustomerType],type: String,
                           delegate: ImShCustomSelectionDelegate? = nil) -> IMSH_CUSTOM_SELECTION {
            let customselectionvc = IMSH_CUSTOM_SELECTION.instantiate(fromImShStoryboard: .Other)
            customselectionvc.titleStr = title
            customselectionvc.arrTypes = data
            customselectionvc.Typestr = type
            customselectionvc.delegate = delegate
            customselectionvc.modalPresentationStyle = .overFullScreen
            return customselectionvc
        }
        
        static func create(title: String?,
                           data: [[String:Any]],type: String,
                           delegate: ImShCustomSelectionDelegate? = nil) -> IMSH_CUSTOM_SELECTION {
            let customselectionvc = IMSH_CUSTOM_SELECTION.instantiate(fromImShStoryboard: .Other)
            customselectionvc.titleStr = title
            customselectionvc.data = data
            customselectionvc.Typestr = type
            customselectionvc.delegate = delegate
            customselectionvc.modalPresentationStyle = .overFullScreen
            return customselectionvc
        }

        
        func present(from: UIViewController) {
            from.present(self, animated: false, completion: nil)
        }

        // MARK:- OUTLETS
        @IBOutlet weak var baseView: UIView!
        @IBOutlet weak var baseViewHeightConstraint: NSLayoutConstraint!
        @IBOutlet weak var titleLblHeightConstraint: NSLayoutConstraint!
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var dataTableView: UITableView!
        
        @IBOutlet weak var btnDone: UIButton!

        
        // MARK:- REQUIRED
        fileprivate var Typestr: String?
        fileprivate var titleStr: String?
        fileprivate var data = [[String:Any]]()
        
        fileprivate var arrCountry = [Country]()

        fileprivate var arrInitials = [CustomerTitle]()
        fileprivate var arrTypes = [CustomerType]()
        
        fileprivate var arrSelectedTypes = [CustomerType]()


        weak var delegate: ImShCustomSelectionDelegate? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.dataTableView.register(delegate: self, dataSource: self, cellNibWithReuseId: BottomSeletionCell.className)
            ImShSetLayout()

        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
    //        let totalHeight = self.dataTableView.contentSize.height
    //        self.baseViewHeightConstraint.isActive = totalHeight > 200
    //        baseViewHeightConstraint.constant = 50

        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.animateAppear(appear: true, animated: true)
            
            ImShUpdateLabels()
        }
        
        override func ImShSetLayout() {
            // Delegate
            self.dataTableView.delegate = self
            self.dataTableView.dataSource = self
            
            // Prepare for animation
            self.animateAppear(appear: false, animated: false)
            
            // Load data
            self.dataTableView.reloadData()
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
            tapGesture.numberOfTapsRequired = 1
            titleLbl.isUserInteractionEnabled = true
            titleLbl.addGestureRecognizer(tapGesture)
            
            if btnDone != nil {
                self.btnDone.isHidden = true
            }
            
            

        }
        
        //MARK:- Gesture Methods
        @objc func tapGesture(_ sender:UITapGestureRecognizer)
        {
            if Typestr == "room" || Typestr == "feature" || Typestr == "issueabandoned" || Typestr == "contact"
            {
                self.delegate?.itemSelected(at: 0, dict: [:], title: CustomerTitle.init(), dictType: CustomerType.init(), type: Typestr ?? "")
                self.animateAppear(appear: false, animated: true)
            }
        }
        
        override func ImShUpdateLabels() {
            
            if self.titleStr == ""
            {
                self.titleLbl.isHidden = true
                self.titleLblHeightConstraint.constant = 15
            }
            else
            {
                self.titleLbl.isHidden = false
                self.titleLbl.text = self.titleStr
                self.titleLblHeightConstraint.constant = 50
            }
        }
        
        // MARK:- ANIMATION HELPERS
        private func animateAppear(appear: Bool, animated: Bool) {
            let baseViewHeight = self.baseView.frame.height

            if animated {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseInOut], animations: {
                    self.baseView.transform = appear ? CGAffineTransform.identity : CGAffineTransform.init(translationX: 0, y: baseViewHeight)
                    self.view.backgroundColor = appear ? UIColor.black.withAlphaComponent(0.4) : UIColor.black.withAlphaComponent(0.0001)
                }) { (finished) in
                    if !appear {
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            } else {
                self.baseView.transform = appear ? CGAffineTransform.identity : CGAffineTransform.init(translationX: 0, y: baseViewHeight)
                self.view.backgroundColor = appear ? UIColor.black.withAlphaComponent(0.3) : UIColor.black.withAlphaComponent(0.0001)
            }
        }
        
        // MARK:- ACTION HANDLERS
        @IBAction func closeTapped(_ sender: Any) {
            self.animateAppear(appear: false, animated: true)
        }
        
        @IBAction func DoneTapped(_ sender: Any) {
            self.animateAppear(appear: false, animated: true)
        }
    }

// MARK: UITABLEVIEW DELEGATE, DATASOURCE
extension IMSH_CUSTOM_SELECTION: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Typestr == "initial"
        {
            return arrInitials.count
        }
        else if Typestr == "room" || Typestr == "feature" || Typestr == "issueabandoned" || Typestr == "contact"
        {
            return self.arrTypes.count
        }
        else if Typestr == "country"
        {
            return arrCountry.count
        }
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BottomSeletionCell.className, for: indexPath) as! BottomSeletionCell
        
        if Typestr == "country"
        {
            let dict = self.arrCountry.at(index: indexPath.row)
            cell.lblName.text = dict.countryName
            cell.imgView.isHidden = true
            
            let totalHeight = (self.arrCountry.count * 55)
            baseViewHeightConstraint.constant = CGFloat(totalHeight + 50)
            baseView.updateConstraintsIfNeeded()
            baseView.layoutIfNeeded()
            
        }
        else if Typestr == "initial"
        {
            let dict = self.arrInitials.at(index: indexPath.row)
            cell.lblName.text = dict.name
            cell.imgView.isHidden = true
            
            let totalHeight = (self.arrInitials.count * 55)
            baseViewHeightConstraint.constant = CGFloat(totalHeight + 50)
            baseView.updateConstraintsIfNeeded()
            baseView.layoutIfNeeded()
            
        }
        else if Typestr == "room"  || Typestr == "feature" || Typestr == "issueabandoned" || Typestr == "contact"
        {
            let dict = self.arrTypes.at(index: indexPath.row)
            cell.lblName.text = dict.name
            cell.imgView.isHidden = true
            
            //            self.titleLbl.textAlignment = .center
            //            cell.lblName.textAlignment = .center
            
            let totalHeight = (self.arrTypes.count * 55)
            baseViewHeightConstraint.constant = min(300, CGFloat(totalHeight + 50))
            baseView.updateConstraintsIfNeeded()
            baseView.layoutIfNeeded()
            
        }
        
        //        else if Typestr == "feature"
        //        {
        //           let dict = self.arrTypes.at(index: indexPath.row)
        //            cell.lblName.text = dict.name
        //            cell.imgView.isHidden = true
        //            cell.accessoryType = .none
        //
        //            if arrSelectedTypes.contains(dict)
        //            {
        //                cell.accessoryType = .checkmark
        //                cell.tintColor = UserSettings.shared.themeGreenColor()
        //            }
        //
        //            let totalHeight = (self.arrTypes.count * 55)
        //            baseViewHeightConstraint.constant = min(300, CGFloat(totalHeight + 50))
        //            baseView.updateConstraintsIfNeeded()
        //            baseView.layoutIfNeeded()
        //
        //        }
        
        else if Typestr == ""
        {
            let dict = self.data.at(index: indexPath.row)
            cell.lblName.text = dict["Description"] as? String
            cell.imgView.isHidden = true
            
            let totalHeight = (self.data.count * 55)
            baseViewHeightConstraint.constant = CGFloat(totalHeight + 50)
            baseView.updateConstraintsIfNeeded()
            baseView.layoutIfNeeded()
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Typestr == "country"
        {
            let dict = self.arrCountry[indexPath.row]
            self.delegate?.CountrySelected(at: indexPath.row, dict: dict, type: Typestr ?? "")
            self.closeTapped(tableView)
        }
        else if Typestr == "initial"
        {
            let dict = self.arrInitials[indexPath.row]
            self.delegate?.itemSelected(at: indexPath.row, dict: [:], title: dict, dictType: CustomerType.init(), type: Typestr ?? "")
            self.closeTapped(tableView)
        }
        else if Typestr == "room"  || Typestr == "feature" || Typestr == "issueabandoned" || Typestr == "contact"
        {
            let dict = arrTypes[indexPath.row]
            self.delegate?.itemSelected(at: indexPath.row, dict: [:], title: CustomerTitle.init(), dictType: dict, type: Typestr ?? "")
            self.closeTapped(tableView)
        }
        //        else if Typestr == "feature"
        //        {
        //            let dict = arrTypes[indexPath.row]
        //            if arrSelectedTypes.contains(dict)
        //            {
        //                arrSelectedTypes.removeAll(where: {$0.id == dict.id})
        //            }
        //            else
        //            {
        //                arrSelectedTypes.append(dict)
        //            }
        //
        //            tableView.reloadData()
        //        }
        else
        {
            self.closeTapped(tableView)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}

protocol ImShCustomSelectionDelegate: class {
    
    func itemSelected(at index: Int, dict: [String:Any] , title: CustomerTitle , dictType : CustomerType, type: String)
    func CountrySelected(at index: Int, dict: Country , type: String)

}
