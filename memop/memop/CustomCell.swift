//
//  CustomCell.swift
//  memop
//
//  Created by 徳永勇希 on 2020/08/24.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var taitollabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
