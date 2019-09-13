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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Alamofire.request("http://ec2-3-15-177-123.us-east-2.compute.amazonaws.com:3000/items").responseJSON {response in
            do {
                let json = try JSON(data: response.data!)
                self.item_title.text = json["items"][0]["title"].string
                self.item_des.text = json["items"][0]["description"].string
                self.item_price.text = json["items"][0]["price"].string
                
                let url = URL(string: json["items"][0]["image_url"].string!)
                let data = try? Data(contentsOf: url!)
                self.iteam_image.image = UIImage(data: data!)
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
