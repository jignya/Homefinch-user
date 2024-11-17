//
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class CardListTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var SelectMethodClick: ((IndexPath,[String:Any]) -> Void)? = nil
    var deleteTapped: ((IndexPath) -> Void)? = nil

    var cardArr = [[String:Any]]()

    var strcomeFrom : String = ""
    
    //MARK: Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.className, for: indexPath) as! CardCell
        
        cell.viewBg.borderWidth = 0

        let dict = cardArr[indexPath.row]
        cell.lblName.text = dict["name"] as? String
        cell.lblExpiry.text = "" //String(format: "Exp.\n%@", dict["year"] as? String ?? "")
        
        cell.lblCardNumber.text = dict["last4"] as? String ?? ""
        
        if dict["code"] as? String != "Visa"
        {
            cell.imgCardType.image = UIImage(named: "master")
        }
        else
        {
            cell.imgCardType.image = UIImage(named: "visa")
        }
        
        if dict["isSelected"] as? String == "1"
        {
            cell.viewBg.borderWidth = 1
        }
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if strcomeFrom == "selection"
        {
            var selectedDict = [String:Any]()
            
            for i in 0..<cardArr.count
            {
                var dict1 = cardArr[i]
                dict1["isSelected"] = "0"
                if i == indexPath.row
                {
                    if dict1["isSelected"] as? String == "1"
                    {
                        dict1["isSelected"] = "0"
                        selectedDict = [:]

                    }
                    else
                    {
                        dict1["isSelected"] = "1"
                        selectedDict = dict1
                    }
                }
                cardArr[i] = dict1
            }
            
            tableView.reloadData()
            self.SelectMethodClick?(indexPath,selectedDict)
        }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteTapped?(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
}
