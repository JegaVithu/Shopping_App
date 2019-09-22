//
//  ViewController.swift
//  Shopping App
//
//  Created by SE on 9/7/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var view_mode: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Items") {
            // pass data to next view
            let model_login : Bool = view_mode.isOn
            let viewController = segue.destination as! ItemsUINavigationController
            let secondViewcontroller = viewController.viewControllers.first as! ItemsViewController
            secondViewcontroller.model = model_login

        }
    }
//
    

    @IBAction func Login_action(_ sender: UIButton) {
        let username = Username.text
        let password = Password.text
        
        
        
        if(username == "" || password == "")
        {
            let alertController = UIAlertController(title: "ERORR", message:
                "Please Enter USER NAME and PASSWORD !!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        else{
            
            Auth.auth().signIn(withEmail: username!, password: password!) { [weak self] user, error in
                //guard let strongSelf = self else { return }
                if let error = error {
                    let alertController = UIAlertController(title: "ERORR", message:
                        "Please Check Your USER NAME and PASSWORD !! -- > Error : " + error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self?.present(alertController, animated: true, completion: nil)
                    return
                }
                
                self?.performSegue(withIdentifier: "Items", sender: self)
                
            }
            
            
            
        }
    }
    
}

