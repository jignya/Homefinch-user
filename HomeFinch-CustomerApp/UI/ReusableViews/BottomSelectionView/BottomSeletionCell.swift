//
//  BottomSeletionCell.swift
//  Omahat
//
//  Created by Hightech on 29/05/20.
//  Copyright © 2020 ImSh. All rights reserved.
//

import UIKit

class BottomSeletionCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
