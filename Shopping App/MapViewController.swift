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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //coordinated get from backend
        
        Alamofire.request("http://ec2-3-15-177-123.us-east-2.compute.amazonaws.com:3000/items").responseJSON {response in
            do {
                let json = try JSON(data: response.data!)
                let lat = Double(json["items"][0]["latitude"].string!)
                let lon = Double(json["items"][0]["longitude"].string!)

//                // show artwork on map
                let artwork = Artwork(title: "Seller Location",
                                      locationName: "Seller Location",
                                      discipline: "Seller Location",
                                      coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: lon!))
                self.Seller_location.addAnnotation(artwork)

            }
            catch {
                print(error)
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
