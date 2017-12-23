//
//  MapViewController.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    let UTD_CENTER_LAT = 32.9859896
    let UTD_CENTER_LONG = -96.7517943
    var mapView: GMSMapView?
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a
        runTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        // Create a GMSCameraPosition
        let camera = GMSCameraPosition.camera(withLatitude: UTD_CENTER_LAT, longitude: UTD_CENTER_LONG, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        view = mapView
    }
    
    func updateMarkers(){
        let cabs = CabManager.shared.getCabs()
        for key in cabs.keys{
            var currentCab = cabs[key]!
            if(currentCab.marker == nil){
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: Double(currentCab.latitude)!, longitude: Double(currentCab.longitude)!)
                marker.title = currentCab.name
                marker.snippet = currentCab.moved
                marker.map = mapView
                currentCab.marker = marker
            }else{
                var marker = currentCab.marker
                marker?.position = CLLocationCoordinate2D(latitude: Double(currentCab.latitude)!, longitude: Double(currentCab.longitude)!)
            }
        }
    }
    
    @objc func updateData(){
        NetworkUtils.makeRequest()
        updateMarkers()
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

}

