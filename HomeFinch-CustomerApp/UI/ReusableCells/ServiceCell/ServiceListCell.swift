//
//  ServiceListCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 11/12/20.
//

import UIKit

class ServiceListCell: UITableViewCell {
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgArw: UIImageView!
    
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var collImages: UICollectionView!
    
    @IBOutlet weak var viewDesc: UIView!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnFollowUp: UIButton!
    @IBOutlet weak var viewButtons: UIView!
    
    @IBOutlet weak var viewTechnicianComment: UIView!
    @IBOutlet weak var viewBefore: UIView!
    @IBOutlet weak var viewAfter: UIView!

    @IBOutlet weak var lblTechnicianComment: UILabel!
    @IBOutlet weak var imgBefore: UIImageView!
    @IBOutlet weak var imgAfter: UIImageView!
    @IBOutlet weak var lblBeforeDesc: UILabel!
    @IBOutlet weak var lblAfterDesc: UILabel!
    @IBOutlet weak var lblBefore: UILabel!
    @IBOutlet weak var lblAfter: UILabel!

    @IBOutlet weak var imgStatusIcon: UIImageView!
    @IBOutlet weak var conImageListHeight: NSLayoutConstraint!

    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var btnDelete: UIButton!


    var images = [[String:Any]]()
    var strcomeFrom : String = ""

    
    private let imageHandler = PreviewImagesCollectionHandler()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        // Dynamic Label
        self.setLabel()

                
        if let aSize = btnCancel.titleLabel?.font?.pointSize
        {
            btnCancel.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnEdit.titleLabel?.font?.pointSize
        {
            btnEdit.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnFollowUp.titleLabel?.font?.pointSize
        {
            btnFollowUp.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnDelete.titleLabel?.font?.pointSize
        {
            btnDelete.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        
//        let attrs = [
//            NSAttributedString.Key.font : UIFont.roboto(size: 14, weight: .Bold),
//            NSAttributedString.Key.foregroundColor : UIColor(red: 235.0/255.0, green: 84.0/255.0, blue: 65.0/255.0, alpha: 1),
//            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
//        let attributedString = NSMutableAttributedString(string:"")
//        let buttonTitleStr = NSMutableAttributedString(string:"REMOVE ISSUE", attributes:attrs)
//        attributedString.append(buttonTitleStr)
//        btnDelete.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        btnDelete.setTitle("REMOVE ISSUE", for: .normal)

        btnCancel.setTitle("CANCEL", for: .normal)
        btnEdit.setTitle("EDIT", for: .normal)
        btnFollowUp.setTitle("FOLLOW UP", for: .normal)

        lblBefore.text = "Before Fix"
        lblAfter.text = "After Fix"
        lblTechnicianComment.text = "Technician' Comment"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func ImShSetLayout()
    {
        imageHandler.strComeFrom = strcomeFrom
        imageHandler.images = images
        self.collImages.setUp(delegate: imageHandler, dataSource: imageHandler, cellNibWithReuseId: "MainCategoriesImageCell")
        self.collImages.reloadData()

        /// Handling delete
        imageHandler.deleteTapped = { (indexPath) in
            
            self.imageHandler.images.remove(at: indexPath.row)
            self.refreshCollection()
        }
        
        imageHandler.didSelectForImagePreview = { (indexPath) in
            
            let storyboard = UIStoryboard.init(name: "Other", bundle: nil)
            let image = storyboard.instantiateViewController(withIdentifier: "ImagePreviewVC") as! ImagePreviewVC
            image.arrrimages = NSMutableArray(array: self.images)
            image.index = indexPath
            image.strcome = self.strcomeFrom
            image.modalPresentationStyle = .overFullScreen
            let vc = UIApplication.topViewController()
            vc?.present(image, animated: false, completion: nil)
//            vc?.navigationController?.pushViewController(image, animated: false)
        }
        
    }
    
    func refreshCollection()
    {
        imageHandler.strComeFrom = "list"
//        imageHandler.images = UserSettings.shared.images
        self.collImages.reloadData()
    }
    
}
