//
//  MakeUpTableViewCell.swift
//  MakeUpApp
//
//  Created by TingxinLi on 12/18/18.
//  Copyright © 2018 TingxinLi. All rights reserved.
//

import UIKit

class MakeUpCell: UITableViewCell {

    @IBOutlet weak var priceTag: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
