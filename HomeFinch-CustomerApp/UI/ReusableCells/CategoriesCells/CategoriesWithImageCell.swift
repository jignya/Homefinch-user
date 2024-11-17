//
//  CategoriesWithImageCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit
import Kingfisher

class CategoriesWithImageCell: UICollectionViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    var issue: trendingIssuelist? {
        didSet {
            guard let issueData = issue else { return }
            self.imageView.setImage(url: issueData.categoryImage.getURL, placeholder: UIImage.image(type: .Placeholder_Gray))
            self.imageView.contentMode = .scaleAspectFill
            self.titleLbl.text = issueData.issueDescription
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

}
