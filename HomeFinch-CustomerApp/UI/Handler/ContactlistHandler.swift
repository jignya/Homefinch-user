//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class ContactlistHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var SelectClick: ((IndexPath,Bool) -> Void)? = nil

    var arrList = [contactlist]()
    
    //MARK: Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.className, for: indexPath) as! ContactListCell
       
        cell.lblName.text = arrList[indexPath.row].fullName
        cell.lblContact.text = arrList[indexPath.row].mobile
        cell.btnSelect.isSelected = false
        
        if arrList[indexPath.row].isSelected == 1
        {
            cell.btnSelect.isSelected = true
        }
        
        cell.btnSelect.tag = indexPath.item
        cell.btnSelect.addTarget(self, action: #selector(BtnSelectClick(_:)), for: .touchUpInside)

      
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 // UITableView.automaticDimension
    }
    
    //MARK: Button Methods
    @objc func BtnSelectClick(_ Sender:UIButton)
    {
        let btn = Sender
        btn.isSelected = !btn.isSelected
        
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.SelectClick?(indexpath, btn.isSelected)
    }
}
