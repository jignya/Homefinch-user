//
//  SearchProductCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class SearchProductCell: UITableViewCell {

    // MARK: OUTLETS
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
//    var myProductIs: HomeNewproduct? {
//        didSet {
//            guard let product = myProductIs else { return }
//            self.thumb.setImage(url: product.imageUrl.getURL, placeholder: UIImage.image(type: .image_placeholder))
//            titleLbl.text = product.name
//            priceLbl.text = product.getPriceFormatted()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
