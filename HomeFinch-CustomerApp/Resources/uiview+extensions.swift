//
//  uiview+extensions.swift
//  Omahat
//
//  Created by Imran Mohammed on 10/22/18.
//  Copyright © 2018 ImSh. All rights reserved.


import Foundation
import UIKit

extension UIFont {
    
    /*
     Font: Roboto-Regular
     Font: Roboto-Medium
     Font: Roboto-Bold
     */
    
    enum ImShCustomFontWeight: String {
        case Light,Regular, Medium, Bold
    }
    
    static func roboto(size: CGFloat, weight: ImShCustomFontWeight = .Regular) -> UIFont? {
        return UIFont(name: "Roboto-\(weight.rawValue)", size: size) ?? UIFont(name: "Roboto-Regular", size: size)!
    }
}

extension UIColor {
    
    enum ServiceStatus: String {
        case completed,cancelled, outForService, servicePlaced , inspection
    }
    
    static func statusTextColor(status: ServiceStatus = .completed) -> UIColor?
    {
        switch status {
        case .completed:
            return UIColor(red: 92.0/255.0, green: 194.0/255.0, blue: 119.0/255.0, alpha: 1)
        case .cancelled:
            return UIColor(red: 235.0/255.0, green: 84.0/255.0, blue: 65.0/255.0, alpha: 1)
        case .outForService:
            return UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1)
        case .servicePlaced:
            return UIColor(red: 201.0/255.0, green: 207.0/255.0, blue: 84.0/255.0, alpha: 1)
        case .inspection:
            return UIColor(red: 225.0/255.0, green: 104.0/255.0, blue: 66.0/255.0, alpha: 1)
        }
    }
    static func statusBackgroundColor(status: ServiceStatus = .completed) -> UIColor?
    {
        switch status {
        case .completed:
            return UIColor(red: 228.0/255.0, green: 255.0/255.0, blue: 235.0/255.0, alpha: 1)
        case .cancelled:
            return UIColor(red: 255.0/255.0, green: 233.0/255.0, blue: 230.0/255.0, alpha: 1)
        case .outForService:
            return UIColor(red: 212.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        case .servicePlaced:
            return UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 223.0/255.0, alpha: 1)
        case .inspection:
            return UIColor(red: 245.0/255.0, green: 233.0/255.0, blue: 230.0/255.0, alpha: 1)
        }
    }
}


extension UIImage {
    
    enum CustomImageType: String {
        case Placeholder, Placeholder_Gray , Placeholder_T
    }
    
    static func image(type: CustomImageType) -> UIImage? {
        return UIImage.init(named: type.rawValue)
    }
    
    enum StatusImageType: String {
        case S_Cancelled, S_Completed, S_Inspection, S_Intransit , S_Placed
    }
    
    static func Serviceimage(type: StatusImageType) -> UIImage? {
        return UIImage.init(named: type.rawValue)
    }
}

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set (new) {
            self.layer.cornerRadius = new
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set (new) {
            self.layer.borderWidth = new
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        set (new) {
            self.layer.borderColor = new.cgColor
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return self.layer.cornerRadius == (bounds.height / 2)
        }
        set (new) {
            self.layer.cornerRadius = new ? (bounds.height / 2) : 0
        }
    }
    
    /// For shadow
    @IBInspectable var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set (new) {
            self.layer.masksToBounds = new
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set (new) {
            self.layer.shadowColor = new.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set (new) {
            self.layer.shadowOpacity = new
            self.updateShadow()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set (new) {
            self.layer.shadowRadius = new
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set (new) {
            self.layer.shadowOffset = new
        }
    }
    
    private func updateShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
}

@IBDesignable
extension UIImageView {
    
    @IBInspectable var tint: UIColor {
        get {
            return self.tintColor
        }
        set (new) {
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = new
        }
    }
    
}

extension UICollectionReusableView {
    
    class var className: String {
        return "\(self)"
    }
    
}

extension UITableViewCell {
    
    class var className: String {
        return "\(self)"
    }
    
}

extension UITableView {
    
    public func register(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellNibWithReuseId: String? = nil) {
        if let nibReuseId = cellNibWithReuseId {
            self.register(UINib.init(nibName: nibReuseId, bundle: nil), forCellReuseIdentifier: nibReuseId)
        }
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
}

extension UINavigationBar {
    
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
}

extension String {
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
    
}

extension UITabBarController {
    
    open func hideTabBar(animated: Bool = true) {
        var frame = self.tabBar.frame
        let height = self.view.frame.size.height + (frame.size.height)
        frame.origin.y = height
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.tabBar.frame = frame
        })
    }
    
    open func showTabBar(animated: Bool = true) {
        var frame = self.tabBar.frame
        let height = self.view.frame.size.height - (frame.size.height)
        frame.origin.y = height
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.tabBar.frame = frame
        })
    }
}

extension Bool {
    /// String will be cached to UserDefaults with Key and Synchronized
    ///
    /// - Parameter key: String
    func cache(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    
    /// Cached string for the Key will be returned optionally
    ///
    /// - Parameter key: String
    /// - Returns: String?
    static func cached(key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}

extension Optional where Wrapped == Float {
    
    var explicit: Float {
        return self ?? 0.0
    }
    
}

extension UINavigationItem {
    
//    func setCartBtn(target: Any?,
//                    action: Selector? = nil,
//                    tag: Int = 0,
//                    animated: Bool = true)
//    {
//        let cartBtnHolder = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        let cartBtn = UIButton(frame: CGRect(x: 0, y: 10, width: 30, height: 30))
////        cartBtn.setImage(UIImage.image(type: .shoppingCart), for: .normal)
//        cartBtn.setImage(UIImage(named: "cart.png"), for: .normal)
//        cartBtn.imageEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
//        cartBtn.imageView?.contentMode = .scaleAspectFit
////        cartBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        cartBtn.tag = tag
//        if let a = action {
//            cartBtn.addTarget(target, action: a, for: .touchUpInside)
//        }
//        cartBtnHolder.addSubview(cartBtn)
//        var badge = (UserSettings.shared.getCartCount() as String)
//
//        let cartBadge = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
//        cartBadge.tag = 1202
//        cartBadge.layer.cornerRadius = 10
//        cartBadge.clipsToBounds = true
//        cartBadge.font = UIFont.roboto(size: 12, weight: .Medium)
//        cartBadge.textAlignment = .center
//        cartBtnHolder.addSubview(cartBadge)
//
//        if badge == ""
//        {
//            badge = "0"
//        }
//        if Int(badge)! > 0
//        {
//            cartBadge.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//            cartBadge.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            cartBadge.text = badge
//        }
//        else
//        {
//            cartBadge.backgroundColor = .clear
//            cartBadge.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            cartBadge.text = ""
//        }
//
//        let cartButton = UIBarButtonItem(customView: cartBtnHolder)
////        cartButton.tintColor = .gray
//        self.setRightBarButton(cartButton, animated: animated)
//    }
//
//    func setCartBadge(badgeStr : String)
//    {
//        if let custView = self.rightBarButtonItem?.customView
//        {
//            if let badgeLbl = custView.viewWithTag(1202) as? UILabel
//            {
//                if badgeStr == "0"
//                {
//                    badgeLbl.text = ""
//                    badgeLbl.backgroundColor = .clear
//                }
//                else
//                {
//                    badgeLbl.text = badgeStr
//                    badgeLbl.backgroundColor = .red
//                }
//            }
//        }
//    }
    
    func setNotificationBtn(target: Any?,
                    action: Selector? = nil,
                    tag: Int = 0,
                    animated: Bool = true)
    {
        let notBtnHolder = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let notBtn = UIButton(frame: CGRect(x: 0, y: 10, width: 30, height: 30))
        notBtn.setImage(UIImage(named: "Notification"), for: .normal)
        notBtn.imageEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        notBtn.imageView?.contentMode = .scaleAspectFit
        notBtn.tag = tag
        if let a = action {
            notBtn.addTarget(target, action: a, for: .touchUpInside)
        }
        notBtnHolder.addSubview(notBtn)

        let notBadge = UILabel(frame: CGRect(x: 20, y: 7, width: 6 , height: 6))
        notBadge.tag = 1202
        notBadge.layer.cornerRadius = 3
        notBadge.clipsToBounds = true
        notBadge.font = UIFont.roboto(size: 12, weight: .Medium)
        notBadge.textAlignment = .center
        notBtnHolder.addSubview(notBadge)
        
        if tag != 0
        {
            notBadge.isHidden = false
            notBadge.backgroundColor = UserSettings.shared.themeColor()
        }
        else
        {
            notBadge.backgroundColor = .clear
            notBadge.isHidden = true

        }
        
        let notButton = UIBarButtonItem(customView: notBtnHolder)
        self.setLeftBarButton(notButton, animated: true)
    }
    
    func setBadgeCount(value : Int)
    {
        if let custView = self.leftBarButtonItem?.customView
        {
            if let notBadge = custView.viewWithTag(1202) as? UILabel
            {
                if value != 0
                {
                    notBadge.isHidden = false
                    notBadge.backgroundColor = UserSettings.shared.themeColor()
                }
                else
                {
                    notBadge.backgroundColor = .clear
                    notBadge.isHidden = true

                }
            }
        }
    }
    
    func setwalletBtn(target: Any?,
                    action: Selector? = nil,
                    amount: String = "0",
                    animated: Bool = true)
    {
        
        let stackview = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        stackview.alignment = .center
        stackview.spacing = 10.0
        
        var walletBtn = UIButton(type: .custom)
        walletBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        let amount = String(format: "%@", amount)
        walletBtn.setTitle(amount, for: .normal)
        walletBtn.titleLabel?.font = UIFont.roboto(size: 14, weight: .Regular)
        walletBtn.setTitleColor(UIColor.darkGray, for: .normal)

        walletBtn.tag = 1203

        let imgWallet = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgWallet.image = UIImage(named: "Wallet")

        if let a = action {
            walletBtn.addTarget(target, action: a, for: .touchUpInside)
        }
        
        stackview.addArrangedSubview(walletBtn)
        stackview.addArrangedSubview(imgWallet)

        let notButton = UIBarButtonItem(customView: stackview)
        self.setRightBarButton(notButton, animated: true)
    }
    
    func setWalletBalance(stramount : String)
    {
        if let custView = self.rightBarButtonItem?.customView
        {
            if let walletBtn = custView.viewWithTag(1203) as? UIButton
            {
                if stramount == "0" || stramount == ""
                {
                    walletBtn.setTitle("AED 0.00", for: .normal) 
                }
                else
                {
                    walletBtn.setTitle(stramount, for: .normal)
                }
            }
        }
    }

}

@IBDesignable
extension UILabel {
    
    @IBInspectable
    var localizedText: String {
        get { return self.text ?? "UILabel" }
        set { self.text = newValue.localized }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.handleLocalizedText()
    }
    
    private func handleLocalizedText() {
        guard let text = self.text else { return }
        self.text = text.localized
    }
    
}


@IBDesignable
extension UIButton {
    
    @IBInspectable
    var localizedText: String {
        get { return self.titleLabel?.text ?? "UIButton" }
        set { self.setTitle(newValue.localized, for: .normal) }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.handleLocalizedText()
    }
    
    private func handleLocalizedText() {
        guard let text = self.titleLabel?.text else { return }
        self.setTitle(text.localized, for: .normal)
    }

}


@IBDesignable
extension UITextField {
    
    @IBInspectable
    var localizedPlaceholder: String {
        get { return self.placeholder ?? "UITextField" }
        set { self.placeholder = newValue.localized }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.handleIntendation()
        self.handleLocalizedText()
    }
    
    private func handleIntendation() {
        if self.textAlignment == .center { return }
        
        switch ImShLanguage.shared.get() {
        case .arabic:
            self.textAlignment = .right
        default:
            self.textAlignment = .left
        }
    }
    
    private func handleLocalizedText() {
        guard let text = self.placeholder else { return }
        print("Replaceable:\"\(text)\" = \"\(text)\"; ")
        self.placeholder = text.localized
    }
    
}
