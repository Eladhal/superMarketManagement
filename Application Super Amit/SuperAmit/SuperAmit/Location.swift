//
//  Location.swift
//  SuperAmit
//
//  Created by elad halperin on 8/9/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class Location: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var MapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentLocation :CLLocation?
    
    @IBOutlet weak var WorkingHours: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// MARK: - Setup Location Manager:
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        ///
        self.MapView.showsUserLocation = true
        
        let storeAnnotation = MKPointAnnotation()
        var storeLocation = CLLocationCoordinate2DMake(32.072174, 34.778410)
        storeAnnotation.coordinate = storeLocation
        storeAnnotation.title = "SuperAmit"
        MapView.addAnnotation(storeAnnotation)
        let yourAnnotationAtIndex = 0
        MapView.selectAnnotation(MapView.annotations[yourAnnotationAtIndex], animated: true)

        
        

    }
    
    
    /// MARK: - Location Delegate Methods:
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
        self.MapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error:" + error.localizedDescription)
    }
    
    @IBAction func btnNavigate(sender: AnyObject) {
        
        var storeLocation = CLLocationCoordinate2DMake(32.072174, 34.778410)
        let currentLocMapItem = MKMapItem.mapItemForCurrentLocation()
        let selectedPlacemark = MKPlacemark(coordinate: storeLocation, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        let mapItems = [selectedMapItem, currentLocMapItem]
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMapsWithItems(mapItems, launchOptions:launchOptions)
        
        
    }
    
    @IBAction func btnWorkingHours(sender: AnyObject) {
        WorkingHours.hidden = false
    }

    @IBAction func btnRemoveWorkingHours(sender: AnyObject) {
         WorkingHours.hidden = true
        
    }
        

    
    
    
}
