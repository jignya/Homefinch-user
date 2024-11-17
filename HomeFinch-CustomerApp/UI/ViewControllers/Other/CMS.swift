//
//  CMS.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 26/11/20.
//

import UIKit
import WebKit

class CMS: UIViewController , UITextViewDelegate, WKUIDelegate , WKNavigationDelegate {
    
    static func create(title: String?) -> CMS {
        let cmsvc = CMS.instantiate(fromImShStoryboard: .Other)
        cmsvc.strTitle = title
        return cmsvc
    }
    
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    var strTitle : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        activity.startAnimating()
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = self.strTitle
        }
        
        if strTitle == "Privacy Policy"
        {
            if let dataUrl =  URL(string: UserSettings.shared.arrPages[0].name)
            {
                self.loadDefaultURL(url: dataUrl)
            }
        }
        else if strTitle == "Help"
        {
            if let dataUrl =  URL(string: UserSettings.shared.arrPages[2].name)
            {
                self.loadDefaultURL(url: dataUrl)
            }
        }
        else if strTitle == "Cancellation Policy" || strTitle == "Refund & Cancellation Policy"
        {
            if let dataUrl =  URL(string: UserSettings.shared.arrPages[3].name)
            {
                self.loadDefaultURL(url: dataUrl)
            }
        }
        else if strTitle == "About Us"
        {
            if let dataUrl =  URL(string: "https://www.homefinch.com")
            {
                self.loadDefaultURL(url: dataUrl)
            }
        }
        else
        {
            if let dataUrl =  URL(string: UserSettings.shared.arrPages[1].name)
            {
                self.loadDefaultURL(url: dataUrl)
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        activity.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
    }
    
    // MARK: HELPERS
    func loadDefaultURL(url: URL) {
        webView.load(URLRequest.init(url: url))
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let yourBackImage = UIImage(named: "Back")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
    }

}

