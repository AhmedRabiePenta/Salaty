//
//  ViewController.swift
//  Salaty
//
//  Created by ahmed on 9/11/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate  {
   

var locationManager = CLLocationManager()
    @IBOutlet weak var loadingPhrase: UILabel!
    @IBOutlet weak var locationPhrase: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
    }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homePage") as? HomePage
            if self.locationManager.location != nil {
                vc?.location = self.locationManager.location
            }
            self.navigationController?.setViewControllers([vc!], animated: false)
            //self.present(vc!, animated: true, completion: nil)
            
        })


}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

