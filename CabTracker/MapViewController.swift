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
    
    // Coordinates for center of UTD
    let UTD_CENTER_LAT = 32.9859896
    let UTD_CENTER_LONG = -96.7517943
    
    // Used to hold reference to the mapview
    var mapView: GMSMapView?
    
    // Instance of the CabIcon, initialized once to save memory
    // because it is used multiple times
    let CAB_ICON = UIImage(named:"golf-cart")?.withRenderingMode(.alwaysOriginal)
    
    // timer used to recurrently update data
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // when the view will appear, update info on map and run the timer
    override func viewWillAppear(_ animated: Bool) {
        updateMap()
        runTimer()
    }
    
    // when we view will disappear, stop the tiemr to stop loading data in the background
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        print("timer stopped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // initialize the mapview
    // show the user location on the map
    // set the view as the mapview
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
    
    // get all the cabs from the manager
    // show/hide/create cabs in map depending on conditions
    // update cabs in manager with created markers
    func updateMap(){
        var cabs = CabManager.shared.getCabs()
        for key in cabs.keys{
            var currentCab = cabs[key]!
            let shouldAppear = currentCab.trackingEnabled
            
            if(currentCab.marker == nil && shouldAppear){
                print("\(currentCab.name): creating new marker")
                createMarker(cab: &currentCab)
            }else if (currentCab.marker != nil && shouldAppear){
                print("\(currentCab.name): updating existing marker position")
                updateMarker(cab: &currentCab)
            }else if (currentCab.marker != nil && !shouldAppear){
                print("\(currentCab.name): hiding maker")
                currentCab.marker?.map = nil
            }else{
                print("\(currentCab.name): not creating marker")
            }
            cabs[key] = currentCab
        }
        CabManager.shared.updateCabs(cabs: cabs)
    }
    
    // creates a marker for a cab
    func createMarker(cab: inout CabModel){
        let marker = GMSMarker()
        
        marker.position = getNewCoordinate(cab: cab)
        marker.title = cab.name
        marker.snippet = cab.moved
        marker.map = (view as! GMSMapView)
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.rotation = getRotation(cab: cab)
        marker.icon = CAB_ICON
        cab.marker = marker
    }
    
    // creates a CLLocationCoordinate2D from CabModel
    func getNewCoordinate(cab: CabModel) -> CLLocationCoordinate2D{
        let lat = Double(cab.latitude)!
        let long = Double(cab.longitude)!
        let newCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        return newCoordinate
    }
    
    // calculates roation for marker from CabModel
    func getRotation(cab: CabModel) -> Double{
        let heading = Double(cab.heading)
        let rotation = heading - 90
        return rotation
    }
    
    // update marker position and rotation
    func updateMarker(cab: inout CabModel){
        cab.marker!.position = getNewCoordinate(cab: cab)
        cab.marker!.rotation = getRotation(cab: cab)
        cab.marker!.map = (view as! GMSMapView)
    }
    
    @objc func updateData(){
        NetworkUtils.makeRequest()
        updateMap()
    }

    func runTimer() {
        print("timer started")
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

}

