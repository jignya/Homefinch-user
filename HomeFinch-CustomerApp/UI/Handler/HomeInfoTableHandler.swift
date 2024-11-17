//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class HomeInfoTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var SelectMethodClick: ((IndexPath,Bool) -> Void)? = nil  

    
    //MARK: Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutInfoCell.className, for: indexPath) as! AboutInfoCell
        
        if indexPath.row == 1
        {
            cell.lblTitle.text = "Which AC do you have?"
        }
        
        cell.collPartModel.reloadData()
      
        cell.selectionStyle = .none
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: Button Methods
//    @objc func BtnSelectClick(_ Sender:UIButton)
//    {
//        let btn = Sender
//        btn.isSelected = !btn.isSelected
//        let indexpath = IndexPath(item: btn.tag, section: 0)
//        self.SelectMethodClick?(indexpath, btn.isSelected)
//    }
}
