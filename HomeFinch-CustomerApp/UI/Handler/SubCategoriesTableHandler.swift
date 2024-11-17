//
//  CategoriesWithImageCollectionHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

// MARK: UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SubCategoriesTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var categoriesIssue = [CategoryIssueList]()
    var didSelect: ((CategoryIssueList,IndexPath) -> Void)? = nil
    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesIssue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.className, for: indexPath) as! TitleCell
        
        let dict = categoriesIssue[indexPath.row]
        cell.lblName.text = dict.issueDescription
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = categoriesIssue[indexPath.row]
        didSelect?(dict,indexPath)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
