//
//  SecondViewController.swift
//  DevBootcamp
//
//  Created by Dide van Berkel on 24-03-16.
//  Copyright © 2016 Gary Grape Productions. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    var locationManager: CLLocationManager!
    
    let addresses = [
        "Erasmuspark 1,1056 LE Amsterdam",
        "De Clercqstraat 129,1053 AK Amsterdam",
        "Overtoom 160-162,1054 HP Amsterdam"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        locationManager = CLLocationManager()
        
        for add in addresses {
            getPlaceMarkFromAddress(add)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootCampAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.blueColor()
            annoView.animatesDrop = true
            return annoView
        } else if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        return nil
    }
    
    func createAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootCampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    func getPlaceMarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    //we have a valid location with coordinates.
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
}

