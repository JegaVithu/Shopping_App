//
//  ItemsViewController.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/9/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var item_table_view: UITableView!
    
    
    // Data model: These strings will be the data for the table view cells
    var data: JSON?
    var current_item: JSON?
    
    func datapull(){
        Alamofire.request("http://ec2-3-15-177-123.us-east-2.compute.amazonaws.com:3000/items").responseJSON {response in
            do {
                let json = try JSON(data: response.data!)
                self.data = json["items"]
                self.item_table_view.reloadData()
                //print(self.data)
            }
            catch {
                print(error)
            }
        }
    }

    
    @IBOutlet weak var add_button: UIBarButtonItem!
    
    var model : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hide Add button base on the mode
        //data pull fuction call
        datapull()
        if(model == false){
            self.navigationItem.rightBarButtonItem = nil
        }
        else{
            self.navigationItem.rightBarButtonItem = self.add_button
        }
        
        // Register the table view cell class and its reuse id
 self.item_table_view.register(UITableViewCell.self,forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.item_table_view.tableFooterView = UIView()

        
        // This view controller itself will provide the delegate methods and row data for the table view.
        item_table_view.delegate = self
        item_table_view.dataSource = self


    }
    
    //number of item listed here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            
            return data.count
            
        }
        else{
            return 0
        }
        //return self.data!.count
      

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
//        let cell = self.item_table_view.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? ShowItemTableViewCell
        var cell = item_table_view.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        }
        
        if let data = data {
            // set the text from the data model
        cell?.textLabel?.text = data[indexPath.row]["title"].string
            cell?.detailTextLabel?.text = "LKR " +  data[indexPath.row]["price"].string!
        let url = URL(string: data[indexPath.row]["image_url"].string!)
            let dataa = try? Data(contentsOf: url!)
            if let img = dataa{
                
                cell?.imageView?.image = UIImage(data: img)
            }
            

            
        }
       
        return cell!
        

    }
    
    // method to run when table view cell is tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data![indexPath.row])
        current_item = data![indexPath.row]
        self.performSegue(withIdentifier: "singleview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "singleview") {
            // pass data to next view
            
            let viewController = segue.destination as! SingleItemViewController
            let secondViewcontroller = viewController.topViewController as! ItemSingleViewController
             secondViewcontroller.data = current_item
            secondViewcontroller.model = model
           
        }
        
        if (segue.identifier == "add") {
            // pass data to next view
            
            let viewController = segue.destination as! AddItemViewController
            let secondViewcontroller = viewController.topViewController as! AddViewController
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
