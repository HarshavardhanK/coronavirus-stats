//
//  HomeViewController.swift
//  coronavirus-stats
//
//  Created by Harshavardhan K on 20/05/20.
//  Copyright © 2020 Harshavardhan K. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    //MARK:- UI Elements
    
    @IBOutlet var districtLabel: UILabel!
    @IBOutlet var confirmedRecovered: UILabel!
    @IBOutlet var confirmedDead: UILabel!
    @IBOutlet var confirmedPositive: UILabel!
    
    
    let URL = "https://api.covid19india.org/state_district_wise.json"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData(url: URL)
    }
    
    func fetchData(url: String) {
        
        let request = AF.request(url)
        
        request.responseJSON { (data) in
            let json = JSON(data.value)
            let district = json["Karnataka"]["districtData"]["Udupi"]
            
            let caseCount = Case(data: district)
            let home = Home(name: "Udupi", caseCount_: caseCount)
            
            print("\(home.caseCount?.totalPositive)) have been reported positive in Udupi")
            
            self.districtLabel.text = "Udupi"
            
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
