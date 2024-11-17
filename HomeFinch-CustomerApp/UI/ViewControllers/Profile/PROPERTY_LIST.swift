//
//  PROPERTY_LIST.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 14/12/20.
//

import UIKit

class PROPERTY_LIST: UIViewController , UITableViewDelegate, UITableViewDataSource,ASFSharedViewTransitionDataSource {
    
    static func create(strComeFrom : String = "",delegate : selectPropertyDelegate? = nil) -> PROPERTY_LIST {
        let list = PROPERTY_LIST.instantiate(fromImShStoryboard: .Profile)
        list.comeFrom = strComeFrom
        list.delegate = delegate
        return list
    }
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var lblNodata1: UILabel!

    // MARK: REQUIRED
    weak var delegate: selectPropertyDelegate? = nil

    
    var comeFrom : String!
    var arrList : [PropertyList] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
                
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Properties"
        }
        
        
        tblList.estimatedRowHeight = 100
        tblList.rowHeight = UITableView.automaticDimension
        
        tblList.register(delegate: self, dataSource: self, cellNibWithReuseId: NotificationCell.className)
        setLabel()
        
        ASFSharedViewTransition.addWith(fromViewControllerClass: (PROPERTY_LIST.classForCoder() as! ASFSharedViewTransitionDataSource.Type)  , toViewControllerClass: PROPERTY_DETAIL.classForCoder() as? ASFSharedViewTransitionDataSource.Type , with: self.navigationController, withDuration: 0.2)
        
        
        self.fetchPropertyData()
        
    }
    
    func sharedView() -> UIView! {
        let cellview  = self.tblList.cellForRow(at: (self.tblList.indexPathsForSelectedRows?.first)!) as! NotificationCell
        let bgview = cellview.viewBg
        return bgview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.hideBottomHairline()
    }
 
    func setLabel()
    {
    }
    
    //MARK: Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        cell.viewTitle.isHidden = false
        cell.viewBg.layer.borderWidth = 0.7
        cell.viewBg.layer.borderColor = UserSettings.shared.ThemeBorderColor().cgColor
        
        cell.lblName.textColor = UserSettings.shared.ThemeGrayColor()
        
        let dictInfo = self.arrList[indexPath.row]
      
        cell.lblTitle.text = dictInfo.propertyName
        cell.lblName.text = dictInfo.fullAddress
        
        if dictInfo.propertyType == 1  //villa
        {
            cell.imgVilla.image = UIImage(named: "Villa")
        }
        else
        {
            cell.imgVilla.image = UIImage(named: "Appartment")
        }
        
        cell.imgVilla.tintColor = UserSettings.shared.themeColor2()
        
                
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if comeFrom == "profile"
        {
            let dict = self.arrList[indexPath.row]
            let detail = PROPERTY_DETAIL.create(propertyData: dict)
            self.navigationController?.pushViewController(detail, animated: false)
        }
        else if comeFrom == "list"
        {
            let dict = self.arrList[indexPath.row]
            self.delegate?.dataSelected(dict: dict)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    //MARK: Button Methods
   
    @IBAction func btnBackClick(_ sender: Any) {

        self.navigationController?.pop()
    }
   
    @IBAction func btnAddClick(_ sender: Any) {

        let property = ADDPROPERTYMAP.create(strFrom: "change")
        self.navigationController?.pushViewController(property, animated: true)
    }
    
    //MARK: Webservices
    func fetchPropertyData()
    {
        ServerRequest.shared.GetPropertyList(delegate: self) { (result) in
            
            if result.data != nil
            {
                UserSettings.shared.arrPropertyList = result.data
                self.arrList = result.data
                
                if self.arrList.count > 0
                {
                    self.tblList.isHidden = false
                    self.viewEmpty.isHidden = true
                    self.tblList.reloadData()
                }
                else
                {
                    self.tblList.isHidden = true
                    self.viewEmpty.isHidden = false

                }
                
            }
            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
        }

    }
    

}
extension PROPERTY_LIST : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
protocol selectPropertyDelegate: class
{
    func dataSelected(dict:PropertyList)
}
