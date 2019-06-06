//
//  Homeimage.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Homeimage {
    var title: String!
    var animation = [UIImage]()
    var images = [UIImage]()
    
    init(title: String , animation : [UIImage] , images: [UIImage]) {
        self.title = title
        self.animation = animation
        self.images = images
    }
    
}
