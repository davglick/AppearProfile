//
//  AddressCell.swift
//  AppearLoginProfile
//
//  Created by Davin Glick on 18/10/16.
//  Copyright © 2016 Appear. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    @IBOutlet var addressStringLabel: UILabel!
    @IBOutlet var selectedAddressTick: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
