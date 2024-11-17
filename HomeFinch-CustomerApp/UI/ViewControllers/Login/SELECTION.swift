//
//  SELECTION.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 23/11/20.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import GoogleSignIn
import AuthenticationServices


class SELECTION: UIViewController, ASAuthorizationControllerDelegate  
{
    @IBOutlet weak var imgHomeFinchLoo: UIImageView!
    @IBOutlet weak var imgPlaceholder: UIImageView!
    @IBOutlet weak var lblstarted: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var btnSignInMobile: UIButton!
    @IBOutlet weak var lblOrSignUp: UILabel!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!

    @IBOutlet weak var btnappleSignIn: UIButton!
    @IBOutlet weak var viewAppleButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var conMainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewSocialBtn: UIView!

    
    @IBOutlet weak var collSlidder: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: PRIVATE
    private let bannersHandler = SliderImagesCollectionHandler()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewSocialBtn.isHidden = true
        self.lblOrSignUp.isHidden = true
        
        btnappleSignIn.imageView?.contentMode = .scaleAspectFill
        
        bannersHandler.isStatic = true
        bannersHandler.images = ["slider1","slider2","slider3","slider4"]
        self.pageControl.numberOfPages = self.bannersHandler.images.count


        self.setLabel()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        
        var bottomPadding : CGFloat = 0
        var topPadding : CGFloat = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }
        
        conMainViewHeight.constant = self.view.frame.size.height - bottomPadding - topPadding
        
        if UserSettings.shared.socialLogin
        {
            self.viewSocialBtn.isHidden = false
            self.lblOrSignUp.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ImShSetLayout()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillLayoutSubviews() {
        
        if let aSize = btnGoogle.titleLabel?.font?.pointSize
        {
            btnGoogle.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnFacebook.titleLabel?.font?.pointSize
        {
            btnFacebook.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        if let aSize = btnSignInMobile.titleLabel?.font?.pointSize
        {
            btnSignInMobile.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
       
    }
    
    override func ImShSetLayout() {
        /// Registering cells
        self.collSlidder.setUp(delegate: bannersHandler, dataSource: bannersHandler, cellNibWithReuseId: ImageCell.className)
        
        
        /// Handling actions
        bannersHandler.didScroll = {
            guard let currIndex = self.collSlidder.getCurrentIndexpath() else { return }
            self.pageControl.currentPage = currIndex.row
        }
        bannersHandler.didSelect =  {
        }
    }
    
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblstarted.text = "Let's get started!"
        lblInfo.text = "" //Log in to get amazed with app features.
        btnSignInMobile.setTitle("Sign In with Mobile", for: .normal)
        lblOrSignUp.text = "Or Sign up with"
    }
    //MARK: button Methods
    
    
    @IBAction func btnSignInMobileClick(_ sender: Any) {
        
        let login = self.storyboard?.instantiateViewController(withIdentifier: "LOGIN") as! LOGIN
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    @IBAction func btnGoogleClick(_ sender: Any)
    {
        let signInConfig = GIDConfiguration.init(clientID: UserSettings.google.clientId)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let strName = user.profile?.name
            let arrName = strName?.components(separatedBy: " ") ?? []
            if arrName.count > 1
            {
                let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "")
                signup.strFisrtName = user.profile?.givenName
                signup.strLastName = user.profile?.familyName
                signup.strEmail = user.profile?.email
                self.navigationController?.pushViewController(signup, animated: true)

            }
            
        }
    }
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let err = error {
//            self.showAlert(title: UserSettings.shared.getLabelValue(Id: "230"), message: err.localizedDescription)
//        } else {
//
//            let strName = user.profile.name
//            let arrName = strName?.components(separatedBy: " ") ?? []
//            if arrName.count > 1
//            {
//                let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "")
//                signup.strFisrtName = user.profile.givenName
//                signup.strLastName = user.profile.familyName
//                signup.strEmail = user.profile.email
//                self.navigationController?.pushViewController(signup, animated: true)
//
//            }
//
//        }
//    }
    
    
    @IBAction func btnFacebookClick(_ sender: Any)
    {
        self.view.endEditing(true)

        let fbManager = LoginManager.init()
        fbManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let e = error {
                self.showAlert(title: UserSettings.shared.getLabelValue(Id: "230"), message: e.localizedDescription)
                return
            }
            // Fetch email and id
            GraphRequest.init(graphPath: "/me", parameters: ["fields": "email, id, name"]).start(completionHandler: { (conn, result, err) in
                if let e = error {
                    self.showAlert(title: UserSettings.shared.getLabelValue(Id: "230"), message: e.localizedDescription)
                    return
                }
                guard let r = result else { return }
                let resultJson = JSON.init(r)
                
                let strName = resultJson["name"].stringValue
                let arrName = strName.components(separatedBy: " ")
                fbManager.logOut()
                if arrName.count > 1
                {
                    let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "")
                    signup.strFisrtName = arrName[0]
                    signup.strLastName = arrName[1]
                    signup.strEmail = resultJson["email"].stringValue
                    self.navigationController?.pushViewController(signup, animated: true)
                }
                else
                {
                    let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "")
                    signup.strFisrtName = resultJson["name"].stringValue
                    signup.strLastName = resultJson["name"].stringValue
                    signup.strEmail = resultJson["email"].stringValue
                    self.navigationController?.pushViewController(signup, animated: true)

                }
            })
        }
    }
    //MARK: Sign in with apple ----------------------------------
    
    @IBAction func btnAppleClick(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()

        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let strEmail = String(format: "%@", email ?? "")
            print("User id is \(userIdentifier)")
            print("Full Name is \(String(describing: fullName))")
            print("Email id is \(String(describing: email))")
            
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
//                 switch credentialState {
//                    case .authorized:
//                        // The Apple ID credential is valid.
//                        print("valid")
//                        break
//                    case .revoked:
//                        // The Apple ID credential is revoked.
//                        print("revoked")
//
//                        break
//                 case .notFound: break
//                        // No credential was found, so show the sign-in UI.
//                    print("not found")
//
//                    default:
//                        break
//                 }
//            }
            
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedOperation = .operationLogout
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.performRequests()
            
            let signup = SIGNUP.create(strPhnNumber: "", isVerified: false, strCountryvalue: "", strFrom: "")
            signup.strFisrtName = fullName?.givenName ?? ""
            signup.strLastName = fullName?.familyName ?? ""
            signup.strEmail = strEmail
            self.navigationController?.pushViewController(signup, animated: true)
            
        }
    }
    

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    }
    
    //-----------------------------------------------

}
