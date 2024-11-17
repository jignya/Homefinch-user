//
//  MYWALLET.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 08/01/21.
//

import UIKit

class MYWALLET: UIViewController {
    
    static func create() -> MYWALLET {
        return MYWALLET.instantiate(fromImShStoryboard: .Profile)
    }

    
    @IBOutlet weak var lblMyBalance : UILabel!
    @IBOutlet weak var lblBalanceAmt: UILabel!
    @IBOutlet weak var lblReferEarn: UILabel!
    @IBOutlet weak var lblCompeleteProfile: UILabel!
    @IBOutlet weak var lblRedeemMode: UILabel!

    @IBOutlet weak var btnReferEarn: UIButton!
    @IBOutlet weak var btnCompeleteProfile: UIButton!
    @IBOutlet weak var btnRedeemMode: UIButton!
    
    @IBOutlet weak var viewMyBalance: UIView!
    @IBOutlet weak var viewReferEarn: UIView!
    @IBOutlet weak var viewCompeleteProfile: UIView!

    
    @IBOutlet weak var viewTopOffers: UIView!
    @IBOutlet weak var lblTopOffers: UILabel!
    @IBOutlet weak var collTopOffers: UICollectionView!
    
    
    @IBOutlet weak var lblTransaction: UILabel!
    @IBOutlet weak var tblTransaction: UITableView!
    @IBOutlet weak var conTblTransactionConstant: NSLayoutConstraint!

    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var lblNodata: UILabel!
    @IBOutlet weak var lblNodata1: UILabel!

    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!


    // MARK: PRIVATE

    private let offershandler = OffersCollectionHandler()
    private var arrTransaction = [TransactionList]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gloabally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "My Wallet"
        }
        
        setLabel()
        ImShSetLayout()
        
        self.lblBalanceAmt.text = UserSettings.shared.getwalletbalance()
        self.getWalletTransactionHistory()
        
    }
    
    override func viewWillLayoutSubviews()
    {
        self.viewMyBalance.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        self.viewReferEarn.roundCorners(corners: [.bottomLeft], radius: 10)
        self.viewCompeleteProfile.roundCorners(corners: [.bottomRight], radius: 10)
        
        stack1.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        stack2.roundCorners(corners: [.topRight, .topLeft], radius: 15)


    }
    
    override func ImShSetLayout()
    {

        self.collTopOffers.setUp(delegate: offershandler, dataSource: offershandler, cellNibWithReuseId: OffersCell.className)
        
        tblTransaction.register(delegate: self, dataSource: self, cellNibWithReuseId: TransactionsCell.className)

    }
    
    func setLabel()
    {
        lblMyBalance.text = "My Balance"
        lblTopOffers.text = "Top Offers"
        lblReferEarn.text = "Refer and Earn"
        lblCompeleteProfile.text = "Complete Your Profile & Earn"
        lblTransaction.text = "Transactions"
        lblRedeemMode.text = "Redeem Mode"
    }
    
    //MARK: Button Methods
    
    @IBAction func btnReferEarnClick(_ sender: Any)
    {
    }

    @IBAction func btnCompleteProfileClick(_ sender: Any)
    {
    }

    @IBAction func btnReddemCodeClick(_ sender: Any)
    {
        
    }
    
    //MARK: Webservice Methods
    
    func getWalletTransactionHistory()
    {
        ServerRequest.shared.GetwalletTransactionHistory(delegate: self) { response in
            
            self.arrTransaction = response.data
            self.tblTransaction.reloadData()
            self.tblTransaction.isHidden = (self.arrTransaction.count == 0)
            self.viewEmpty.isHidden = (self.arrTransaction.count > 0)

            self.conTblTransactionConstant.constant = CGFloat.greatestFiniteMagnitude
            self.tblTransaction.updateConstraintsIfNeeded()
            self.tblTransaction.layoutIfNeeded()
            self.conTblTransactionConstant.constant = self.tblTransaction.contentSize.height

            
        } failure: { (errorMsg) in
            
        }

    }

}
extension MYWALLET : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsCell.className, for: indexPath) as! TransactionsCell
        
        let dict = arrTransaction[indexPath.row]
        cell.lblDate.text = ""

        let date = dict.date ?? ""
        let dateF = DateFormatter()
        
        dateF.dateFormat = "yyyy-MM-dd"
        if dateF.date(from: date) != nil
        {
            let date1 = dateF.date(from: date)!
            dateF.dateFormat = "EEE, MMM d, yyyy"
            let date2 = dateF.string(from: date1)
            cell.lblDate.text = date2
        }
        
        cell.layoutUpdate()
        cell.arrList = dict.stub
        cell.tblList.reloadData()
        
        tblTransaction.updateConstraintsIfNeeded()
        tblTransaction.layoutIfNeeded()
        conTblTransactionConstant.constant = tblTransaction.contentSize.height

        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let dict = arrTransaction[indexPath.row]
        if dict.stub.count > 0
        {
            let height = dict.stub.count * 75
            return CGFloat(height + 50)
        }

        return 0
    }
}
extension MYWALLET : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
