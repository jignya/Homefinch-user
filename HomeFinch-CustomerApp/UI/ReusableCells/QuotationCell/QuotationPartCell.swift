//
//  QuotationPartCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit

class QuotationPartCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var stackBorderView: UIStackView!

    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblPartServiceName: UILabel!
    @IBOutlet weak var lblPartServiceAmount: UILabel!

    @IBOutlet weak var collPartModel: UICollectionView!
    @IBOutlet weak var viewRecommend: UIView!
    @IBOutlet weak var lblRecommend: UILabel!
    
    @IBOutlet weak var viewPartModel: UIView!

    @IBOutlet weak var tblPartDetail: UITableView!
    @IBOutlet weak var contblPartDetailHeight: NSLayoutConstraint!


    let partHandler = PartDetailTableHandler()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        // brand collection view
        collPartModel.setUp(delegate: self, dataSource: self , cellNibWithReuseId: PartCell.className)
        
        // part tableview
        self.tblPartDetail.setUpTable(delegate: partHandler, dataSource: partHandler, cellNibWithReuseId: SelectedPartCell.className)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartCell.className, for: indexPath) as! PartCell
        
        cell.lblWarranty.isHidden = true
        cell.imgSelect.isHidden = true
        cell.viewBorder.isHidden = true
        cell.btnSelect.isHidden = true


        if indexPath.item == 0
        {
            cell.lblWarranty.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let cell = collectionView.cellForItem(at: indexPath) as! PartCell
        cell.imgSelect.isHidden = false
        cell.lblWarranty.isHidden = false
        cell.viewBorder.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PartCell else { return }
        cell.imgSelect.isHidden = true
        cell.lblWarranty.isHidden = true
        cell.viewBorder.isHidden = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height
        let font = UIFont.roboto(size: 12, weight: .Regular)
        let width = "Samsung".widthWithConstrainedHeight(height: height, font: font!)
        return CGSize.init(width: width + 50, height: height)
    }

    
}
