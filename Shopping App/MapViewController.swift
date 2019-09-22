//
//  MapViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/14/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    @IBOutlet weak var Seller_location: MKMapView!
    
    var data: JSON?
    var model : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Location data")
        print(data!)
        // Do any additional setup after loading the view.
        
        //coordinated get from backend
        
                if let data = data {
                let lat = Double(data["latitude"].string!)
                let lon = Double(data["longitude"].string!)

//                // show artwork on map
                let artwork = Artwork(title: "Seller Location",
                                      locationName: "Seller Location",
                                      discipline: "Seller Location",
                                      coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: lon!))
                self.Seller_location.addAnnotation(artwork)
        }
        
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LocationBack") {
            // pass data to next view
            
            let viewController = segue.destination as! SingleItemViewController
            let secondViewcontroller = viewController.topViewController as! ItemSingleViewController
            secondViewcontroller.data = data
            secondViewcontroller.model = model
            
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
