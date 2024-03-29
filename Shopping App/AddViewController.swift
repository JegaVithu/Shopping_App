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
import FirebaseStorage


class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var item_title: UITextField!
    @IBOutlet weak var item_descri: UITextView!
    @IBOutlet weak var item_price: UITextField!
    @IBOutlet weak var item_image: UIImageView!
    
    var locManager = CLLocationManager()
    var log : Double = 8.00
    var lat : Double = 9.00
    var model : Bool = false
    
    var item_image_url = ""
    
    
    
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
        
        if(item_title.text == "" || item_price.text == "" || item_descri.text == "" || item_image.image == nil ){
            let alertController = UIAlertController(title: "ERORR", message:
                "YOU SHOULD FILL ALL FIELDS IN THIS FORM INCLUDE IMAGE ATTACH ALSO !!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else if(item_image_url == ""){
            
            let alertController = UIAlertController(title: "ERORR", message:
                "PLEASE WAIT FEW MINITES BECOZ IMAGE UPLOAD WILL BE TAKE LITTLE BIT TIME !!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else{
            let parameters = ["title": item_title.text!, "description":item_descri.text!, "price": item_price.text!, "longitude":log, "latitude":lat, "image_url":item_image_url] as [String : Any]
            
            Alamofire.request("http://ec2-3-15-177-123.us-east-2.compute.amazonaws.com:3000/items", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                print(response.result.isSuccess)
                
                if (response.result.isSuccess == true){
                    let alertController = UIAlertController(title: "SUCCESS", message:
                        "YOUR ITEM HAS SUCCESSFULLY POSTED !!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    self.item_title.text = ""
                    self.item_descri.text = ""
                    self.item_price.text = ""
                    self.item_image.image = nil
                    
                }
                else{
                    let alertController = UIAlertController(title: "ERORR", message:
                        "FAILD TRY AGAIN !!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
       
        
    }
    
    @IBAction func Image_Add(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if (segue.identifier == "AddBack") {
            // pass data to next view
            
            let viewController = segue.destination as! ItemsUINavigationController
            let secondViewcontroller = viewController.topViewController as! ItemsViewController
            secondViewcontroller.model = model
            
        }
    }
    
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //set the image in image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        item_image.image = image // profile image
        //imageData = image
        self.dismiss(animated: true, completion: nil)
        
        //upload data to firebase
        let number = Int.random(in: 0 ..< 1000000000000)
        let filename = String(number) + ".png"
        let image_data = image.pngData()
        let storageRef = Storage.storage().reference().child(filename)
        storageRef.putData(image_data!, metadata: nil) { (metadata, error) in
            if error != nil {
                //err
               
            } else {
                //success
                storageRef.downloadURL { (url, error) in
                    let image_url = url
                    self.item_image_url = image_url!.absoluteString
                    print(self.item_image_url)
                    let alertController = UIAlertController(title: "INFOR", message:
                        "IMAGE HAS UPLOADED SUCCESSFULLY. PLEASE CLICK ON UPLOAD BUTTON!!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
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
