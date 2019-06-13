//
//  ManagementDetailTableViewCell.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/8.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementDetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var productdetailImage: UIImageView!
    
    @IBOutlet weak var producdetailtName: UILabel!
    @IBOutlet weak var productdetailPrice: UILabel!
    
    @IBOutlet weak var productdetailAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
