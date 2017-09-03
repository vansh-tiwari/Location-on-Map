//
//  ViewController.swift
//  location
//
//  Created by Ashok on 7/11/17.
//  Copyright © 2017 Forth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var alt: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        if(Double(location.speed) < 0 ){
            speed.text = "0 km/h"
        }else{
            speed.text = String(Int(location.speed * 3.6)) + String(" km/h")
        }
        alt.text = String(Int(location.altitude)) + String(" m")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        UIApplication.shared.isIdleTimerDisabled =  true
    }
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }

}

