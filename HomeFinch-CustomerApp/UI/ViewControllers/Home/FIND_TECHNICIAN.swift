//
//  FIND_TECHNICIAN.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 25/12/20.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps

class FIND_TECHNICIAN: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    static func create(strFrom:String = "") -> FIND_TECHNICIAN {
        let property = FIND_TECHNICIAN.instantiate(fromImShStoryboard: .Home)
        property.strcome = strFrom
        return property
    }
    
    var locationManager = CLLocationManager()


    @IBOutlet weak var Viewmap: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var GoogleMapView: GMSMapView!
    @IBOutlet weak var btncurrentLocation: UIButton!
    @IBOutlet weak var conMapBottom: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var rippleView: UIView!


    //MARK: outlet for details
    
    @IBOutlet weak var viewFindTechnician: UIView!
    @IBOutlet weak var lblFindTechnician: UILabel!

    
    @IBOutlet weak var viewTechnicianDetails: UIView!
    @IBOutlet weak var conviewTechnicianDetailsTop: NSLayoutConstraint!
    @IBOutlet weak var viewServiceDetails: UIView!

    @IBOutlet weak var viewTechnician: UIView!
    @IBOutlet private weak var SeparatorView: UIImageView!
    @IBOutlet weak var lblTechnicianName: UILabel!
    @IBOutlet weak var imgTechnician: UIImageView!

    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnViewDetails: UIButton!
    
    @IBOutlet weak var lblSelectService: UILabel!
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var conTblServiceHeight: NSLayoutConstraint!

    @IBOutlet weak var lblArrival: UILabel!
    @IBOutlet weak var conlblArrivalHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewBusyTechnician: UIView!
    @IBOutlet weak var lblBusyTechnician: UILabel!
    @IBOutlet weak var lblcallCustomer: UILabel!
    @IBOutlet weak var lblcallCustomerNumber: UILabel!
    @IBOutlet weak var btncallCustomer: UIButton!

    var bottomPadding : CGFloat = 0
    var topPadding : CGFloat = 0
    
    //MARK: variable for google Map
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0

    
    private let servicelisthandler = ServiceListTableHandler()

    var strcome : String!


    //MARK: view Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }

        self.conviewTechnicianDetailsTop.constant = self.view.frame.height - (self.topPadding + self.bottomPadding + 95)
        getCurrentLocation()

        setLabel()
        
        self.animateRippleEffect()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblArrival.text = "Arrived at your place in 2 hours"
        lblSelectService.text = "Select Services"
        
        lblBusyTechnician.text = "Seems our all technicians are busy!"
        lblcallCustomer.text = "Call Customer Care for More Help"

        
        btnCancel.setTitle("CANCEL", for: .normal)
        btnViewDetails.setTitle("VIEW DETAILS", for: .normal)

        self.ImShSetLayout()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        viewTechnicianDetails.roundCorners(corners: [.topRight, .topLeft], radius: 20)

        if let aSize = btnCancel.titleLabel?.font?.pointSize
        {
            btnCancel.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnViewDetails.titleLabel?.font?.pointSize
        {
            btnViewDetails.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
    
    }
    override func ImShSetLayout()
    {
        viewTechnician.backgroundColor = UIColor.white
        self.delaySec(7) {
            
            self.viewFindTechnician.isHidden = true
            self.setupPanGestures()
            self.conlblArrivalHeight.constant = 30
            self.rippleView.isHidden = true
        }
        
        self.viewServiceDetails.isHidden = true
        self.btnCancel.isHidden = true
        self.btnViewDetails.isHidden = true

        servicelisthandler.arrServices = CommonFunction.shared.getArrayDataFromTextFile(fileName: LocalFileName.service.rawValue)
        servicelisthandler.strComeFrom = "findtechinician"
        self.tblServices.estimatedRowHeight = 110
        self.tblServices.rowHeight = UITableView.automaticDimension
        
        self.tblServices.setUpTable(delegate: servicelisthandler, dataSource: servicelisthandler, cellNibWithReuseId: ServiceListCell.className)
        

        
        /// Handling actions
               
        servicelisthandler.didSelect = {(indexpath) in
            
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height
            self.tblServices.layoutIfNeeded()
            self.conTblServiceHeight.constant = self.tblServices.contentSize.height

            
        }
    }
    
    
    //MARK: animated ripple view
    func animateRippleEffect()
    {
        self.rippleView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [UIView.AnimationOptions.curveLinear, UIView.AnimationOptions.repeat],
            animations: {
                self.rippleView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { finished in
        })
    }

    
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {

        let animationDuration = 1.0
//        view.alpha = 1

        UIView.animate(withDuration: animationDuration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            view.alpha = 0
        }, completion: nil)

    }



    
    //MARK: Gesture Methods

    func setupPanGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)) )
        viewTechnician.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture : UIPanGestureRecognizer)
    {
        if gesture.isDown(circleView: viewTechnicianDetails)
        {
            self.viewTechnician.backgroundColor = UIColor.white
            self.btnCancel.isHidden = true
            self.btnViewDetails.isHidden = true
            self.viewServiceDetails.alpha = 1
            self.viewServiceDetails.isHidden = true


            UIView.animate(withDuration: 0.3) {
                self.conviewTechnicianDetailsTop.constant = self.view.frame.height - (self.topPadding + self.bottomPadding + 95)
                self.viewServiceDetails.alpha = 0
                self.viewTechnicianDetails.superview?.layoutIfNeeded()
            }

        }
        else
        {
            self.viewTechnician.backgroundColor = UserSettings.shared.ThemeBgGroupColor()

            self.btnCancel.isHidden = false
            self.btnViewDetails.isHidden = false
            self.viewServiceDetails.alpha = 0
            self.viewServiceDetails.isHidden = false


            UIView.animate(withDuration: 0.3) {
                self.conviewTechnicianDetailsTop.constant = 200 - self.topPadding
                self.viewServiceDetails.alpha = 1
                self.viewTechnicianDetails.superview?.layoutIfNeeded()
            }

        }
    }
    
    //MARK: Location Methods

    func getCurrentLocation()
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Check accuracy authorization
        if #available(iOS 14.0, *) {
            let accuracy = manager.accuracyAuthorization

            switch accuracy {
            case .fullAccuracy:
                print("Location accuracy is precise.")
            case .reducedAccuracy:
                print("Location accuracy is not precise.")
            @unknown default:
                fatalError()
            }
        } else {
            // Fallback on earlier versions
        }

        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            GoogleMapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            fatalError()
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
            // default -----------------------------------------
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            map.setRegion(region, animated: true) // default
            
            
            //--------------- Google Map -----------------------
            
            var zoomLevel : Float = 15.0
            
            if #available(iOS 14.0, *) {
                zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
            } else {
            }

            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: zoomLevel)
            
            GoogleMapView.settings.myLocationButton = false
            GoogleMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            GoogleMapView.isMyLocationEnabled = false
            GoogleMapView.delegate = self


            if GoogleMapView.isHidden {
                GoogleMapView.isHidden = false
                GoogleMapView.camera = camera
            } else {
                GoogleMapView.animate(to: camera)
            }
                    
            //--------------- Google Map -----------------------

            locationManager.stopUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
 

    //MARK: Button methods
    
    @IBAction func btncallCustomerClick(_ sender: Any) {
        
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCurrentLocationClick(_ sender: Any) {
        
        getCurrentLocation()
    }
    
    @IBAction func btncallClick(_ sender: Any) {
//        let customerPhn = self.jobRequestData.employeeData.phone.replacingOccurrences(of: " ", with: "")
//        if let url = URL(string: "tel://\(customerPhn)"), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }

    }
    
    @IBAction func btnMessageClick(_ sender: Any) {
        
//        let chat = CHATVIEW.create(title: "", jobData: self.jobRequestData)
//        self.navigationController?.pushViewController(chat, animated: true)

    }
    
    @IBAction func btnCancelClick(_ sender: Any) {

        AJAlertController.initialization1().showAlert(isBottomShow: true, aStrTitle: "Cancel Job Request", aStrMessage: "Are you sure want to cancel job request?", aCancelBtnTitle: "NO", aOtherBtnTitle: "YES", completion: { (index, title) in
            
            if index == 1
            {
//                let cancel = CANCEL_REQUEST.create()
//                self.present(cancel, animated: true, completion: nil)

            }
            
        })

    }
    
    @IBAction func btnViewDetailsClick(_ sender: Any) {
        
        self.view.endEditing(true)
        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let storyboard1 = UIStoryboard(name: "Jobs", bundle: nil)
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }

}
extension FIND_TECHNICIAN: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }

}
