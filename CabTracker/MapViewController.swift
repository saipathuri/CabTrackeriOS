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
    let CAB_ICON = UIImage(named:"golf-cart")
    
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
        var cabs = CabManager.shared.getCabs()
        for key in cabs.keys{
            var currentCab = cabs[key]!
            let lat = Double(currentCab.latitude)!
            let long = Double(currentCab.longitude)!
            let newCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let heading = Double(currentCab.heading)
            let rotation = heading - 90
            
            if(currentCab.marker == nil){
                print("creating new marker")
                let marker = GMSMarker()
                marker.position = newCoordinate
                marker.title = currentCab.name
                marker.snippet = currentCab.moved
                marker.map = (view as! GMSMapView)
                marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                marker.rotation = rotation
                marker.icon = CAB_ICON
                currentCab.marker = marker
            }else{
                print("updating existing marker position")
                currentCab.marker!.position = newCoordinate
                currentCab.marker!.rotation = rotation
            }
            cabs[key] = currentCab
        }
        CabManager.shared.updateCabs(cabs: cabs)
    }
    
    @objc func updateData(){
        NetworkUtils.makeRequest()
        updateMarkers()
    }

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

}

