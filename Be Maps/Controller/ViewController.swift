//
//  ViewController.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 07/11/2024.
//

import UIKit
import GoogleMaps
import Firebase

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var switchVisible: UISwitch!
    @IBOutlet weak var mapview: GMSMapView!
    
    var locationManager:CLLocationManager!
    var ref = Database.database().reference()
    var dataList : [PathM] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        StartLocation()
        mapview.delegate = self
        getPathUser()
    }
    
    func StartLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
       let lat = userLocation.coordinate.latitude
       let lon = userLocation.coordinate.longitude
        
        let userTrack = ref.child("LocationUser").child(String(Shared.shared.getUserId() ?? 0))
        let input = ["LocUserLat":"\(lat)",
                     "LocUserLong":"\(lon)"]
        userTrack.setValue(input)
        
        mapview.clear()
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 17)
        self.mapview.camera = camera
                
                let marker = GMSMarker()
                marker.position = location
                marker.icon = UIImage(named: "Pin")
                marker.map = self.mapview
        getLocationUsers()
    }
    func getLocationUsers(){
        ref.child("LocationUser").observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
               return
           }
            let lat = Double(dictionary["LocUserLat"] as? String ?? "")
            let long = Double(dictionary["LocUserLong"] as? String ?? "")
            let location = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
            let marker = GMSMarker()
            marker.position = location
            marker.icon = UIImage(named: "Pin")
            marker.map = self.mapview
        })
        
    }

    func getPathUser(){
        ref.child("LocationUser").child("\(Shared.shared.getUserId() ?? 0)").observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
               return
           }
            let obj = PathM(lat: dictionary["LocUserLat"] as? String, long: dictionary["LocUserLong"] as? String)
           self.dataList.append(obj)
        })
    }
    func userPath() {
       var paths = [GMSMutablePath]()
       let path = GMSMutablePath()
       for i in dataList{
           let long = Double(i.long)
           let lat = Double(i.lat)
           path.add(CLLocationCoordinate2D(latitude: lat! , longitude: long! ))
           paths.append(path)
       }
       for path in paths {
           let polygon = GMSPolyline(path: path)
           polygon.strokeColor = .red
           polygon.strokeWidth = 2
           polygon.map = mapview
       }
   }
    
    @IBAction func btnLogout(_ sender: Any) {
        Shared.shared.setIsLogin(bool: false)
        self.dismiss(animated: true)
    }
    @IBAction func btnPath(_ sender: Any) {
        userPath()
    }
    @IBAction func btnListUsers(_ sender: Any) {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListUsersVC")
        self.present(rootVC, animated: true)
    }
    @IBAction func switchPressed(_ sender: Any) {
        if switchVisible.isOn {
            switchVisible.setOn(true, animated: true)
            let ref1 = ref.root.child("usersData").child("\(Shared.shared.getUserId() ?? 0)").updateChildValues(["status": "0"])
        } else {
            switchVisible.setOn(false, animated: true)
            let ref1 = ref.root.child("usersData").child("\(Shared.shared.getUserId() ?? 0)").updateChildValues(["status": "1"])
        }
    }
    
}

