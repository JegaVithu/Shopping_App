//
//  ItemsViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/9/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet weak var add_button: UIBarButtonItem!
    
    var model : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hide Add button base on the mode
        if(model == false){
            self.navigationItem.rightBarButtonItem = nil
        }
        else{
            self.navigationItem.rightBarButtonItem = self.add_button
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
