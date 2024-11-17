//
//  CHATVIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 19/01/21.
//

import UIKit

class CHATVIEW: UIViewController {
    
    static func create(title: String? = "",jobData:JobIssueList? = nil,pushDict:[String:Any]? = nil) -> CHATVIEW {
        let chat =  CHATVIEW.instantiate(fromImShStoryboard: .Other)
        chat.jobrequestData = jobData
        chat.pushDict = pushDict
        chat.comeFrom = title
        return chat
    }

    
    // Important - this identity would be assigned by your app, for
    // instance after a user logs in
    var identity = "Jignya_new"

    // Convenience class to manage interactions with Twilio Chat
    var chatManager = QuickstartChatManager()

    // MARK: UI controls
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSendMessage: UIView!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnsend: UIButton!

    var jobrequestData: JobIssueList!
    var pushDict: [String:Any]!
    var comeFrom: String!


    //MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()

        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        chatManager.delegate = self
        
        let dict = UserSettings.shared.getUserCredential()
        if !dict.isEmpty
        {
            self.identity = String(format: "%@ %@", dict["firstname"] as? String ?? "" ,dict["lastname"] as? String ?? "")
        }
        
        if comeFrom == "push"
        {
            chatManager.uniqueChannelName = pushDict["channel_title"] as? String ?? "General"
            chatManager.friendlyChannelName = pushDict["channel_title"] as? String ?? "General"
        }
        else
        {
            if jobrequestData != nil
            {
//            self.identity = jobrequestData.customerName
                chatManager.uniqueChannelName = String(format: "%d-%d-%d", jobrequestData.id, jobrequestData.customerId,jobrequestData.employeeId)
                chatManager.friendlyChannelName = String(format: "%d-%d-%d", jobrequestData.id, jobrequestData.customerId,jobrequestData.employeeId)
            }

        }
       

        // Listen for keyboard events and animate text field as necessary
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        // Set up UI controls
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 66.0
        self.tableView.separatorStyle = .none
        
        txtMessage.placeholder1 = "Text message"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        
            DispatchQueue.main.async{
                self.navigationController?.navigationBar.topItem?.title = String(format: "Job %d", self.jobrequestData.id)
            }
        
        
        let cancelbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cancelbutton.setImage(UIImage(named: "Back"), for: .normal)
        cancelbutton.imageView?.contentMode = .scaleAspectFit
        if UserDefaults.standard.bool(forKey: "isArabic") == true
        {
            cancelbutton.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        cancelbutton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        cancelbutton.sizeToFit()
        let leftBarButton = UIBarButtonItem(customView: cancelbutton)
        self.navigationItem.setLeftBarButton(leftBarButton, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if comeFrom == "push"
        {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UserSettings.shared.themeColor2()

        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: true)

    }
    
    @objc func cancelTapped()
    {
        if comeFrom == "push"
        {
            let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier:"HOME") as!  HOME
            self.navigationController?.pushViewController(view, animated: false)

        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        login()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        chatManager.shutdown()
    }
    
    override func viewDidLayoutSubviews() {
        txtMessage.centerVertically()
    }

    
    // MARK: Login - Token generated

    func login() {
        
        ImShSwiftLoader.shared.show("Please wait...".localized)

        chatManager.login(self.identity) { (success) in
            ImShSwiftLoader.shared.hide()
            DispatchQueue.main.async {
                if success {
                    print("Logged in")
                } else {
//                    self.navigationItem.prompt = "Unable to login"
                    let msg = "Unable to login"
                    self.displayErrorMessage(msg)
                }
            }
        }
    }

    // MARK: Keyboard Dodging Logic

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
            as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.bottomConstraint.constant = -(keyboardRect.height)
                self.viewSendMessage.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardDidShow(notification: NSNotification) {
        scrollToBottomMessage()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.bottomConstraint.constant = 0
            self.viewSendMessage.layoutIfNeeded()
        })
    }

    // MARK: UI Logic

    // Dismiss keyboard if container view is tapped
    @IBAction func viewTapped(_ sender: Any) {
//        self.txtMessage.resignFirstResponder()
    }
    
    // MARK: - All button Actions
    @IBAction func btnsendTappedClick(_ sender: Any) {
        self.view.endEditing(true)
        
        if !txtMessage.text!.isEmpty
        {
            chatManager.sendMessage(txtMessage.text!, completion: { (result, _) in
                if result.isSuccessful() {
                    self.txtMessage.text = ""
                    self.txtMessage.resignFirstResponder()
                } else {
                    self.displayErrorMessage("Unable to send message")
                }
            })
        }
    }

    private func scrollToBottomMessage() {
        if chatManager.messages.count == 0 {
            return
        }
        let bottomMessageIndex = IndexPath(row: chatManager.messages.count - 1,
                                           section: 0)
        tableView.scrollToRow(at: bottomMessageIndex, at: .bottom, animated: true)
    }

    private func displayErrorMessage(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: UITextField Delegate
extension CHATVIEW: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        chatManager.sendMessage(textField.text!, completion: { (result, _) in
//            if result.isSuccessful() {
//                textField.text = ""
//                textField.resignFirstResponder()
//            } else {
//                self.displayErrorMessage("Unable to send message")
//            }
//        })
        return true
    }
}


// MARK: UITableViewDataSource Delegate
extension CHATVIEW: UITableViewDataSource , UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Return number of rows in the table
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return chatManager.messages.count
    }

    // Create table view rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        
        let message = chatManager.messages[indexPath.row]
//        print("%%%%%%%% \(message.member)")
        print("Author %% \(message.author)")
        print("Identity %% \(self.identity)")
        print("message %% \(message.body)")

        if message.author == self.identity
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Chatcell",
                                                     for: indexPath) as! Chatcell
            
            // Set table cell values
            cell.lblMsg?.text = message.body  //message.author
            cell.lblDate?.text = ""
            if let date = message.dateCreatedAsDate
            {
               let datef = DateFormatter()
                datef.dateFormat = "dd/MM/yyyy HH:mm"
                cell.lblDate.text = datef.string(from: date)
            }
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Chatcell1",
                                                     for: indexPath) as! Chatcell
            
            // Set table cell values
            cell.lblMsg?.text = message.body  //message.author
            cell.lblDate?.text = ""
            if let date = message.dateCreatedAsDate
            {
                let datef = DateFormatter()
                 datef.dateFormat = "dd/MM/yyyy HH:mm"
                 cell.lblDate.text = datef.string(from: date)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: QuickstartChatManagerDelegate
extension CHATVIEW: QuickstartChatManagerDelegate {
    func reloadMessages() {
        self.tableView.reloadData()
    }

    // Scroll to bottom of table view for messages
    func receivedNewMessage() {
        scrollToBottomMessage()
    }
}
extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
