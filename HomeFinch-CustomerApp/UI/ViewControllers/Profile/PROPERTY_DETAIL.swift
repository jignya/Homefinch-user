//
//  ADDPROPERTYMAP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 30/11/20.
//

import UIKit
import PullUpController
import CoreLocation
import MapKit
import SkyFloatingLabelTextField
import GoogleMaps


class PROPERTY_DETAIL: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, ASFSharedViewTransitionDataSource {

    static func create(propertyData : PropertyList) -> PROPERTY_DETAIL {
        let property = PROPERTY_DETAIL.instantiate(fromImShStoryboard: .Profile)
        property.propertyData = propertyData
        return property
    }
    
    var locationManager = CLLocationManager()


    @IBOutlet weak var Viewmap: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var GoogleMapView: GMSMapView!

    @IBOutlet weak var btncurrentLocation: UIButton!
    @IBOutlet weak var conMapBottom: NSLayoutConstraint!
    @IBOutlet weak var btnskip: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!


    //MARK: outlet for details
    @IBOutlet weak var viewPropertyDetails: UIView!
    @IBOutlet weak var conviewPropertyDetailsTop: NSLayoutConstraint!
    @IBOutlet weak var viewInputDetails: UIView!

    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet private weak var SeparatorView: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationValue: UILabel!
    @IBOutlet weak var lblTenant: UILabel!
    @IBOutlet weak var lblSetDefault: UILabel!

    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var btnOwner: UIButton!

    @IBOutlet weak var btnDefault: UIButton!
    @IBOutlet weak var btnTenant: UIButton!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var txtPremiseId: SkyFloatingLabelTextField!
    @IBOutlet weak var txtVillaFlat: SkyFloatingLabelTextField!
    @IBOutlet weak var txtBuilding: SkyFloatingLabelTextField!
    @IBOutlet weak var txtStreet: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPropertyName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtOwnername: SkyFloatingLabelTextField!
    @IBOutlet weak var txtOwnerPhone: SkyFloatingLabelTextField!
    @IBOutlet weak var imgSelect1: UIImageView!
    @IBOutlet weak var imgSelect2: UIImageView!
    @IBOutlet weak var btnVilla: UIButton!
    @IBOutlet weak var btnAppartmentt: UIButton!
    @IBOutlet weak var btnAddProperty: UIButton!
    @IBOutlet weak var viewDottedLine: UIView!
    
    @IBOutlet weak var imgVilla: UIImageView!
    @IBOutlet weak var imgAppartment: UIImageView!

    
    //MARK: outlet for about info View

    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var viewPropertyData: UIView!
    @IBOutlet weak var viewPropertyDataDetail: UIView!
    
    @IBOutlet weak var viewAboutHomeInfo: UIView!
    @IBOutlet weak var btnSaveHomeInfo: UIButton!
    
    @IBOutlet weak var btnBackDetail: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblPropertyDetail: UILabel!
    @IBOutlet weak var lblTellUsAbout: UILabel!
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblpropertyTitle: UILabel!
    @IBOutlet weak var lblpropertyAddress: UILabel!
    @IBOutlet weak var conHeaderHeight: NSLayoutConstraint!

    @IBOutlet weak var tblInfo: UITableView!
    @IBOutlet weak var contblInfoHeight: NSLayoutConstraint!

    // MARK: PRIVATE

    private let infohandler = HomeInfoTableHandler()

    var bottomPadding : CGFloat = 0
    var topPadding : CGFloat = 0
    
    var propertyData : PropertyList!
    var latitude : String!
    var longitude : String!
    var isDefault : Int = 0
    
    var addressLines : String = ""
    var accuracy : String = "20.0"


    //MARK: variable for google Map
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 15.0

    //MARK: view Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }

        self.conviewPropertyDetailsTop.constant = self.view.frame.height + bottomPadding
//        self.setupPanGestures()
        
        btnskip.isHidden = true
        map.isHidden = true
        
        //-----------------------

        setLabel()
        
        if propertyData != nil
        {
            setAddressData()
        }
        
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        

    }
    
    
    
    //MARK: Transition
    func sharedView() -> UIView! {
        
        viewPropertyDataDetail.frame = CGRect(x: 20, y: 0, width: self.view.frame.size.width - 40, height:  self.viewPropertyData.frame.size.height - 40)
        
        return viewPropertyDataDetail
    }
    
    override func viewWillLayoutSubviews() {
        
        viewPropertyDetails.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        
        // shadow effect bottom view
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.viewPropertyData.frame.size.width + shadowSize,
                                                   height: self.viewPropertyData.frame.size.height + shadowSize))
        self.viewPropertyData.layer.masksToBounds = false
        self.viewPropertyData.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewPropertyData.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewPropertyData.layer.shadowOpacity = 0.5
        self.viewPropertyData.layer.shadowRadius = 3
        self.viewPropertyData.layer.shadowPath = shadowPath.cgPath
        
   //     ----------------------------------------------
        let shadowSize1 : CGFloat = 10.0
        let shadowPath1 = UIBezierPath(rect: CGRect(x: -shadowSize1 / 2,
                                                   y: -shadowSize1 / 2,
                                                   width: self.viewAboutHomeInfo.frame.size.width + shadowSize1,
                                                   height: self.viewAboutHomeInfo.frame.size.height + shadowSize1))
        self.viewAboutHomeInfo.layer.masksToBounds = false
        self.viewAboutHomeInfo.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewAboutHomeInfo.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewAboutHomeInfo.layer.shadowOpacity = 0.5
        self.viewAboutHomeInfo.layer.shadowRadius = 3
        self.viewAboutHomeInfo.layer.shadowPath = shadowPath1.cgPath
        
        //------------------------
        
        if let aSize = btnEdit.titleLabel?.font?.pointSize
        {
            btnEdit.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnAddProperty.titleLabel?.font?.pointSize
        {
            btnAddProperty.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        
        if let aSize = btnVilla.titleLabel?.font?.pointSize
        {
            btnVilla.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        if let aSize = btnAppartmentt.titleLabel?.font?.pointSize
        {
            btnAppartmentt.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
        if let aSize = btnChange.titleLabel?.font?.pointSize
        {
            btnChange.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
        }
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        self.updateLayout()
        
        lblTitle.text = "Edit Property"
        btnskip.setTitle("Skip", for: .normal)
        
        lblTenant.text = "Tenant"
        
        txtVillaFlat.placeholder = "Villa Number"
        txtStreet.placeholder = "Street"
        txtPropertyName.placeholder = "Property Name"
        txtBuilding.placeholder = "Building"
        txtOwnername.placeholder = "Owner Name"
        txtOwnerPhone.placeholder = "Owner Phone"

        btnAddProperty.setTitle("UPDATE PROPERTY", for: .normal)

        btnAppartmentt.setTitle("Appartment", for: .normal)
        btnVilla.setTitle("Villa", for: .normal)
        
        txtPremiseId.titleFont = UIFont.roboto(size: 12)!
        txtVillaFlat.titleFont = UIFont.roboto(size: 12)!
        txtStreet.titleFont = UIFont.roboto(size: 12)!
        txtPropertyName.titleFont = UIFont.roboto(size: 12)!
        txtBuilding.titleFont = UIFont.roboto(size: 12)!
        txtOwnername.titleFont = UIFont.roboto(size: 12)!
        txtOwnerPhone.titleFont = UIFont.roboto(size: 12)!
        
        txtPremiseId.font = UIFont.roboto(size: 16, weight: .Medium)
        txtVillaFlat.font = UIFont.roboto(size: 16, weight: .Medium)
        txtStreet.font = UIFont.roboto(size: 16, weight: .Medium)
        txtPropertyName.font = UIFont.roboto(size: 16, weight: .Medium)
        txtBuilding.font = UIFont.roboto(size: 16, weight: .Medium)
        txtOwnername.font = UIFont.roboto(size: 16, weight: .Medium)
        txtOwnerPhone.font = UIFont.roboto(size: 16, weight: .Medium)

    }
    
    func updateLayout()
    {
        self.tblInfo.estimatedRowHeight = 80
        self.tblInfo.rowHeight = UITableView.automaticDimension
        
        self.tblInfo.setUpTable(delegate: infohandler, dataSource: infohandler, cellNibWithReuseId: AboutInfoCell.className)
        
        self.tblInfo.reloadData()
        self.contblInfoHeight.constant = self.tblInfo.contentSize.height
        self.tblInfo.layoutIfNeeded()
        self.contblInfoHeight.constant = self.tblInfo.contentSize.height


        
        self.btnChange.isHidden = true
        

//        imgSelect2.isHidden = true
//        imgSelect1.isHidden = false
//        txtBuilding.isHidden = true
//        txtOwnername.isHidden = true
//        txtOwnerPhone.isHidden = true
//
//        btnAppartmentt.isSelected = false
//        btnVilla.isSelected = true
//        btnTenant.isSelected = false
//        btnAddProperty.isSelected = false
        
        txtOwnerPhone.keyboardType = .phonePad

        
        btnAppartmentt.setTitleColor(UserSettings.shared.themeColor(), for: .selected)
        btnAppartmentt.setTitleColor(UserSettings.shared.ThemeGrayColor(), for: .normal)
        
        btnVilla.setTitleColor(UserSettings.shared.themeColor(), for: .selected)
        btnVilla.setTitleColor(UserSettings.shared.ThemeGrayColor(), for: .normal)
        
        if #available(iOS 13.0, *) {
            btnTenant.setImage(UIImage.init(systemName: "circle"), for: .normal)
            btnDefault.setImage(UIImage.init(systemName: "square"), for: .normal)
            btnOwner.setImage(UIImage.init(systemName: "circle"), for: .normal)

        } else {
            // Fallback on earlier versions
        }
        btnTenant.setImage(UIImage(named: "Radio_Fill"), for: .selected)
        btnDefault.setImage(UIImage.init(systemName: "checkmark.square.fill"), for: .selected)
        btnOwner.setImage(UIImage(named: "Radio_Fill"), for: .selected)

        btnTenant.tintColor = UserSettings.shared.themeColor()
        btnDefault.tintColor = UserSettings.shared.themeColor()
        btnOwner.tintColor = UserSettings.shared.themeColor()

        btnTenant.imageView?.contentMode = .scaleAspectFit
        btnDefault.imageView?.contentMode = .scaleAspectFit
        btnOwner.imageView?.contentMode = .scaleAspectFit

    }
    
    func setfieldEmpty()
    {
        txtVillaFlat.text = ""
        txtStreet.text = ""
        txtPropertyName.text = ""
        txtBuilding.text = ""
        txtOwnername.text = ""
        txtOwnerPhone.text = ""
    }
    
    //MARK: API data set
    func setAddressData()
    {
        lblpropertyAddress.text = propertyData.fullAddress
        lblpropertyTitle.text = propertyData.propertyName
        
        txtPremiseId.text = propertyData.uniquePropertyId
        txtPremiseId.keyboardType = .namePhonePad

    
        if propertyData.propertyType == 1 //villa
        {
            self.imgType.image = UIImage(named: "Villa")
            
            btnAppartmentt.isSelected = false
            btnVilla.isSelected = true
            self.btnVillaClick(self.btnVilla as Any)

            txtVillaFlat.text = propertyData.villaNumber
            txtStreet.text = propertyData.villaStreet
            txtPropertyName.text = propertyData.propertyName
            txtBuilding.text = ""
        }
        else
        {
            self.imgType.image = UIImage(named: "Appartment")
            
            btnAppartmentt.isSelected = true
            btnVilla.isSelected = false
            self.btnAppartmentClick(self.btnAppartmentt as Any)

            txtVillaFlat.text = propertyData.appartmentFlatNo
            txtStreet.text = propertyData.appartmentStreet
            txtPropertyName.text = propertyData.propertyName
            txtBuilding.text = propertyData.appartmentBuilding
        }
        
        
        imgType.tintColor = UserSettings.shared.themeColor2()

        
        btnTenant.isSelected = false
        btnOwner.isSelected = true

        txtOwnername.isHidden = true
        txtOwnerPhone.isHidden = true

        if propertyData.isTenant == 1
        {
            btnTenant.isSelected = true
            btnOwner.isSelected = false

//            txtOwnername.isHidden = false
//            txtOwnerPhone.isHidden = false
            
//            txtOwnername.text = propertyData.ownerName
//            txtOwnerPhone.text = propertyData.ownerMobile
        }
        
        btnDefault.isSelected = false
        isDefault = propertyData.isDefault
        if propertyData.isDefault == 1
        {
            btnDefault.isSelected = true
        }
        
        latitude = propertyData.latitude
        longitude = propertyData.longitude
        
        if let lat = Double(propertyData.latitude) , let long = Double(propertyData.longitude)
        {
//            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            map.setRegion(region, animated: true)
            
            var zoomLevel : Float = 15.0
            if #available(iOS 14.0, *) {
                zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
            } else {
            }

            let camera = GMSCameraPosition.camera(withLatitude: lat,
                                                  longitude: long,
                                                  zoom: zoomLevel)
            GoogleMapView.settings.myLocationButton = false
            GoogleMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            GoogleMapView.isMyLocationEnabled = false
            GoogleMapView.delegate = self

            GoogleMapView.camera = camera
        }
        
        GoogleMapView.isUserInteractionEnabled = false
        btncurrentLocation.isHidden = true
        
        self.accuracy = String(format: "%d", propertyData.accuracy)
        self.addressLines = propertyData.gLocation
        
    }
    
    //MARK: Gesture Methods

//    func setupPanGestures() {
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)) )
//        viewLocation.addGestureRecognizer(panGesture)
//    }
//
//    @objc func handlePanGesture(gesture : UIPanGestureRecognizer)
//    {
//        if gesture.isDown(circleView: viewPropertyDetails)
//        {
//            self.btnChange.isHidden = true
//            self.viewInputDetails.isHidden = true
//            btnAddPropertyDetails.alpha = 0
//            self.viewInputDetails.alpha = 1
//            viewDottedLine.alpha = 0
//
//            UIView.animate(withDuration: 0.3) {
//                self.conviewPropertyDetailsTop.constant = self.view.frame.height - self.bottomPadding - 200
//                self.viewInputDetails.alpha = 0
//                self.btnAddPropertyDetails.alpha = 1
//                self.viewDottedLine.alpha = 1
//
//                self.viewPropertyDetails.superview?.layoutIfNeeded()
//            }
//
//        }
//        else
//        {
//            self.btnChange.isHidden = false
//            self.viewInputDetails.isHidden = false
//            btnAddPropertyDetails.alpha = 1
//            self.viewInputDetails.alpha = 0
//            self.viewDottedLine.alpha = 1
//
//
//            UIView.animate(withDuration: 0.3) {
//                self.conviewPropertyDetailsTop.constant = 200 - self.topPadding
//                self.viewInputDetails.alpha = 1
//                self.btnAddPropertyDetails.alpha = 0
//                self.viewDottedLine.alpha = 0
//                self.viewPropertyDetails.superview?.layoutIfNeeded()
//            }
//
//        }
//    }
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            

//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            map.setRegion(region, animated: true)
//
//            self.getAddressFromLatLon(pdblLatitude: location.coordinate.latitude.description, withLongitude: location.coordinate.longitude.description)
            
            self.latitude = String(format: "%f", location.coordinate.latitude)
            self.longitude = String(format: "%f", location.coordinate.longitude)
            self.accuracy = String(format: "%.f", location.horizontalAccuracy)

            
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
            
            
            reverseGeocode(coordinate: location.coordinate)
            //--------------- Google Map -----------------------
            
            locationManager.stopUpdatingLocation()

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
    //MARK: Google address api
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
      // 1
      let geocoder = GMSGeocoder()

      // 2
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard
          let address = response?.firstResult(),
          let lines = address.lines
          else {
            return
        }

//        print(address.description)
//        print(lines)

        // 3
        
        self.lblLocationValue.text = address.subLocality

        if address.subLocality == nil
        {
            self.lblLocationValue.text = address.locality

        }
        
        self.addressLines = lines[0]
        let AddressData = lines[0].split(separator: ",")
//        print(AddressData)
        
        if AddressData.count > 1
        {
            self.txtVillaFlat.text = String(AddressData[0])
            self.txtStreet.text = String(AddressData[1].dropFirst())
        }

      }
    }
    
    
 
    
    //MARK: - Custom Annotation
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let mapLatitude = mapView.centerCoordinate.latitude
//        let mapLongitude = mapView.centerCoordinate.longitude
//        
//        latitude = String(format: "%f", mapLatitude)
//        longitude = String(format: "%f", mapLongitude)
//
//        
//        self.getAddressFromLatLon(pdblLatitude: mapLatitude.description, withLongitude: mapLongitude.description)
//    }
//
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // this is our unique identifier for view reuse
//        let identifier = "Placemark"
//
//        // attempt to find a cell we can recycle
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//        if annotationView == nil {
//            // we didn't find one; make a new one
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//            // allow this to show pop up information
//            annotationView?.canShowCallout = true
//
//            // attach an information button to the view
//            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        } else {
//            // we have a view to reuse, so give it the new annotation
//            annotationView?.annotation = annotation
//        }
//
//        annotationView?.image = UIImage(named: "Pin")
//
//        // whether it's a new view or a recycled one, send it back
//        return annotationView
//    }
//    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String)
//    {
//        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        let lat: Double = Double("\(pdblLatitude)")!
//        let lon: Double = Double("\(pdblLongitude)")!
//        let ceo: CLGeocoder = CLGeocoder()
//        center.latitude = lat
//        center.longitude = lon
//        
//        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//        
//        
//        ceo.reverseGeocodeLocation(loc, completionHandler:
//        {(placemarks, error) in
//            if (error != nil)
//            {
//                print("reverse geodcode fail: \(error!.localizedDescription)")
//            }
//            let pm = placemarks! as [CLPlacemark]
//            
//            if pm.count > 0 {
//                let pm = placemarks![0]
//                print(pm.country)
//                print(pm.locality)
//                print(pm.subLocality)
//                print(pm.thoroughfare)
//                print(pm.postalCode)
//                print(pm.subThoroughfare)
//
//                self.lblLocationValue.text = pm.subLocality ?? "india"
//            }
//        })
//    }
    
    //MARK: Button methods
    
    @IBAction func btnSaveHomeInfoClick(_ sender: Any) {
    }
    
    @IBAction func btnEditClick(_ sender: Any) {
        
        self.btnChange.isHidden = false
        self.viewInputDetails.alpha = 0
        self.viewDottedLine.alpha = 1
        
        self.viewDetail.alpha = 1

        
        UIView.animate(withDuration: 0.3) {
            self.conviewPropertyDetailsTop.constant = 200 - self.topPadding
            self.viewInputDetails.alpha = 1
            self.viewDottedLine.alpha = 0
            self.viewDetail.alpha = 0

            self.viewPropertyDetails.superview?.layoutIfNeeded()
        }
    }
    
    @IBAction func btnBackDetailClick(_ sender: Any)
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnBackClick(_ sender: Any)
    {
        self.view.endEditing(true)
        self.btnChange.isHidden = true
        self.viewInputDetails.alpha = 1
        viewDottedLine.alpha = 0
        
        self.viewDetail.alpha = 0


        UIView.animate(withDuration: 0.3) {
            self.conviewPropertyDetailsTop.constant = self.view.frame.height + self.bottomPadding
            self.viewInputDetails.alpha = 0
            self.viewDottedLine.alpha = 1
            
            self.viewDetail.alpha = 1

            self.viewPropertyDetails.superview?.layoutIfNeeded()
        }

        
    }

    @IBAction func btnCurrentLocationClick(_ sender: Any) {
        
        getCurrentLocation()
    }
    
    @IBAction func btnChangeClick(_ sender: Any) {
        
        self.view.endEditing(true)
        GoogleMapView.isUserInteractionEnabled = true
        btncurrentLocation.isHidden = false
    }
    
    @IBAction func btnAppartmentClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnVilla.isSelected = false


        imgSelect2.isHidden = false
        imgSelect1.isHidden = true
        txtBuilding.isHidden = false
        txtVillaFlat.placeholder = "Flat No/ Unit No"
        
        btnTenant.isSelected = false
        txtOwnername.isHidden = true
        txtOwnerPhone.isHidden = true
        
        imgAppartment.tintColor = UserSettings.shared.themeColor2()
        imgVilla.tintColor = UIColor.lightGray
        
        btnVilla.setTitleColor(UIColor.lightGray, for: .normal)
        btnAppartmentt.setTitleColor(UserSettings.shared.themeColor(), for: .normal)


    }
    
   
    @IBAction func btnVillaClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnAppartmentt.isSelected = false
        
        imgSelect2.isHidden = true
        imgSelect1.isHidden = false
        txtBuilding.isHidden = true
        txtVillaFlat.placeholder = "Villa Number"
        
        imgVilla.tintColor = UserSettings.shared.themeColor2()
        imgAppartment.tintColor = UIColor.lightGray
        
        btnAppartmentt.setTitleColor(UIColor.lightGray, for: .normal)
        btnVilla.setTitleColor(UserSettings.shared.themeColor(), for: .normal)


//        setfieldEmpty()

    }
    
    @IBAction func btnTenantClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnOwner.isSelected = false
        btnTenant.isSelected = true
    }
    
    @IBAction func btnOwnerClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnTenant.isSelected = false
        btnOwner.isSelected = true
    }
    
    
    @IBAction func btnAddPropertyClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if txtVillaFlat.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter villa/Flat number", duration: .lengthShort).show()
            return

        }
        else if txtBuilding.text?.count == 0 && btnAppartmentt.isSelected
        {
            SnackBar.make(in: self.view, message: "Please enter building name", duration: .lengthShort).show()
            return

        }
        else if txtStreet.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter street name", duration: .lengthShort).show()
            return

        }
        else if txtPropertyName.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter property name", duration: .lengthShort).show()
            return

        }
//        else if txtOwnername.text?.count == 0 && btnTenant.isSelected
//        {
//            SnackBar.make(in: self.view, message: "Please enter owner name", duration: .lengthShort).show()
//            return
//
//        }
//        else if txtOwnerPhone.text?.count == 0 && btnTenant.isSelected
//        {
//            SnackBar.make(in: self.view, message: "Please enter owner phone number", duration: .lengthShort).show()
//            return
//        }
        else
        {
            let property = PropertyDataModel.init()
            property.latitude = latitude
            property.longitude = longitude
            property.sourceFrom = "3"
            property.customerId = UserSettings.shared.getCustomerId()
            property.isDefault = isDefault
            property.g_location = self.addressLines
            property.accuracy = self.accuracy
            property.premiseId = txtPremiseId.text
            
            if btnVilla.isSelected
            {
                property.propertyType = "1"
                property.villaNumber = txtVillaFlat.text
                property.villaStreet = txtStreet.text
                property.villaPropertyName = txtPropertyName.text
                if btnTenant.isSelected
                {
                    property.villaTenant = "1"
                    property.villaOwnerName = txtOwnername.text
                    property.villaOwnerMobile = txtOwnerPhone.text

                }
            }
            else
            {
                property.propertyType = "2"
                property.appartmentFlatNo = txtVillaFlat.text
                property.appartmentStreet = txtStreet.text
                property.appartmentBuilding = txtBuilding.text
                property.appartmentPropertyName = txtPropertyName.text
                
                if btnTenant.isSelected
                {
                    property.appartmentTenant = "1"
                    property.appartmentOwnerName = txtOwnername.text
                    property.appartmentOwnerMobile = txtOwnerPhone.text
                }
            }
            
            let id = String(format: "%d", propertyData.id)
            
            ServerRequest.shared.UpdateProperty(propertyId : id , property: property, delegate: self) { (result) in
                
                if result.id != nil
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Property Updated Successfully", aOKBtnTitle: "OK") { (index, title) in

                        let viewcontrollers = self.navigationController?.viewControllers ?? []
                        for vc in viewcontrollers
                        {
                            if vc is PROPERTY_LIST
                            {
                                let listvc = vc as! PROPERTY_LIST
                                listvc.fetchPropertyData()
                                self.navigationController?.popToViewController(listvc, animated: true)
                                break
                            }
                        }
                        return
                    }
                }
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                }
            }
        }
//        {
//            let user = UserSettings.shared.getUserCredential()
//            var dict = [String:Any]()
//
//            if btnTenant.isSelected
//            {
//                dict = ["location":self.lblLocationValue.text!,"propertyname":self.txtPropertyName.text! ,"villa":self.txtVillaFlat.text! ,"building":self.txtBuilding.text! ,"street":self.txtStreet.text!,"name":self.txtOwnername.text!,"phone":  self.txtOwnerPhone.text!] as [String : Any]
//
//            }
//            else
//            {
//                dict = ["location":self.lblLocationValue.text!,"propertyname":self.txtPropertyName.text! ,"villa":self.txtVillaFlat.text! ,"building":self.txtBuilding.text! ,"street":self.txtStreet.text!,"name":user["firstname"] as? String,"phone":user["mobile"] as? String] as [String : Any]
//
//            }
//
//
////            self.UpdateUserProperty(request: dict, delegate: self) { (propertyId) in
////
////                if propertyId != ""
////                {
////                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Property Updated Successfully", aOKBtnTitle: "OK") { (index, title) in
////
////                        let viewcontrollers = self.navigationController?.viewControllers ?? []
////                        for vc in viewcontrollers
////                        {
////                            if vc is PROPERTY_LIST
////                            {
////                                let listvc = vc as! PROPERTY_LIST
////                                listvc.fetchPropertyData()
////                                self.navigationController?.popToViewController(listvc, animated: true)
////                                break
////                            }
////                        }
////                        return
////                    }
////                }
////
////            } failure: { (errorMsg) in
////                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
////
////                }
////            }
//        }

    }
    
    @IBAction func btnsetDefaultClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        if btn.isSelected
        {
            isDefault = 1
        }
        else
        {
            isDefault = 0
        }

    }

    @IBAction func btnskipClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }

    //MARK: Web Service calling
    
    
}
extension PROPERTY_DETAIL : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
extension PROPERTY_DETAIL: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.latitude = String(format: "%f", position.target.latitude)
        self.longitude = String(format: "%f", position.target.longitude)
        reverseGeocode(coordinate: position.target)
    }

}
