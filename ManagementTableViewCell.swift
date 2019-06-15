//
//  ManagementTableViewCell.swift
//  backofficeTest
//
//  Created by Joy on 2019/5/31.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var orderImage: UIImageView!        //訂單照片 用第一個商品
    @IBOutlet weak var orderidLabel: UILabel!          //訂單編號
    @IBOutlet weak var orderstatusLabel: UILabel!      //訂單狀態
    @IBOutlet weak var orderCostPointLabel: UILabel!   //訂單使用積分
    @IBOutlet weak var orderTotalPriceLabel: UILabel!  //訂單總金額
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
