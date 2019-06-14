//
//  ManagementDetailTableViewCell.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/8.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementDetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var productdetailImage: UIImageView!  //商品照片
    
    @IBOutlet weak var producdetailtName: UILabel!       //商品名稱
    @IBOutlet weak var productdetailPrice: UILabel!      //商品價格
    @IBOutlet weak var productdetailSize: UILabel!       //商品尺寸
    @IBOutlet weak var productdetailAmount: UILabel!     //商品數量
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
