//
//  ItemSingleViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/13/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ItemSingleViewController: UIViewController {
    @IBOutlet weak var item_title: UILabel!
    @IBOutlet weak var item_des: UITextView!
    @IBOutlet weak var item_price: UILabel!
    @IBOutlet weak var iteam_image: UIImageView!
    
    var data: JSON?
    var model : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data!)
        // Do any additional setup after loading the view.
        
        //Load data
        if let data = data {
                self.item_title.text = data["title"].string
                self.item_des.text = data["description"].string
                self.item_price.text = data["price"].string
                let array = data["image_url"].string!.components(separatedBy: ",")
                let url = URL(string: array[0])
                let data = try? Data(contentsOf: url!)
                self.iteam_image.image = UIImage(data: data!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Location") {
            // pass data to next view
            
            let viewController = segue.destination as! ItemLocationViewController
            let secondViewcontroller = viewController.topViewController as! MapViewController
            secondViewcontroller.data = data
            secondViewcontroller.model = model
            
        }
        
        if (segue.identifier == "SingleBack") {
            // pass data to next view
            
            let viewController = segue.destination as! ItemsUINavigationController
            let secondViewcontroller = viewController.topViewController as! ItemsViewController
            secondViewcontroller.model = model
            
        }
    }
    
    //Location
    //SingleBack

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
