//
//  RegisterViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/13/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var re_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.window?.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Register(_ sender: UIButton) {
        let Email_address = email.text
        let user_password = password.text
        
        if(Email_address == "" || user_password == "" || re_password.text == "" ){
            // check emnpty validation
            let alertController = UIAlertController(title: "ERORR", message:
                "Please Fill All Details !!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)

        }
        else if(user_password != re_password.text){
                // check both password validation
            let alertController = UIAlertController(title: "ERORR", message:
                "Please Re Enter Correct Password !!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)

        }
        else {
            
            Auth.auth().createUser(withEmail: Email_address! , password: user_password!) { authResult, error in
                //sigin validate
                guard let user = authResult?.user, error == nil else {
                    let alertController = UIAlertController(title: "ERORR", message:
                        "Createion Unsuccessfully Please Try Again !!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let alertController = UIAlertController(title: "ERORR", message:
                    "Account Successfully created using this email : " + user.email!, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
                self.email.text = ""
                self.password.text = ""
                self.re_password.text = ""
            }

        }
    }
    
    
}
