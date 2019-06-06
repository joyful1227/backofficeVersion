//
//  Category.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit
import Foundation

class Category: Codable {
    
    var category_id: Int?
    var category_name: String?
    var category_image: String?
    
    public init(_ category_id: Int, _ category_name: String, _ category_image: String){
        self.category_id = category_id
        self.category_name = category_name
        self.category_image = category_image
    }
}
