//
//  AboutInfoCell.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 07/01/21.
//

import UIKit

class AboutInfoCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collPartModel: UICollectionView!

    var SelectServiceClick: ((IndexPath,Bool) -> Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
        
        collPartModel.setUp(delegate: self, dataSource: self , cellNibWithReuseId: "PartCell1")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartCell1", for: indexPath) as! PartCell
        
        cell.btnSelect.isHidden = true
        cell.lblPart.text = "Ariston"
        
        if indexPath.row == 1
        {
            cell.lblPart.text = "Panasonic"
        }
        
        cell.btnSelect.tag = indexPath.row
        cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let cell = collectionView.cellForItem(at: indexPath) as! PartCell
        cell.btnSelect.isHidden = false
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let font = UIFont.roboto(size: 12, weight: .Regular)
        let width = "Panasonic".widthWithConstrainedHeight(height: 40, font: font!)
        return CGSize.init(width: width + 50, height: 45)
    }
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        let indexpath = IndexPath(item: btn.tag, section: 0)
        
        guard let cell = collPartModel.cellForItem(at: indexpath) as? PartCell else { return }
        cell.btnSelect.isHidden = true
//        self.SelectServiceClick?(indexpath, btn.isSelected)
    }
    
}
