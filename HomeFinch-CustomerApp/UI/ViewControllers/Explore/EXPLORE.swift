//
//  EXPLORE.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/11/20.
//

import UIKit

class EXPLORE: UIViewController , UITextFieldDelegate , ASFSharedViewTransitionDataSource{
    
    //MARK: Outlets
    

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewSearchSub: UIView!

    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var collcategory: UICollectionView!
    
    @IBOutlet weak var viewSucategory: UIView!
    
    
    @IBOutlet weak var viewPopularServices: UIView!
    @IBOutlet weak var lblPopularServices: UILabel!
    @IBOutlet weak var collPopularServices: UICollectionView!
    @IBOutlet weak var ConcollPopularServicesHeight: NSLayoutConstraint!

    
    @IBOutlet weak var tblSubCat: UITableView!
    @IBOutlet weak var contblSubCatHeight: NSLayoutConstraint!

    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var lblNodata1: UILabel!

    @IBOutlet weak var stackList: UIStackView!

    
    // MARK: PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let popularhandler = PopularServiceCollectionHandler()
    private let subcatshandler = SubCategoriesTableHandler()
    
//    var triangleShape : TriangleView!
    var triangleShape = UIView()

    var CategoryId : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        CommonFunction.shared.addTabBar(self, tab: 2)
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        self.viewSucategory.isHidden = true
        
        triangleShape.frame = CGRect(x: 100 , y: 0, width: 30 , height: 16)
        let imageview = UIImageView(frame: triangleShape.bounds)
        imageview.image = UIImage(named: "trianle")
        triangleShape.addSubview(imageview)
        triangleShape.backgroundColor = .clear
        viewSucategory.addSubview(triangleShape)
        
        ASFSharedViewTransition.addWith(fromViewControllerClass: (EXPLORE.classForCoder() as! ASFSharedViewTransitionDataSource.Type)  , toViewControllerClass: EXPLORE_DETAIL.classForCoder() as? ASFSharedViewTransitionDataSource.Type , with: self.navigationController, withDuration: 0.2)
        
        
        ServerRequest.shared.GetCategoryList(delegate: self) { (Response) in
            
            self.mainCatsHandler.categories  =  Response.data
            self.collcategory.reloadData()
            
        } failure: { (errMsg) in
            
        }
        
        self.ImShSetLayout()
        
        self.GetPopularServiceList(catId: 0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.roboto(size: 18, weight: .Bold)]

        
    }
    
    func sharedView() -> UIView! {
        let cellview  = self.collPopularServices.cellForItem(at: (self.collPopularServices.indexPathsForSelectedItems?.first)!) as! PopularServiceCell
        let imgview = cellview.imgService
        return imgview
    }
    
    override func viewWillLayoutSubviews() {
        
//        stackList.roundCorners(corners: [.topRight, .topLeft], radius: 15)
        
        stackList.layer.cornerRadius = 15.0
        stackList.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

        self.GetNotifcationList()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.additionalSafeAreaInsets.top = 20
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    
    override func ImShSetLayout()
    {
        self.navigationItem.setNotificationBtn(target: self, action: #selector(btnNotificationTapped(_:)), tag: 0, animated: true)
        
        self.navigationItem.setwalletBtn(target: self, action: #selector(btnWalletTapped(_:)), amount:  UserSettings.shared.getwalletbalance() , animated: true)

        self.navigationItem.leftBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UserSettings.shared.ThemeGrayColor()
        
        self.navigationController?.navigationBar.hideBottomHairline()
        
        self.collcategory.setUp(delegate: mainCatsHandler, dataSource: mainCatsHandler, cellNibWithReuseId: MainCategoriesCell.className)
        
        self.collPopularServices.setUp(delegate: popularhandler, dataSource: popularhandler, cellNibWithReuseId: PopularServiceCell.className)
        
        
        self.tblSubCat.setUpTable(delegate: subcatshandler, dataSource: subcatshandler, cellNibWithReuseId: TitleCell.className)
        
        self.contblSubCatHeight.constant = 200
        self.tblSubCat.updateConstraintsIfNeeded()
        self.tblSubCat.layoutIfNeeded()
        
        
        /// Handling actions
        mainCatsHandler.didSelect =  { (category,indexpath) in
            
            self.popularhandler.arrService.removeAll()
            self.GetPopularServiceList(catId: category.id)
            
        }

        popularhandler.didSelect = { (indexpath) in

            let data = self.popularhandler.arrService[indexpath.item]
            let detail = EXPLORE_DETAIL.create(serviceData: data)
            self.navigationController?.pushViewController(detail, animated: true)

        }

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
    
    }
    
    //MARK: Webservice
    
    func GetPopularServiceList(catId : Int)
    {
        var dictpara = [String:String]()
        
        let strcatId = String(format: "%d", catId)
        
        dictpara = ["popular_service":"1","category_id":strcatId]
        
        ServerRequest.shared.GetServiceList(dictPara: dictpara, delegate: self) { (response) in
            
            self.popularhandler.arrService = response.data
            self.collPopularServices.reloadData()

            self.ConcollPopularServicesHeight.constant = self.collPopularServices.contentSize.height
            self.collPopularServices.updateConstraintsIfNeeded()
            self.collPopularServices.layoutIfNeeded()
            self.ConcollPopularServicesHeight.constant = self.collPopularServices.contentSize.height

            self.collPopularServices.isHidden = (self.popularhandler.arrService.count == 0)
            self.viewEmpty.isHidden = (self.popularhandler.arrService.count > 0)
            
            if self.popularhandler.arrService.count == 0 {
                self.ConcollPopularServicesHeight.constant = 200.0
            }

            
        } failure: { (errorMsg) in
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in }
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
extension EXPLORE : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
