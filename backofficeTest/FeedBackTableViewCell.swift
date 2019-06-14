//
//  FeedBackTableViewCell.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/14.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class FeedBackTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var feedBackAccountImage: UIImageView!
    @IBOutlet weak var feedBackAccountidLabel: UILabel!
    @IBOutlet weak var feedBackContentTextView: UITextView!
    @IBOutlet weak var feedBackProductImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
