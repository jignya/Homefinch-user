//
//  SEARCH.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 03/11/20.


import UIKit
import CoreData

class SEARCH: UIViewController, UISearchBarDelegate
{

    static func create(strComeFrom : String = "",delegate : selectIssueDelegate? = nil) -> SEARCH {
        
        let search = SEARCH.instantiate(fromImShStoryboard: .Home)
        search.comeFrom = strComeFrom
        search.delegate = delegate
        return search
    }
    
    // MARK: OUTLETS
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var viewSearch: UIView!

    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var lblNodata1: UILabel!

    var isSearchTapped : Bool = false
    var search:String=""
    var comeFrom : String!

    
    // MARK: PRIVATE
    
    var categoriesIssue = [CategoryIssueList]()
    var categoriesIssueTemp = [CategoryIssueList]()
    
    // MARK: REQUIRED
    weak var delegate: selectIssueDelegate? = nil


   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = ""

        ImShSetLayout()
        searchTableView.isHidden = false
        
        viewEmpty.isHidden = true
        
        ServerRequest.shared.GetAllIssueList(delegate: self) { (response) in
            
            self.categoriesIssue = response.data
            self.categoriesIssueTemp = response.data
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)

            
        } failure: { (errMsg) in
            
            self.categoriesIssue = []
            self.categoriesIssueTemp = []
            self.searchTableView.reloadData()
            self.viewEmpty.isHidden = (self.categoriesIssue.count == 0)
            self.searchTableView.isHidden = (self.categoriesIssue.count > 0)
        }

        txtSearch.becomeFirstResponder()

    }
    
    func setLabel()
    {
        txtSearch.placeholder = "Search issue"
    }

    override func viewWillAppear(_ animated: Bool) {
        // Setting search bar
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.navigationItem.hidesBackButton = true
        delaySec(1.0) {
            self.searchTableView.reloadData()
//            self.fetchrecentSearchProduct()
        }
        ImShUpdateLabels()

    }
    
    override func viewWillLayoutSubviews()
    {
        // shadow effect search view
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: viewSearch.frame.size.width + shadowSize,
                                                   height: viewSearch.frame.size.height + shadowSize))
        viewSearch.layer.masksToBounds = false
        viewSearch.layer.shadowColor = UIColor.init(hex: "#F1F2F8").cgColor
        viewSearch.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSearch.layer.shadowOpacity = 0.5
        viewSearch.layer.shadowRadius = 3
        viewSearch.layer.shadowPath = shadowPath.cgPath
      
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        // Removing search bar
        self.navigationItem.titleView = nil
        self.navigationController?.navigationBar.hideBottomHairline()
    }
    
    override func ImShSetLayout() {
        // Register cells
        self.searchTableView.register(UINib.init(nibName: SearchProductCell.className, bundle: nil), forCellReuseIdentifier: SearchProductCell.className)
    }
    
    override func ImShUpdateLabels() {
//        self.navigationController?.navigationBar.topItem?.title = UserSettings.shared.getLabelValue(Id: "162")
    }

    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let query = searchBar.text!
        self.searchQuery(query: query)
    }
    
    
    // MARK: HELPERS
    fileprivate func searchQuery(query: String) {
        
        let arrFilter = categoriesIssueTemp.filter{$0.issueDescription == query}
        if arrFilter.count > 0
        {
            self.categoriesIssue = arrFilter
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)

        }
        else
        {
            self.categoriesIssue = []
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)
        }
        
        
//        ServerRequest.shared.search(query: query, delegate: self, completion: { (products) in
//            self.searchResults = products
//            if self.searchResults.count > 0
//            {
//               self.isSearchTapped  = true
//            }
//            self.searchTableView.reloadData()
//            self.searchTableView.isHidden = false
//
//        }) { (errorMsg) in
//            self.showAlert(title: UserSettings.shared.getLabelValue(Id: "230"), message: errorMsg)
//        }
    }
    
    // MARK: ACTION HANDLERS
    fileprivate func handleDidSelect(at indexPath: IndexPath)
    {
        if comeFrom == "detail"
        {
            self.delegate?.issueSelected(dict: categoriesIssue[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let detail = SERVICE_DETAIL.create(issueData: categoriesIssue[indexPath.row],strcomeFrom: "detail")
            self.navigationController?.pushViewController(detail, animated: false)
        }
    }
    
    //MARK: Button methods
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)

    }
    
}

// MARK: UITABLEVIEW DELEGATE, DATASOURCE
extension SEARCH: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string.isEmpty
        {
            search = String(search.dropLast())
        }
        else
        {
            search=textField.text!+string
        }

        print(search)
        
        let arrFilter = categoriesIssueTemp.filter{$0.issueDescription.localizedCaseInsensitiveContains(search)}
        if arrFilter.count > 0
        {
            self.categoriesIssue = arrFilter
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)

        }
        else
        {
            self.categoriesIssue = []
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)
        }
        
        if search.isEmpty
        {
            self.categoriesIssue = categoriesIssueTemp
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)
            self.txtSearch.text = ""
            textField.resignFirstResponder()

        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.text?.count == 0
        {
            self.categoriesIssue = categoriesIssueTemp
            self.searchTableView.reloadData()
            self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
            self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.categoriesIssue = categoriesIssueTemp
        self.searchTableView.reloadData()
        self.searchTableView.isHidden = (self.categoriesIssue.count == 0)
        self.viewEmpty.isHidden = (self.categoriesIssue.count > 0)
        textField.resignFirstResponder()
        return true

    }

}

// MARK: UITABLEVIEW DELEGATE, DATASOURCE
extension SEARCH: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
       return categoriesIssue.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchProductCell.className, for: indexPath) as! SearchProductCell
        let dict = categoriesIssue[indexPath.row]
        cell.titleLbl.text = dict.issueDescription
        cell.thumb.setImage(url: dict.image.getURL, placeholder: UIImage.image(type: .Placeholder_Gray))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.delaySec(0) {
            self.handleDidSelect(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
extension SEARCH : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
protocol selectIssueDelegate: class
{
    func issueSelected(dict:CategoryIssueList)
}

