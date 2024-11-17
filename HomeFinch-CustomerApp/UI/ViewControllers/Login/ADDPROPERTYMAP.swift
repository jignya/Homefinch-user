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
import GooglePlaces
import GoogleMaps
import Amplitude_iOS

class ADDPROPERTYMAP: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, ServerRequestDelegate {

    static func create(strFrom:String = "") -> ADDPROPERTYMAP {
        let property = ADDPROPERTYMAP.instantiate(fromImShStoryboard: .Login)
        property.strcome = strFrom
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
    @IBOutlet weak var lblSetDefault: UILabel!


    //MARK: outlet for details
    @IBOutlet weak var viewPropertyDetails: UIView!
    @IBOutlet weak var conviewPropertyDetailsTop: NSLayoutConstraint!
    @IBOutlet weak var viewInputDetails: UIView!

    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet private weak var SeparatorView: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblLocationValue: UILabel!
    @IBOutlet weak var lblTenant: UILabel!
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
    @IBOutlet weak var btnAddPropertyDetails: UIButton!
    @IBOutlet weak var viewDottedLine: UIView!
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var imgVilla: UIImageView!
    @IBOutlet weak var imgAppartment: UIImageView!

    var bottomPadding : CGFloat = 0
    var topPadding : CGFloat = 0
    
    var strcome : String!
    var latitude : String!
    var longitude : String!
    var addressLines : String = ""
    var accuracy : String = "20.0"

    var isDefault : Int = 0
    
    //MARK: variable for google Map
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 15.0


    //MARK: view Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }

        self.conviewPropertyDetailsTop.constant = self.view.frame.height - bottomPadding - 230
        getCurrentLocation()
        self.setupPanGestures()
        
        btnBack.isHidden = true
        btnskip.isHidden = false

        setLabel()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        if strcome == "change"
        {
            btnBack.isHidden = false
            btnskip.isHidden = true
        }

    }
    
    override func viewWillLayoutSubviews()
    {
        viewPropertyDetails.roundCorners(corners: [.topRight, .topLeft], radius: 20)

        viewDottedLine.createDottedLine(width: 1, color: UserSettings.shared.ThemeGrayColor().cgColor)
        
        if let aSize = btnAddProperty.titleLabel?.font?.pointSize
        {
            btnAddProperty.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnAddPropertyDetails.titleLabel?.font?.pointSize
        {
            btnAddPropertyDetails.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
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
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        self.updateLayout()
        
        lblTitle.text = "Add Property"
        btnskip.setTitle("Skip", for: .normal)
        
        lblTenant.text = "Tenant"
        
        txtVillaFlat.placeholder = "Villa Number"
        txtStreet.placeholder = "Street"
        txtPropertyName.placeholder = "Property Name"
        txtBuilding.placeholder = "Building"
        txtOwnername.placeholder = "Owner Name"
        txtOwnerPhone.placeholder = "Owner Phone"

        btnAddPropertyDetails.setTitle("ADD PROPERTY DETAILS", for: .normal)
        btnAddProperty.setTitle("ADD PROPERTY", for: .normal)

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

        
        txtPremiseId.keyboardType = .namePhonePad

    }
    
    func updateLayout()
    {
        self.viewInputDetails.isHidden = true
        self.btnChange.isHidden = true
        
        btnAppartmentt.isSelected = false
        btnVilla.isSelected = true

        self.btnVillaClick(btnVilla as Any)
        
        txtBuilding.isHidden = true
        txtOwnername.isHidden = true
        txtOwnerPhone.isHidden = true
        
        btnTenant.isSelected = false
        btnOwner.isSelected = true
        btnAddProperty.isSelected = false
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
        txtPremiseId.text = ""
        txtVillaFlat.text = ""
        txtStreet.text = ""
        txtPropertyName.text = ""
        txtBuilding.text = ""
        txtOwnername.text = ""
        txtOwnerPhone.text = ""
    }

    
    //MARK: Gesture Methods

    func setupPanGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)) )
        viewLocation.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture : UIPanGestureRecognizer)
    {
        if gesture.isDown(circleView: viewPropertyDetails)
        {
            self.btnChange.isHidden = true
            self.viewInputDetails.isHidden = true
            btnAddPropertyDetails.alpha = 0
            self.viewInputDetails.alpha = 1
            viewDottedLine.alpha = 0
            self.viewSearchBar.isHidden = false

            
            GoogleMapView.isUserInteractionEnabled = true
            map.isHidden = true

            btncurrentLocation.isHidden = false

            
            UIView.animate(withDuration: 0.3) {
                self.conviewPropertyDetailsTop.constant = self.view.frame.height - self.bottomPadding - 230
                self.viewInputDetails.alpha = 0
                self.btnAddPropertyDetails.alpha = 1
                self.viewDottedLine.alpha = 1

                self.viewPropertyDetails.superview?.layoutIfNeeded()
            }

        }
        else
        {
            self.btnChange.isHidden = false
            self.viewInputDetails.isHidden = false
            btnAddPropertyDetails.alpha = 1
            self.viewInputDetails.alpha = 0
            self.viewDottedLine.alpha = 1
            self.viewSearchBar.isHidden = true

            
            GoogleMapView.isUserInteractionEnabled = false
            btncurrentLocation.isHidden = true


            
            UIView.animate(withDuration: 0.3) {
                self.conviewPropertyDetailsTop.constant = 200 - self.topPadding
                self.viewInputDetails.alpha = 1
                self.btnAddPropertyDetails.alpha = 0
                self.viewDottedLine.alpha = 0
                self.viewPropertyDetails.superview?.layoutIfNeeded()
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
            locationManager.requestWhenInUseAuthorization()
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
            
            print(location.verticalAccuracy)
            print(location.horizontalAccuracy)

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
        
        print(coordinate.latitude,coordinate.longitude)
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
            // 3
            
            self.lblLocationValue.text = address.subLocality
            self.txtVillaFlat.text = ""
            self.txtStreet.text = ""
            
            
            
            self.addressLines = lines[0]
            let AddressData = lines[0].split(separator: ",")
            
            print(address)
            if address.subLocality == nil
            {
                //            self.lblLocationValue.text = address.locality
                self.lblLocationValue.text = self.addressLines.replacingOccurrences(of: "Unnamed Road - ", with: "")
                
            }
            
            if AddressData.count > 1
            {
                self.txtVillaFlat.text = String(AddressData[0])
                self.txtStreet.text = String(AddressData[1].dropFirst())
            }
            
        }
    }
    
    
    //MARK: - Custom Annotation , mapview methods //not used
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        let mapLatitude = mapView.centerCoordinate.latitude
//        let mapLongitude = mapView.centerCoordinate.longitude
//
//        latitude = String(format: "%f", mapLatitude)
//        longitude = String(format: "%f", mapLongitude)
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
//            if let pm = placemarks
//            {
//                if pm.count > 0 {
//                    let pm = placemarks![0]
//                    print(pm.country as Any)
//                    print(pm.locality as Any)
//                    print(pm.subLocality as Any)
//                    print(pm.thoroughfare as Any)
//                    print(pm.postalCode as Any)
//                    print(pm.subThoroughfare as Any)
//
//                    self.lblLocationValue.text = pm.subLocality ?? "india"
//                }
//            }
//
//
//        })
//    }
    
    //MARK: Button methods
    
    @IBAction func btnSearchClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        // google search ---------------------
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue:UInt(GMSPlaceField.name.rawValue) |
                    UInt(GMSPlaceField.placeID.rawValue) |
                    UInt(GMSPlaceField.coordinate.rawValue) |
                    GMSPlaceField.addressComponents.rawValue |
                    GMSPlaceField.formattedAddress.rawValue)
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter
        
        // google search login complete ---------------------
                
        UIBarButtonItem.appearance().tintColor = UIColor.black
                
        // Display the autocomplete view controller.
        autocompleteController.modalPresentationStyle = .overFullScreen
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCurrentLocationClick(_ sender: Any) {
        
        getCurrentLocation()
    }
    
    @IBAction func btnChangeClick(_ sender: Any) {
        
        self.view.endEditing(true)
        
        GoogleMapView.isUserInteractionEnabled = true
        btncurrentLocation.isHidden = false
        
        self.btnChange.isHidden = true
        self.viewInputDetails.isHidden = true
        btnAddPropertyDetails.alpha = 0
        self.viewInputDetails.alpha = 1
        viewDottedLine.alpha = 0
        self.viewSearchBar.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.conviewPropertyDetailsTop.constant = self.view.frame.height - self.bottomPadding - 230
            self.viewInputDetails.alpha = 0
            self.btnAddPropertyDetails.alpha = 1
            self.viewDottedLine.alpha = 1

            self.viewPropertyDetails.superview?.layoutIfNeeded()
        }


    }
    
    @IBAction func btnAppartmentClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnVilla.isSelected = false
        btnAppartmentt.isSelected = true

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


        
        setfieldEmpty()

    }
    
   
    @IBAction func btnVillaClick(_ sender: Any) {
        
        self.view.endEditing(true)
        btnAppartmentt.isSelected = false
        btnVilla.isSelected = true

        imgSelect2.isHidden = true
        imgSelect1.isHidden = false
        txtBuilding.isHidden = true
        txtVillaFlat.placeholder = "Villa Number"
        
        imgVilla.tintColor = UserSettings.shared.themeColor2()
        imgAppartment.tintColor = UIColor.lightGray
        
        btnAppartmentt.setTitleColor(UIColor.lightGray, for: .normal)
        btnVilla.setTitleColor(UserSettings.shared.themeColor(), for: .normal)

        setfieldEmpty()

    }
    
    @IBAction func btnTenantClick(_ sender: Any) {
        
        self.view.endEditing(true)
//        let btn = sender as! UIButton
        btnOwner.isSelected = false
        btnTenant.isSelected = true
        
        
        //        if btn.isSelected
        //        {
        //            txtOwnername.isHidden = false
        //            txtOwnerPhone.isHidden = false
        //        }
        //        else
        //        {
        //           txtOwnername.isHidden = true
        //           txtOwnerPhone.isHidden = true
        //        }
        
    }
    
    @IBAction func btnOwnerClick(_ sender: Any) {
        
        self.view.endEditing(true)
//        let btn = sender as! UIButton
        
        btnTenant.isSelected = false
        btnOwner.isSelected = true
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
    
    @IBAction func btnAddPropertyDetailsClick(_ sender: Any) {
        
        self.btnChange.isHidden = false
        self.viewInputDetails.isHidden = false
        self.btnAddPropertyDetails.alpha = 0
        self.viewDottedLine.alpha = 0
        self.viewSearchBar.isHidden = true

        self.viewInputDetails.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.conviewPropertyDetailsTop.constant = 200 - self.topPadding
            self.viewInputDetails.alpha = 1
            self.viewPropertyDetails.superview?.layoutIfNeeded()
        }

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
//
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
            property.premiseId = self.txtPremiseId.text


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
            
            ServerRequest.shared.CreateNewProperty(property: property, delegate: self) { (result) in
                
                if result.id != nil
                {
                    //------------------- log event ------------------
                    
                    let dictPara = ["App User ID": result.customerId,
                                    "Customer ID": result.customerId,
                                    "Customer Category":"1",
                                    "Customer Property Count": result.customerCount ,
                                    "Contact ID": "",
                                    "Contact Type":"",
                                    "Property ID":result.id,
                                    "Property Map Location":self.lblLocationValue.text,
                                    "Property Geofence Location":result.gLocation] as [String : Any]
                    
                    Amplitude.instance().logEvent("Customer - Add Property", withEventProperties: dictPara)
                    //------------------------------------------------
                    
                    AJAlertController.initialization().showAlertWithOkButton(iscloseShow: false, isBottomShow: false, aStrTitle: "", aStrMessage: "Property Created Successfully", aOKBtnTitle: "OK") { (index, title) in
                        
                        if self.strcome == "change"
                        {
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
                        
                        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
                        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                        AppDelegate.shared.window?.rootViewController = navigationController
                        AppDelegate.shared.window?.makeKeyAndVisible()
                    }
                    
                    
                }
                
                
            } failure: { (errorMsg) in
                AJAlertController.initialization().showAlertWithOkButton(iscloseShow: false, isBottomShow: false, aStrTitle: "", aStrMessage: errorMsg, aOKBtnTitle: "OK") { (index, title) in
                    
                }
            }
        }
       

    }

    @IBAction func btnskipClick(_ sender: Any) {
        
        self.view.endEditing(true)
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
}
extension UIPanGestureRecognizer {
    func isDown(circleView: UIView) -> Bool {
        let velocity : CGPoint = self.velocity(in: circleView)
         if velocity.y < 0 {
//            print("ex Gesture went up")
            return false
         } else {
//            print("ex Gesture went down")
            return true
         }
     }
 }
extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [8,5] // linewidth , space
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
   }
}


extension ADDPROPERTYMAP: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.latitude = String(format: "%f", position.target.latitude)
        self.longitude = String(format: "%f", position.target.longitude)
        
        let loc: CLLocation = CLLocation(latitude:position.target.latitude, longitude: position.target.longitude)
        print(loc.horizontalAccuracy)
        
        reverseGeocode(coordinate: position.target)
    }

//    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
//        print("call1")
//        print(marker.position.latitude)
//        print(marker.position.longitude)
//
//    }
//
//    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
//        print("call1")
//        print(marker.position.latitude)
//        print(marker.position.longitude)
//
//    }
}


extension ADDPROPERTYMAP: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(String(describing: place.name))")
    print("Place ID: \(place.coordinate.latitude) , \(place.coordinate.longitude)")

    self.latitude = String(format: "%f", place.coordinate.latitude)
    self.longitude = String(format: "%f", place.coordinate.longitude)
    
    
//    let center = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//    self.map.setRegion(region, animated: true)
    

    
    var zoomLevel : Float = 15.0
    
    if #available(iOS 14.0, *) {
        zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
    } else {
    }

    let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                          longitude: place.coordinate.longitude,
                                          zoom: zoomLevel)
    GoogleMapView.camera = camera

    reverseGeocode(coordinate: place.coordinate)
    
    let loc: CLLocation = CLLocation(latitude:place.coordinate.latitude, longitude: place.coordinate.longitude)
    print(loc.horizontalAccuracy)

    dismiss(animated: true, completion: nil)
    
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
