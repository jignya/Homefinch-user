//  NotificationViewController.swift
//  Content



import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
                                                                                        
    @IBOutlet var label: UILabel?
    @IBOutlet weak var imgShow: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification)
    {
        if notification.request.content.title != ""
        {
            let yourAttributes = [
                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]

                   let yourOtherAttributes = [
                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]

                   let partOne = NSMutableAttributedString(string: String(format: "%@\n", notification.request.content.title), attributes: yourAttributes)
                   let partTwo = NSMutableAttributedString(string: notification.request.content.body, attributes: yourOtherAttributes)

                   let combination = NSMutableAttributedString()

                   combination.append(partOne)
                   combination.append(partTwo)
                   
                   self.label?.attributedText = combination
        }
        else
        {
            self.label?.text = notification.request.content.body
        }
        
       
        let content = notification.request.content
                
        print("new cutom notification data :\(content)")
        if let urlImageString = content.userInfo["urlImageString"] as? String {
            if let url = URL(string: urlImageString) {
                
                imgShow.isHidden = false
                print("new cutom notification data :\(content)")
                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                    if let _ = error {
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.imgShow.image = UIImage(data: data)
                    }
                }
            }
            else
            {
                imgShow.isHidden = true
            }
        }
        else
        {
            imgShow.isHidden = true
        }
    }
}
extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
