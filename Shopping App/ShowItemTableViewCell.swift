//
//  ShowItemTableViewCell.swift
//  Shopping App
//
//  Created by Vithusan Vithu on 9/22/19.
//  Copyright © 2019 Nandun Bandara. All rights reserved.
//

import UIKit

class ShowItemTableViewCell: UITableViewCell {
    @IBOutlet weak var item_image: UIImageView!
    @IBOutlet weak var item_title: UILabel!
    @IBOutlet weak var item_price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
