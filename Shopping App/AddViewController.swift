//
//  AddViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/22/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import  MapKit
import Alamofire
import SwiftyJSON


class AddViewController: UIViewController {
    @IBOutlet weak var item_title: UITextField!
    @IBOutlet weak var item_descri: UITextView!
    @IBOutlet weak var item_price: UITextField!
    @IBOutlet weak var item_image: UIImageView!
    
    var locManager = CLLocationManager()
    var log : Double = 8.00
    var lat : Double = 9.00
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //get current location
        var _: CLLocation!
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            lat = currentLocation.coordinate.latitude
            log = currentLocation.coordinate.longitude
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }
    
    @IBAction func Upload(_ sender: UIButton) {
        let parameters = ["title": item_title.text!, "description":item_descri.text!, "price": item_price.text!, "longitude":log, "latitude":lat] as [String : Any]
        
        Alamofire.request("http://ec2-3-15-177-123.us-east-2.compute.amazonaws.com:3000/items", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.result)
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
