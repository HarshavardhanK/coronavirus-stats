//
//  HomeViewController.swift
//  coronavirus-stats
//
//  Created by Harshavardhan K on 20/05/20.
//  Copyright © 2020 Harshavardhan K. All rights reserved.
//

import UIKit
import CoreLocation

import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK:- UI Elements
    
    @IBOutlet var districtLabel: UILabel!
    @IBOutlet var confirmedRecovered: UILabel!
    @IBOutlet var confirmedDead: UILabel!
    @IBOutlet var confirmedPositive: UILabel!
    
    //MARK:- VARIABLES
    let locationManager = CLLocationManager()
    
    
    let DISTRICT_URL = "https://us-central1-covid19updates-8d9d1.cloudfunctions.net/district_data?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Do any additional setup after loading the view.
        fetchData(url: DISTRICT_URL)
        
    }
    
    func getLocation() -> CLLocation? {
        
        var currentLocation: CLLocation!
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse
            || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            
            currentLocation = locationManager.location
            
            return currentLocation
        }
        
        if(CLLocationManager.authorizationStatus() == .denied) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        print("Could not access your location")
        
        return nil
    }
    
    
    func fetchData(url: String) {
        
        guard let location = getLocation() else {
            return
        }
        
        let url = DISTRICT_URL + "latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)"
        
        let request = AF.request(url)
        
        request.responseJSON { (data) in
            
            guard let value = data.value else {
                return
            }
            
            let json = JSON(value)
            let district = json["district"].stringValue
          
            let caseCount = Case(data: json)
            let home = Home(name: district, caseCount_: caseCount)
            
            self.districtLabel.text = district
            
            if let positive = home.caseCount?.totalPositive {
                self.confirmedPositive.text = "\(String(describing: positive))"
            }
            
            if let dead = home.caseCount?.totalDeceased {
                self.confirmedDead.text = "\(String(describing: dead))"
            }
            
            if let recovered = home.caseCount?.totalRecovered {
                self.confirmedRecovered.text = "\(String(describing: recovered))"
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
