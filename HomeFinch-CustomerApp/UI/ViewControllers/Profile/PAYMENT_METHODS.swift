//
//  PAYMENT_METHODS.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 05/01/21.
//

import UIKit

class PAYMENT_METHODS: UIViewController {
    
    static func createNormalFlow() -> PAYMENT_METHODS {
        let selection = PAYMENT_METHODS.instantiate(fromImShStoryboard: .Profile)
        return selection
    }
   
    //MARK:Outlets
    
    @IBOutlet weak var btnPayment: UIButton!

    @IBOutlet weak var tblCards: UITableView!

    
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var btnAddNewPayment: UIButton!
    
    @IBOutlet weak var conTblcardHeight: NSLayoutConstraint!

    @IBOutlet weak var viewEmpty: UIView!

    
    // MARK: PRIVATE

    private let cardhandler = CardListTableHandler()
    private var isNormalFlow : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
                
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = "Payment Methods"
        }
        self.setLabel()
        self.ImShSetLayout()
        
    }
    
    override func ImShSetLayout() {
        
        self.footerView.isHidden = true

        cardhandler.cardArr = CommonFunction.shared.getArrayDataFromTextFile(fileName: "card.txt")
        self.viewEmpty.isHidden = (cardhandler.cardArr.count > 0)
        
        //UserDefaults.standard.value(forKey: "cards") as? [[String : Any]] ?? []
        self.tblCards.setUpTable(delegate: cardhandler, dataSource: cardhandler, cellNibWithReuseId: CardCell.className)

        self.conTblcardHeight.constant =  CGFloat(cardhandler.cardArr.count * 100)
        self.tblCards.updateConstraintsIfNeeded()
        self.tblCards.layoutIfNeeded()
        
        /// Handling actions

        cardhandler.SelectMethodClick = {(indexpath , dict) in

        }
        
        cardhandler.deleteTapped = { (indexPath) in
            self.cardhandler.cardArr.remove(at: indexPath.row)
            self.tblCards.deleteRows(at: [indexPath], with: .left)
            self.tblCards.reloadData()
            self.conTblcardHeight.constant =  CGFloat(self.cardhandler.cardArr.count * 100)
            self.tblCards.updateConstraintsIfNeeded()
            self.tblCards.layoutIfNeeded()
        }

    }
    
    func setLabel()
    {
        btnPayment.setTitle("PAYMENT", for: .normal)

    }
    
    //MARK: Buttton Methods
    
    @IBAction func btnPaymentClick(_ sender: Any) {
       
    }
    
    @IBAction func btnNewPaymentClick(_ sender: Any) {
    }
    
    @IBAction func btnDownClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
