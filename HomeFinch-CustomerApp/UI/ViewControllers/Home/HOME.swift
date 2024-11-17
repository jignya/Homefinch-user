//
//  HOME.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/11/20.
//

import UIKit

class HOME: UIViewController , UITextFieldDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var viewGreetings: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnCamera: UIButton!

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearchSub: UIView!

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!

    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var collcategory: UICollectionView!
    
    @IBOutlet weak var viewSucategory: UIView!
    @IBOutlet weak var viewProgress: UIView!
    
    @IBOutlet weak var viewDashedLine: UIView!
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var lblcompleteProfile: UILabel!
    @IBOutlet weak var lblProfilePercentage: UILabel!
    
    @IBOutlet weak var viewTopOffers: UIView!
    @IBOutlet weak var lblTopOffers: UILabel!
    @IBOutlet weak var collTopOffers: UICollectionView!
    
    @IBOutlet weak var viewTrendingIssue: UIView!
    @IBOutlet weak var lblToptrending: UILabel!
    @IBOutlet weak var collTrending: UICollectionView!
    
    @IBOutlet weak var tblSubCat: UITableView!
    @IBOutlet weak var contblSubCatHeight: NSLayoutConstraint!

    @IBOutlet weak var conScrlbottom: NSLayoutConstraint!

    @IBOutlet weak var stack1: UIStackView!

    
    // MARK: PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let trendingcatHandler = CategoriesWithImageCollectionHandler()
    private let offershandler = OffersCollectionHandler()
    private let subcatshandler = SubCategoriesTableHandler()
    
//    var triangleShape : TriangleView!
    var triangleShape = UIView()
    var bottomView = BottomServiceView()
    
    var arrCategory = [CategoryList]()
 
    var subcatId : Int!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CommonFunction.shared.addTabBar(self, tab: 0)
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        self.viewSucategory.isHidden = true
        
        triangleShape.frame = CGRect(x: 100 , y: 0, width: 30 , height: 16)
        let imageview = UIImageView(frame: triangleShape.bounds)
        imageview.image = UIImage(named: "trianle")
        triangleShape.addSubview(imageview)
        triangleShape.backgroundColor = .clear
        viewSucategory.addSubview(triangleShape)
        
        self.ImShSetLayout()
        
        
        if UserSettings.shared.arrPropertyList.count == 0
        {
            ServerRequest.shared.GetPropertyList(delegate: nil) { (response) in

                UserSettings.shared.arrPropertyList = response.data
                
            } failure: { (errorMsg) in
                
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.roboto(size: 18, weight: .Bold)]


    }
    
    
    func setData()
    {
        let dict = UserSettings.shared.getUserCredential()
//        self.lblUserName.text = String(format: "Hello, %@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
        
        self.lblUserName.text = String(format: "Hello, %@", dict["firstname"] as? String ?? "")

    }
    
    override func viewWillLayoutSubviews()
    {
        
        viewDashedLine.createDottedLine(width: 1, color: UserSettings.shared.ThemeBgGroupColor().cgColor)
        
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: viewSearchSub.frame.size.width + shadowSize,
                                                   height: viewSearchSub.frame.size.height + shadowSize))
        viewSearchSub.layer.masksToBounds = false
        viewSearchSub.layer.shadowColor = UIColor.init(hex: "#F1F2F8").cgColor
        viewSearchSub.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewSearchSub.layer.shadowOpacity = 0.5
        viewSearchSub.layer.shadowRadius = 3
        viewSearchSub.layer.shadowPath = shadowPath.cgPath

    }
    
    override func ImShSetLayout()
    {
        self.navigationItem.setNotificationBtn(target: self, action: #selector(btnNotificationTapped(_:)), tag: 0, animated: true)
        
        self.navigationItem.setwalletBtn(target: self, action: #selector(self.btnWalletTapped(_:)), amount: "AED 0.00", animated: true)


        self.navigationItem.leftBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        self.collcategory.setUp(delegate: mainCatsHandler, dataSource: mainCatsHandler, cellNibWithReuseId: MainCategoriesCell.className)
        self.collTrending.setUp(delegate: trendingcatHandler, dataSource: trendingcatHandler, cellNibWithReuseId: CategoriesWithImageCell.className)
        self.collTopOffers.setUp(delegate: offershandler, dataSource: offershandler, cellNibWithReuseId: OffersCell.className)
        
        
        self.tblSubCat.setUpTable(delegate: subcatshandler, dataSource: subcatshandler, cellNibWithReuseId: TitleCell.className)
        
        self.contblSubCatHeight.constant = 200
        self.tblSubCat.updateConstraintsIfNeeded()
        self.tblSubCat.layoutIfNeeded()
        
        
        /// Handling actions
        mainCatsHandler.didSelect =  { (category,indexpath) in
            
            if self.subcatId == category.id && self.subcatshandler.categoriesIssue.count > 0
            {
                self.viewSucategory.isHidden = !self.viewSucategory.isHidden
                self.subcatId = nil
                return
            }
            
            ServerRequest.shared.GetCategoryWiseIssueList(CatId: String(category.id), delegate: self) {
                (response) in
                
                    self.subcatId = category.id
                    self.subcatshandler.categoriesIssue = response.data
                    self.viewSucategory.isHidden = (self.subcatshandler.categoriesIssue.count == 0)
                    self.tblSubCat.isScrollEnabled = (self.subcatshandler.categoriesIssue.count > 4)
                    self.tblSubCat.reloadData()
                    if let myCell = self.collcategory.cellForItem(at: indexpath)
                    {
                        let width = self.view.frame.size.width / 4
                        let center = (width / 2) - 15
                        let myRect = myCell.frame
                        let originInRootView = self.collcategory.convert(myRect.origin, to: self.viewCategory)
                        self.triangleShape.frame = CGRect(x: originInRootView.x + center , y: 0, width: 30 , height: 16)
                    }
                
            } failure: { (errMsg) in
                
            }
        }
        
        mainCatsHandler.didScroll = {
            guard let indexpath = self.collcategory.indexPathsForSelectedItems else { return }
            
            if indexpath.count > 0
            {
                if let myCell = self.collcategory.cellForItem(at: indexpath[0])
                {
                    let width = self.view.frame.size.width / 4
                    let center = (width / 2) - 15
                    let myRect = myCell.frame
                    let originInRootView = self.collcategory.convert(myRect.origin, to: self.viewCategory)
                    self.triangleShape.frame = CGRect(x: originInRootView.x + center , y: 0, width: 30 , height: 16)
                }
            }
           
        }

        
        subcatshandler.didSelect = {(categoryIssue,indexpath) in
            
            self.viewSucategory.isHidden = true
            let detail = SERVICE_DETAIL.create(issueData: categoryIssue,strcomeFrom: "detail")
            self.navigationController?.pushViewController(detail, animated: false)

        }

        trendingcatHandler.didSelect = { (indexpath) in

            let trendingIssue = self.trendingcatHandler.issueList[indexpath.row]
            
            let categoryIssue = CategoryIssueList.init()
            categoryIssue.categoryId = trendingIssue.categoryId
            categoryIssue.id = trendingIssue.issueId
            categoryIssue.issueDescription = trendingIssue.issueDescription
            categoryIssue.service = Service.init()
            categoryIssue.service.serviceIdSap = trendingIssue.serviceIdSap
            
            self.viewSucategory.isHidden = true
            let detail = SERVICE_DETAIL.create(issueData: categoryIssue,strcomeFrom: "detail")
            self.navigationController?.pushViewController(detail, animated: false)

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {

        self.navigationController?.navigationBar.isHidden = false

        self.conScrlbottom.constant = 50
        self.getWalletbalance()

        let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
        
        concurrentQueue.async {
            self.getCategoryList()
        }
        concurrentQueue.async {
            self.getJobListData()
        }
        concurrentQueue.async {
            self.getTopTrendingList()
        }
        concurrentQueue.async {
            self.GetNotifcationList()
        }
    
        //----------------------------------------------- data set dynamically
        self.setData()
        
    }
    
    func bottomSheetShow(issueList : [Jobrequestitem])
    {
        let count = issueList.count
        if count > 0
        {
            self.conScrlbottom.constant = 50 + 80
            
            bottomView.show(String(format: "%d issue added", count), ButtonTitle: "ISSUE LIST") { (tag) in
                
                if let listnavvc = SERVICE_LIST.create(comeFrom: "list", issueList: issueList) {
                    listnavvc.modalPresentationStyle = .overCurrentContext
                    self.present(listnavvc, animated: true, completion: nil)
                }
            }
        }
        else
        {
            self.conScrlbottom.constant = 50
            bottomView.close()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bottomView.close()
    }
    
    
    //MARK: Button Methods

    @objc func btnNotificationTapped(_ sender : Any)
    {
        if let notification = NOTIFICATION_LIST.create() {
            self.present(notification, animated: true, completion: nil)
        }
    }

    @objc func btnWalletTapped(_ sender : Any)
    {
        print("tapped")
        let wallet = MYWALLET.create()
        self.navigationController?.pushViewController(wallet, animated: true)

    }

    @IBAction func btnCameraClick(_ sender: Any) {
        
        let selectionVc = self.storyboard?.instantiateViewController(withIdentifier: "CAMERAVIEW") as! CAMERAVIEW
        self.navigationController?.pushViewController(selectionVc, animated: false)

    }
    
    @IBAction func btnSearchClick(_ sender: Any) {
        
        let searchvc = SEARCH.create()
        self.navigationController?.pushViewController(searchvc, animated: true)

    }
    
    @IBAction func btnCompleteProfileClick(_ sender: Any) {
    
        let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "edit")
        self.navigationController?.pushViewController(signup, animated: true)

    }
    
    //MARK: WebServices Calling
    
    func getCategoryList()
    {
        ServerRequest.shared.GetCategoryList(delegate: self) { (Response) in
            self.mainCatsHandler.categories  =  Response.data
            self.collcategory.reloadData()
            
        } failure: { (errMsg) in }

    }
    
    func getTopTrendingList()
    {
        ServerRequest.shared.GetTopTrendingIssueList(delegate: self) { (Response) in
            
            self.trendingcatHandler.issueList  =  Response.data
            self.collTrending.reloadData()
            
        } failure: { (errMsg) in }

    }
    
    func getJobListData()
    {
        ServerRequest.shared.getJobListData(delegate: self) { response in
            
            if response.data.count > 0
            {
                self.bottomSheetShow(issueList: response.data)
            }
            
        } failure: { (errorMsg) in
            
        }

    }
    
    func getWalletbalance()
    {
        ServerRequest.shared.Getwalletbalance(dictPara: nil, delegate: nil) { (response) in
            
            DispatchQueue.main.async {
                print(response)
                UserSettings.shared.setwalletbalance(balance: response)
                self.navigationItem.setWalletBalance(stramount: response)
            }
            
        } failure: { (errorMsg) in
            UserSettings.shared.setwalletbalance(balance: "AED 0.00")
            self.navigationItem.setWalletBalance(stramount: "AED 0.00")

        }
        
    }

    func GetNotifcationList()
    {
        ServerRequest.shared.GetNotificationList(delegate: self) { (response) in

            let arrNot = response.list ?? []
            let arrFilter = arrNot.filter{$0.isRead == 1}
            self.navigationItem.setBadgeCount(value: arrFilter.count)
            
        } failure: { (errorMsg) in
        }
    }
    
}
extension HOME : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}


