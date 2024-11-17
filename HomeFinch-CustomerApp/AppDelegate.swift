//
//  AppDelegate.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 03/11/20.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging
import FBSDKCoreKit
import GoogleSignIn
import GooglePlaces
import GoogleMaps
import BSImagePicker

import TwilioChatClient
import Amplitude_iOS


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate { //,PKPushRegistryDelegate
    
    
    var window: UIWindow?
    //    let notificationDelegate =  SampleNotificationDelegate()
    var isPush : Bool = false
    var isDeepLinking : Bool = false
    var isToken : Bool = false
    var storyboard : UIStoryboard!
    
    
    fileprivate var reach:Reachability!
    var isInternetConnected: Bool!
    var NoInternet : NoInternetVC! = nil
    
    var updatedPushToken: Data?
    var fcmPushToken: Data!
    var pushtoken: String!

    var receivedNotification: [AnyHashable : Any]?
    var chatClient: TwilioChatClient?

    var statusView : UIView!

    
    static var shared: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
                
        //      For navigation header and back button change
        DispatchQueue.main.async { () -> Void in
            let BarButtonItemAppearance = UIBarButtonItem.appearance()
//            BarButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
            BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -500, vertical: 0), for:UIBarMetrics.default)
        }
        
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: self.window?.frame.size.width ?? 100, height: self.window?.safeAreaInsets.top ?? 20))
        statusView.backgroundColor = UIColor.white
        window?.addSubview(statusView)

        //Amplitude Api key
        
        Amplitude.initializeApiKey("c1c3782cbdfec34cd62403f07dd35e93")
        
        
        // Google Api Key
        GMSPlacesClient.provideAPIKey(Google_place_API_key)
        GMSServices.provideAPIKey(Google_map_API_key)


        // Facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Google
  //      GIDSignIn.sharedInstance()?.clientID = UserSettings.google.clientId
        
        
        // Push Configuaration
        
        FirebaseApp.configure()
        
        requestNotificationAuthorization(application: application)
        configureNotification()
        
            
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                UserDefaults.standard.set(result.token, forKey: "fcmtoken")
                UserDefaults.standard.synchronize()
                
                self.fcmPushToken = Data(result.token.utf8)

                if self.isToken == false
                {
                    self.isToken = true
                    self.pushtoken = result.token
                    ServerRequest.shared.setDeviceToken(token: result.token)

                }
            }
        }
        
        IQKeyboardManager.shared.enable = true

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Internet availability observe
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reach)
        do
                {
                    self.reach = try Reachability()
                    try reach.startNotifier()
                    print("start reachability notifier")
                }
        catch
        {
            print("could not start reachability notifier")
        }
        
//        if(isInternetConnected == true)
//        {
//            removesubview()
//        }
        
        
//        application.setMinimumBackgroundFetchInterval(1800)

        
        return true
    }
    
    
    private func registerPushNotifications() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            [weak self] granted, error in
            
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *)
        {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            center.delegate = self
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("View", comment: ""), options: [.foreground])
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            let localCat =  UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
            UNUserNotificationCenter.current().setNotificationCategories([localCat, deafultCategory])
            
            Messaging.messaging().delegate = self
            Messaging.messaging().isAutoInitEnabled = true
        }
        else
        {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    fileprivate func requestNotificationAuthorization(application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
            registerRemoteNotifications()
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            registerRemoteNotifications()
        }
    }
    
    func registerRemoteNotifications() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
//        Messaging.messaging().apnsToken = deviceToken
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        print("fcm chat Token: \(self.fcmPushToken)")

        if let chatClient = chatClient, chatClient.user != nil {
                chatClient.register(withNotificationToken: self.fcmPushToken) { (result) in
                    if (!result.isSuccessful()) {
                        // try registration again or verify token
                    }
                    else
                    {
                        print("chat client token updated")
                    }
                }
            } else {
                updatedPushToken = deviceToken
            }
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to get token, error: %@", error)
        updatedPushToken = nil
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if !UserSettings.shared.isLoggedIn()
        {
           return
        }
        
//        let userInfo = response.notification.request.content.userInfo
        if let chatClient = chatClient, chatClient.user != nil {
            // If your reference to the Chat client exists and is initialized, send the notification to it
            
            if userInfo["channel_title"] != nil
            {
                self.isPush = true

                window = UIWindow(frame: UIScreen.main.bounds)
                let chat = CHATVIEW.create(title: "push",pushDict: userInfo as? [String:Any])
                let navigationVC = UINavigationController(rootViewController: chat)
                navigationVC.isNavigationBarHidden = true
                window?.rootViewController = navigationVC
                window?.makeKeyAndVisible()
                
                chatClient.handleNotification(userInfo) { (result) in
                    if (!result.isSuccessful()) {
                        // Handling of notification was not successful, retry?
                    }
                }

            }
            else
            {
                let notDict = userInfo as? [String:Any] ?? [:]
                print(notDict)
                if let jobId = notDict["redirect_url_id"] as? String , let status = notDict["sub_status"] as? String
                {
                    self.isPush = true

                    let JRstatus = Int(status) ?? 0
                    let JRId = Int(jobId)

                    if JRstatus <= 14
                    {
                        window = UIWindow(frame: UIScreen.main.bounds)
                        let detail = JOB_UPCOMING_DETAIL.create(data: nil, comeFrom: "push", jobId: JRId)
                        let navigationVC = UINavigationController(rootViewController: detail)
                        window?.rootViewController = navigationVC
                        window?.makeKeyAndVisible()
                    }
                    else
                    {
                        window = UIWindow(frame: UIScreen.main.bounds)
                        let detail = JOB_PAST_DETAIL.create(data: nil, comeFrom: "push", iscancelService: false, jobId: JRId)
                        let navigationVC = UINavigationController(rootViewController: detail)
                        window?.rootViewController = navigationVC
                        window?.makeKeyAndVisible()
                    }
                }
            }
            
        } else {
            // Store the notification for later handling
            receivedNotification = userInfo
            if userInfo["channel_title"] != nil
            {
                self.isPush = true

                window = UIWindow(frame: UIScreen.main.bounds)
                let chat = CHATVIEW.create(title: "push",pushDict: userInfo as? [String:Any])
                let navigationVC = UINavigationController(rootViewController: chat)
                window?.rootViewController = navigationVC
                window?.makeKeyAndVisible()
            }
            else
            {
                let notDict = userInfo as? [String:Any] ?? [:]
                print(notDict)
                if let jobId = notDict["redirect_url_id"] as? String , let status = notDict["sub_status"] as? String
                {
                    self.isPush = true

//                    let JRstatus = Int(status) ?? 0
                    let JRId = Int(jobId) ?? 0
                    
                    ServerRequest.shared.getJobRequestStatus(jobId: JRId, delegate: nil) { response in
                        
                        let dict = response["data"] as? [String:Any] ?? [:]
                        let JRstatus = dict["sub_status"] as? Int ?? 0
                        if JRstatus <= 14
                        {
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let detail = JOB_UPCOMING_DETAIL.create(data: nil, comeFrom: "push", jobId: JRId)
                            let navigationVC = UINavigationController(rootViewController: detail)
                            self.window?.rootViewController = navigationVC
                            self.window?.makeKeyAndVisible()
                        }
                        else
                        {
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let detail = JOB_PAST_DETAIL.create(data: nil, comeFrom: "push", iscancelService: false, jobId: JRId)
                            let navigationVC = UINavigationController(rootViewController: detail)
                            self.window?.rootViewController = navigationVC
                            self.window?.makeKeyAndVisible()
                        }

                        
                    } failure: { (errorMsg) in
                    }
                }
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    func chatClient(_ client: TwilioChatClient, notificationUpdatedBadgeCount badgeCount: UInt) {
        UIApplication.shared.applicationIconBadgeNumber = Int(badgeCount)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
           UIApplication.shared.ignoreSnapshotOnNextApplicationLaunch()
       }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        
//        let vc = UIApplication.topViewController()
//        print(vc)
//        
//        if statusView != nil
//        {
//            if vc is ImagePickerController
//            {
//                statusView.isHidden = true
//            }
//            else
//            {
//                statusView.isHidden = false
//            }
//        }
//        
//        
//        return .portrait
//    }
    
    //MARK: application life cycle
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        var task = UIBackgroundTaskIdentifier.invalid
        task = UIApplication.shared.beginBackgroundTask {
            UIApplication.shared.endBackgroundTask(task)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        fetchSomeData()
    }
    
    func fetchSomeData()
    {
       
    }
    
    //MARK: FireBase notification configuration
    //    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
    //        print(remoteMessage.appData)
    //    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcm token: \(fcmToken)")
        
        if self.isToken == false
        {
            self.fcmPushToken = Data((fcmToken ?? "").utf8)
            self.isToken = true
            self.pushtoken = fcmToken
            ServerRequest.shared.setDeviceToken(token: fcmToken ?? "")

        }
    }
    
    //MARK: Delegate methods for open app
     
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
     {
        if ApplicationDelegate.shared.application(app, open: url, options: options)
         {
             return true
         }
         else if GIDSignIn.sharedInstance.handle(url)
         {
             return true
         }
         else
         {//
             print(" open app ")
            return true
         }
         
     }
    
    //MARK: Reachability Check
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .unavailable {
            print("Reachable via ....")
            self.isInternetConnected = true
            self.removesubview()
        }
        else
        {
            print("Network not reachable")
            self.isInternetConnected = false
            
            self.storyboard = UIStoryboard(name: "Other", bundle: nil)
            self.NoInternet = self.storyboard.instantiateViewController(withIdentifier: "NoInternetVC") as? NoInternetVC
            NoInternet.view.tag = 2304
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.window = UIApplication.shared.keyWindow
                self.window?.addSubview(self.NoInternet.view)
                self.NoInternet.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.window?.addConstraints(
                    [NSLayoutConstraint(item: self.NoInternet.view as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal,toItem: self.window, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0),
                     NSLayoutConstraint(item:self.NoInternet.view as Any, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.window, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0.0),
                     NSLayoutConstraint(item:self.NoInternet.view as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.window, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0),
                     NSLayoutConstraint(item:self.NoInternet.view as Any, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.window, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0.0)])
            })
            
        }
    }
    
    func removesubview()
    {
        if( isInternetConnected == true)
        {
            let subviews: NSArray = (self.window?.subviews ?? []) as NSArray
            for id in subviews
            {
                let view:UIView   =  id as! UIView
                if(view.tag == 2304)
                {
                    DispatchQueue.main.async(execute: {
                        (id as AnyObject).removeFromSuperview()
                        print("Removed")
                    })
                    
                    let controller = UIApplication.topViewController()
                    if controller is SPLASH
                    {
                        let vc = controller as! SPLASH
                        vc.viewDidLoad()
                    }
                    
                }
            }
        }
    }
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
extension UIApplication {
   var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


