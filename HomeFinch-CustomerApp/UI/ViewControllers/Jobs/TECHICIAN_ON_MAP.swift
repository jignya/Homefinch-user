//
//  TECHICIAN_ON_MAP.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 01/01/21.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps

class TECHICIAN_ON_MAP: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {
    
    static func create(strFrom:String = "",jobData:JobIssueList) -> TECHICIAN_ON_MAP {
        let technician = TECHICIAN_ON_MAP.instantiate(fromImShStoryboard: .Jobs)
        technician.jobRequestData = jobData
        return technician
    }
    
    var locationManager = CLLocationManager()


    @IBOutlet weak var Viewmap: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var GoogleMapView: GMSMapView!

    @IBOutlet weak var btncurrentLocation: UIButton!
    @IBOutlet weak var conMapBottom: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!


    //MARK: outlet for details
    
    @IBOutlet weak var viewTechnicianDetails: UIView!
    @IBOutlet weak var conviewTechnicianDetailsTop: NSLayoutConstraint!
    @IBOutlet weak var viewServiceDetails: UIView!

    @IBOutlet weak var viewTechnician: UIView!
    @IBOutlet private weak var SeparatorView: UIImageView!
    @IBOutlet weak var lblTechnicianName: UILabel!
    @IBOutlet weak var imgTechnician: UIImageView!

    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    
    
    @IBOutlet weak var tblUpdates: UITableView!
    @IBOutlet weak var conTblUpdatesHeight: NSLayoutConstraint!

    @IBOutlet weak var lblArrival: UILabel!
    @IBOutlet weak var lblInitials: UILabel!



    var bottomPadding : CGFloat = 0
    var topPadding : CGFloat = 0
    
    private let updatehandler = TechinicianTimeupdateTableHandler()

    var strcome : String!
    var jobRequestData : JobIssueList!
    
    var arrList = [[String:Any]]()
    var markers = [GMSMarker]()


    
    //MARK: variable for google Map
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0


    //MARK: view Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblArrival.isHidden = true
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            bottomPadding = (window?.safeAreaInsets.bottom)!
            topPadding = (window?.safeAreaInsets.top)!
        }

        self.conviewTechnicianDetailsTop.constant = 300 //self.view.frame.height - (self.topPadding + self.bottomPadding + 95)
        getCurrentLocation()

        setLabel()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        map.isHidden = true
        map.showsUserLocation = true
        
        //------------------  SetData
        
        self.SetData(response: jobRequestData)
        
        
        self.getUserRadarData()
        
        self.fetchTechnicianStatusUpdate()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    func SetData(response:JobIssueList)
    {
        self.lblTechnicianName.text = response.employeeData.fullName
        
        let initials = self.lblTechnicianName.text?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        self.lblInitials.text = initials?.uppercased()
        self.imgTechnician.isHidden = true
        self.imgTechnician.backgroundColor = UIColor.clear
        
        
        if let imageTec = response.employeeData.avatar
        {
            self.imgTechnician.setImage(url: imageTec.getURL, placeholder: nil)
            self.imgTechnician.isHidden = false
            self.imgTechnician.contentMode = .scaleAspectFill
        }
        
    }
    
    func getTechnicianLocation(techlat : Double , techlong : Double)
    {
        var location = CLLocationCoordinate2D()
        location.latitude = Double(self.jobRequestData.propertyData.latitude)!
        location.longitude = Double(self.jobRequestData.propertyData.longitude)!
        
        var zoomLevel : Float = 15.0
        if #available(iOS 14.0, *) {
            zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        } else {
        }

        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                              longitude: location.longitude,
                                              zoom: zoomLevel)
        GoogleMapView.settings.myLocationButton = false
        GoogleMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        GoogleMapView.isMyLocationEnabled = false
        GoogleMapView.delegate = self

        GoogleMapView.camera = camera
        
        let sourceMarker = GMSMarker(position: location)
        sourceMarker.icon = UIImage(named: "DotPin")
        sourceMarker.map = GoogleMapView
        sourceMarker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)


        
        let marker = GMSMarker(position: location)
        marker.icon = UIImage(named: "T_Marker")
        marker.map = GoogleMapView
        marker.position = CLLocationCoordinate2D(latitude: techlat, longitude: techlong)

        
        self.markers.removeAll()
        
        var bounds = GMSCoordinateBounds()

        self.markers.append(sourceMarker)
        self.markers.append(marker)

        for marker in self.markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        bounds = bounds.includingCoordinate(marker.position)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 70)
        self.GoogleMapView.animate(with: update)
        
        
//        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        map.setRegion(region, animated: true)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        map.addAnnotation(annotation)
        
    }
    
    
    
    
    //MARK: Dynamic Labels
    func setLabel()
    {
        lblArrival.text = "Arrived at your place in 2 hours"

        self.ImShSetLayout()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        viewTechnicianDetails.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    
    }
    override func ImShSetLayout()
    {
        self.setupPanGestures()
        
        self.viewServiceDetails.isHidden = false

        self.tblUpdates.estimatedRowHeight = 110
        self.tblUpdates.rowHeight = UITableView.automaticDimension
        
        self.tblUpdates.setUpTable(delegate: updatehandler, dataSource: updatehandler, cellNibWithReuseId: TechnicianUpdateCell.className)
        
        
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
//            self.viewTechnician.backgroundColor = UIColor.white
//            self.viewServiceDetails.alpha = 1
//            self.viewServiceDetails.isHidden = true
//
//
//            UIView.animate(withDuration: 0.3) {
//                self.conviewTechnicianDetailsTop.constant = self.view.frame.height - (self.topPadding + self.bottomPadding + 95)
//                self.viewServiceDetails.alpha = 0
//                self.viewTechnicianDetails.superview?.layoutIfNeeded()
//            }

        }
        else
        {
//            self.viewTechnician.backgroundColor = UserSettings.shared.ThemeBgGroupColor()
//
//            self.viewServiceDetails.alpha = 0
//            self.viewServiceDetails.isHidden = false
//
//
//            UIView.animate(withDuration: 0.3) {
//                self.conviewTechnicianDetailsTop.constant = 300 - self.topPadding
//                self.viewServiceDetails.alpha = 1
//                self.viewTechnicianDetails.superview?.layoutIfNeeded()
//            }

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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    

    //MARK: Button methods
    
    @IBAction func btnBackClick(_ sender: Any) {
        
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCurrentLocationClick(_ sender: Any) {
        
        getCurrentLocation()
    }
    
    @IBAction func btncallClick(_ sender: Any) {
        let customerPhn = self.jobRequestData.employeeData.workPhone.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(customerPhn)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    }
    
    @IBAction func btnMessageClick(_ sender: Any) {
        
        let chat = CHATVIEW.create(title: "", jobData: self.jobRequestData)
        self.navigationController?.pushViewController(chat, animated: true)

    }
    
    //MARK: Get Trip History
    
    func getUserRadarData()
    {
        self.lblArrival.text = ""
        
        ServerRequest.shared.GetUser(performerid: self.jobRequestData.employeeId.toString(), delegate: self) { response in
            
            let userData = response["users"] as? [[String:Any]] ?? []
            
            for userDict in userData
            {
                if userDict["userId"] as? String == self.jobRequestData.employeeId.toString()
                {
                    //                let userDict = response["user"] as? [String:Any]
                    let userLocation = userDict["location"] as? [String:Any]
                    let performerLocation = userLocation?["coordinates"] as? [Double]
                    
                    let performerLat = performerLocation?[1]
                    let performerLong = performerLocation?[0]
                    
                    self.getTechnicianLocation(techlat: performerLat ?? 0.0, techlong: performerLong ?? 0.0)
                    
                    let destlatitude1 = self.jobRequestData.propertyData.latitude ?? ""
                    let destlongitude1 = self.jobRequestData.propertyData.longitude ?? ""
                    
                    if destlatitude1 != "" && destlongitude1 != ""
                    {
                        ServerRequest.shared.GetUserDistance(current0: String(format: "%f", performerLat as! CVarArg), current1: String(format: "%f", performerLong as! CVarArg), dest0: destlatitude1, dest1: destlongitude1, delegate: nil) { response in
                            
                            if response.isEmpty == false
                            {
                                self.lblArrival.isHidden = false
                                let routes = response["routes"] as? [String:Any]
                                let values = routes?["car"] as? [String:Any]
                                let duration = values?["duration"] as? [String:Any]
                                
                                if duration?["text"] as? String == "0"
                                {
                                    self.lblArrival.text = "Arrived at your place"
                                }
                                else
                                {
                                    self.lblArrival.text = String(format: "Arriving at your place in %@", duration?["text"] as? String ?? "")
                                }
                            }
                            
                        } failure: { (errorMsg) in
                            
                        }
                        
                    }
                    
                    break
                }
            }
            
            
        } failure: { (errorMsg) in
            
        }
        
    }
    
    func fetchTechnicianTrip()
    {
        let strId = String(format: "%d",jobRequestData.id)

        ServerRequest.shared.GetPerformerOnmapHistory(extrtnalId: strId, geofenceTag: "", delegate: self) { (respose) in
            
        } failure: { (errMsg) in
            
        }

    }
    
    func fetchTechnicianStatusUpdate()
    {
        let strId = String(format: "%d",jobRequestData.id)
        
        ServerRequest.shared.GetPerformerJourneyStatusUpdate(jobreqId: strId, delegate: self) { (response) in
            
            let data = response["data"] as? [String:Any] ?? [:]
            if !data.isEmpty
            {
                
                if let strStartTime = data["actual_travel_time_start"] as? String
                {
                    var dict = [String:Any]()
                    dict["title"] = "Out for Service"
                    dict["value"] = strStartTime
                    dict["subArr"] = [[String:Any]]()

                    var arrSub = [[String:Any]]()
                    
                    if let strEndTime = data["actual_travel_time_end"] as? String
                    {
                        dict["value"] = strEndTime

                        var dict2 = [String:Any]()
                        dict2["title"] = "Reached at Your Door"
                        dict2["value"] = strEndTime
                        arrSub.append(dict2)
                    }

                    var dict1 = [String:Any]()
                    dict1["title"] = "Started Journey"
                    dict1["value"] = strStartTime
                    arrSub.append(dict1)

                    dict["subArr"] = arrSub
                    
                    self.arrList.append(dict)
                }
                if let strTime  = data["employee_assignment_date_time"] as? String
                {
                    var dict = [String:Any]()
                    dict["title"] = "Technician accept your service request"
                    dict["value"] = strTime
                    dict["subArr"] = [[String:Any]]()
                    self.arrList.append(dict)
                }
                
                self.updatehandler.arrList = self.arrList
                self.tblUpdates.reloadData()
                self.tblUpdates.updateConstraintsIfNeeded()
                self.tblUpdates.layoutIfNeeded()
                self.conTblUpdatesHeight.constant = self.tblUpdates.contentSize.height


            }
            
        } failure: { (errorMsg) in
            
        }

    }
   

}
extension TECHICIAN_ON_MAP: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
    }

}
extension TECHICIAN_ON_MAP : ServerRequestDelegate
{
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...".localized)
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
}
